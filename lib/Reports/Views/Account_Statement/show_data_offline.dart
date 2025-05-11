import '../../../Reports/controllers/Account_Statement_Controller.dart';
import '../../../Setting/models/bal_acc_d.dart';
import '../../../database/report_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

late Map<String, double> columnWidths = {
  'BADDO': double.nan,
  'AMKID': double.nan,
  'AMMNO': double.nan,
  'BADRE': double.nan,
  'SCID': double.nan,
  'BADMD': double.nan,
  'BADDA': double.nan,
  'BADEQ': double.nan,
  'BADBA': double.nan,
  'BADDE': double.nan,
};

class Show_Statment_offline extends StatefulWidget {
  @override
  _DataGridPageState createState() => _DataGridPageState();
}

class _DataGridPageState extends State<Show_Statment_offline> {
  final Account_Statement_Controller controller = Get.find();
  late ProductDataGridSource dataSource;
  @override
  Widget build(BuildContext context) {
    return  GetBuilder<Account_Statement_Controller>(
        init: Account_Statement_Controller(),
        builder: ((value) =>FutureBuilder(
      future: getProductDataSource(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? SfDataGridTheme(
              data: SfDataGridThemeData(
                headerColor: const Color(0xFFECEFF0),
              ),
              child: SfDataGrid(
                allowSwiping: false,
                //allowSorting: true,
                columnWidthMode: ColumnWidthMode.fill,
                source: snapshot.data,
                columns: getColumns(),
                frozenColumnsCount: 1,
                allowColumnsResizing: false,
                onColumnResizeUpdate: (ColumnResizeUpdateDetails details) {
                  setState(() {
                    columnWidths[details.column.columnName] = details.width;
                  });
                  return true;
                },
              ),
            )
            : const Center(
          child: CircularProgressIndicator(
            strokeWidth: 5,
          ),
        );
      },
    )));
  }


  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await GET_BIL_ACC_D(controller.SelectDataAANO.toString(),
        controller.SelectTYPE_CUR.toString(),controller.SelectDataSCID.toString(),controller.NOT_INC_LAS,
        controller.SelectDataSSID.toString());
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'BADDO',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSMDED2'.tr, style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'AMKID',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringType'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'AMMNO',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSMMID'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BADRE',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringBMMNO'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      controller.SelectTYPE_CUR=='2'?GridColumn(
          columnName: 'SCID',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child: Text('StringSCIDlableText'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))): GridColumn(
          columnName: 'SCID',
          width: 1,
          label: Container(
              )),
      GridColumn(
          columnName: 'BADMD',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child: Text('StringAMDMD'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BADDA',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringAMDDA'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BADEQ',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringTotalequivalent'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BADBA',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringBAL_ACC'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'BADDE',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text('StringDetails'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
    ];
  }
}

class ProductDataGridSource extends DataGridSource {
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  final Account_Statement_Controller controller = Get.find();
  late List<DataGridRow> dataGridRows;
  late List<Bal_Acc_D_Local> productList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[0].value.toString()=='null'?'':row.getCells()[0].value.toString().substring(0,11),
            overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[1].value.toString()=='null'?'': row.getCells()[10].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[2].value.toString()=='null'?'': row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
          alignment: Alignment.center,
          child: Text(row.getCells()[3].value.toString()=='null'?'':
          row.getCells()[3].value.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )),
      controller.SelectTYPE_CUR=='2'?Container(
          alignment: Alignment.center,
          child: Text(
              row.getCells()[4].value.toString()=='null'?'':row.getCells()[4].value.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )):Container(),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[5].value.toString()=='null'?'':row.getCells()[5].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[6].value.toString()=='null'?'':row.getCells()[6].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[7].value.toString()=='null'?'':row.getCells()[7].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[8].value.toString()=='null'?'':row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[9].value.toString()=='null'?row.getCells()[1].value.toString()=='null'?'---*ر.سابق*---':'': row.getCells()[9].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;

  // @override
  // Widget? buildTableSummaryCellWidget(
  //     GridTableSummaryRow summaryRow,
  //     GridSummaryColumn? summaryColumn,
  //     RowColumnIndex rowColumnIndex,
  //     String summaryValue) {
  //   return Container(
  //     padding: const EdgeInsets.all(15.0),
  //     child: Text(summaryValue),
  //   );
  // }
  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'BADDO', value: dataGridRow.BADDO),
        DataGridCell(columnName: 'AMKID', value: dataGridRow.AMKID),
        DataGridCell(columnName: 'AMMNO', value: dataGridRow.AMMNO),
        DataGridCell(columnName: 'BADRE', value: dataGridRow.BADRE),
        DataGridCell(columnName: 'SCID', value: dataGridRow.SCID),
        DataGridCell(columnName: 'BADMD', value: dataGridRow.BADMD),
        DataGridCell(columnName: 'BADDA', value: dataGridRow.BADDA),
        DataGridCell(columnName: 'BADEQ', value: dataGridRow.BADEQ),
        DataGridCell<String>(columnName: 'BADBA', value: dataGridRow.BADBA),
        DataGridCell<String>(columnName: 'BADDE', value: dataGridRow.BADDE),
        DataGridCell<String>(columnName: 'AMKNA_D', value: dataGridRow.AMKNA_D),
        // DataGridCell<DateTime>(
        //     columnName: 'orderDate', value: dataGridRow.SMMID),
      ]);
    }).toList(growable: false);
  }
  void updateDataSource() {
    notifyListeners();
  }
}
