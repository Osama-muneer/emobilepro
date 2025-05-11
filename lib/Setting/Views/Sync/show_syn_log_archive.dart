import 'dart:async';
import '../../../Setting/models/syn_log.dart';
import '../../../database/report_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';


class Show_Syn_LogGrid_archive extends StatefulWidget {
  @override
  _DataGridPageState createState() => _DataGridPageState();
}

class _DataGridPageState extends State<Show_Syn_LogGrid_archive> {
  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await  GET_SYN_LOG();
    return ProductDataGridSource(productList);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getProductDataSource(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? SfDataGridTheme(
              data: SfDataGridThemeData(
                headerColor: const Color(0xFFECEFF0),
              ),
              child: SfDataGrid(
                allowSwiping: false,
                allowSorting: true,
                columnWidthMode: ColumnWidthMode.fill,
                source: snapshot.data,
                columns: getColumns(),
              ),
            )
            : const Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
          ),
        );
      },
    );
  }


  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'SLSQ',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  '----'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SLDO',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSMDED2'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SOTT',
          columnWidthMode: ColumnWidthMode.auto,
          width:  140,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  '-----',style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SOTY',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringType'.tr, style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'SLIN',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                '-------', style: const TextStyle(fontFamily: 'Hacen'),
              ))),

    ];
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Syn_Log_Local> productList;
 // final controller2=Get.put(Sale_Invoices_Controller());
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return  DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        child:  Text(row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child:  Text(row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[2].value.toString()=='D'
            ? 'Download'.tr:'Upload'.tr,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),

    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  @override
  String calculateSummaryValue(GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn, RowColumnIndex rowColumnIndex) {
    List<double> getCellValues(GridSummaryColumn summaryColumn) {
     // List<double> values = getCellValues(summaryColumn).cast<double>();
      final List<double> values = <double>[];
      for (final DataGridRow row in rows) {
        final DataGridCell? cell = row.getCells().firstWhereOrNull(
                (DataGridCell element) =>
            element.columnName == summaryColumn.columnName);
        if (cell != null && cell.value != null) {
          values.add(cell.value);
        }
      }
      return values;
    }

    String? title = summaryRow.title;
    if (title != null) {
      if (summaryRow.showSummaryInRow && summaryRow.columns.isNotEmpty) {
        for (final GridSummaryColumn summaryColumn in summaryRow.columns) {
          if (title!.contains(summaryColumn.name)) {
            double deviation = 0;
             List<double> values = getCellValues(summaryColumn).cast<double>();
            if (values.isNotEmpty) {
           //   double sum = values+1;
              deviation = 2;
            }
            title = title.replaceAll(
                '{${summaryColumn.name}}', deviation.toString());
          }
        }
      }
    }
    return title ?? '';
  }

  @override
  Widget? buildTableSummaryCellWidget(
      GridTableSummaryRow summaryRow,
      GridSummaryColumn? summaryColumn,
      RowColumnIndex rowColumnIndex,
      String summaryValue) {
    return Container(
      padding: const EdgeInsets.all(15.0),
      child: Text(summaryValue),
    );
  }

  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'SLDO', value: dataGridRow.SLDO),
        DataGridCell(columnName: 'SOTT', value: dataGridRow.SOTT),
        DataGridCell(columnName: 'SOTY', value: dataGridRow.SOTY),
        DataGridCell(columnName: 'SLIN', value: dataGridRow.SLIN),
        DataGridCell(columnName: 'SLSQ', value: dataGridRow.SLSQ),
      ]);
    }).toList(growable: false);
  }

  void updateDataSource() {
    notifyListeners();
  }
}
