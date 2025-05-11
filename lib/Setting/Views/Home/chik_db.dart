import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'dart:async';
import '../../../Widgets/theme_helper.dart';
import '../../../database/database.dart';

class CHIK_DB_View extends StatefulWidget {
  @override
  _FAS_ACC_USR_ViewState createState() => _FAS_ACC_USR_ViewState();
}

class _FAS_ACC_USR_ViewState extends State<CHIK_DB_View> {
  Database? _database;
  final conn = DatabaseHelper.instance;
  List<String> _tables = [];
  String? _selectedTable;
  List<Map<String, dynamic>> _tableData = [];
  List<String> _columns = [];
  String _searchQuery = '';
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _fetchTables();
  }

  Future<void> _fetchTableData(String tableName) async {
    try {
      var _database = await conn.database;
      if (_database != null && _database.isOpen) {
        String whereClause = '';
        if (_searchQuery.isNotEmpty && _columns.isNotEmpty) {
          whereClause = "WHERE " +
              _columns.map((col) => "$col LIKE '%$_searchQuery%'").join(" OR ");
        }

        List<Map<String, dynamic>> data = await _database.rawQuery(
          'SELECT * FROM $tableName $whereClause',
        );

        setState(() {
          _tableData = data;
          _columns = data.isNotEmpty ? data.first.keys.toList() : [];
        });
      }
    } catch (e) {
      print('خطأ في جلب البيانات للجدول $tableName: $e');
    }
  }

  Future<void> _fetchTables() async {
    try {
      var _database = await conn.database;
      if (_database != null) {
        List<Map<String, dynamic>> tables = await _database.rawQuery(
            "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%';");

        setState(() {
          _tables = tables.map((table) => table['name'].toString()).toList();
        });
      }
    } catch (e) {
      print('Error fetching tables: $e');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = query;
        _tableData = [];
      });
      if (_selectedTable != null) {
        _fetchTableData(_selectedTable!);
      }
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _database?.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('بيانات الجدوال'),
      body: Column(
        children: [
          // حقل البحث مع زر التحديث
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _onSearchChanged,
                    decoration: InputDecoration(
                      labelText: 'بحث',
                      labelStyle: TextStyle(color: Colors.red),
                      prefixIcon: Icon(Icons.search, color: Colors.red),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.red),
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, color: Colors.red),
                  onPressed: () {
                    if (_selectedTable != null) {
                      _fetchTableData(_selectedTable!);
                    }
                  },
                ),
              ],
            ),
          ),

          // قائمة الجداول
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: DropdownButtonFormField<String>(
              value: _selectedTable,
              hint: Text('اختر جدولًا', style: TextStyle(color: Colors.red)),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
              ),
              items: _tables.map((table) {
                return DropdownMenuItem(
                  value: table,
                  child: Text(table, style: TextStyle(fontSize: 16)),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedTable = value;
                  _tableData = [];
                  _columns = [];
                });
                if (value != null) {
                  _fetchTableData(value);
                }
              },
            ),
          ),

          // عداد الصفوف
          if (_tableData.isNotEmpty || _searchQuery.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'عدد النتائج: ${_tableData.length}',
                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),

          // عرض البيانات باستخدام Syncfusion DataGrid
          Expanded(
            child: _selectedTable == null
                ? Center(
              child: Text(
                'يرجى اختيار جدول من القائمة',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            )
                : _columns.isEmpty
                ? Center(
              child: Text(
                _searchQuery.isNotEmpty
                    ? 'لا توجد نتائج تلائم البحث'
                    : 'لا توجد بيانات لعرضها في الجدول "$_selectedTable"',
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            )
                : Card(
              margin: EdgeInsets.all(12.0),
              shape: RoundedRectangleBorder(
             //   side: BorderSide(color: Colors.red, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: SfDataGrid(
                source: _TableDataSource(_tableData, _columns),
                columnWidthMode: ColumnWidthMode.fitByCellValue,
                columns: _columns.map((col) => GridColumn(
                    columnName: col,
                    label: Container(
                      color: Colors.grey[100],
                     // height: 40,
                    ),
                  ),
                )
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _TableDataSource extends DataGridSource {
  final List<Map<String, dynamic>> data;
  final List<String> columns;

  _TableDataSource(this.data, this.columns);

  @override
  List<DataGridRow> get rows =>
      data
          .map(
            (row) =>
            DataGridRow(
              cells: columns
                  .map(
                    (col) =>
                    DataGridCell<String>(
                        columnName: col, value: row[col]?.toString() ?? ''),
              )
                  .toList(),
            ),
      )
          .toList();

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(
      cells: row.getCells().map((cell) {
        return Container(
          padding: EdgeInsets.all(8.0),
          alignment: Alignment.centerLeft,
          child: Text(
            cell.value ?? '',
            style: TextStyle(color: Colors.black87),
          ),
        );
      }).toList(),
    );
  }
}