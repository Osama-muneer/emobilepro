import '../../../Reports/controllers/Account_Statement_Controller.dart';
import '../../../Setting/models/acc_sta_d.dart';
import '../../../database/report_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

late Map<String, double> columnWidths = {
  'ATC11': double.nan,
  'ATC12': double.nan,
  'ATC2': double.nan,
  'ATC13': double.nan,
  'ATC20': double.nan,
  'ATC22': double.nan,
  'ATC23': double.nan,
  'ATC26': double.nan,
  'ATC15': double.nan,
  'ATC21': double.nan,
};

class Show_Acc_Statment extends StatefulWidget {
  @override
  _DataGridPageState createState() => _DataGridPageState();
}

class _DataGridPageState extends State<Show_Acc_Statment> {
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
                // tableSummaryRows: [
                //   GridTableSummaryRow(
                //       showSummaryInRow: true,
                //       title: 'Total Salary: {Sum} for 20 employees',
                //       columns: [
                //         const GridSummaryColumn(
                //             name: 'Sum',
                //             columnName: 'salary',
                //             summaryType: GridSummaryType.sum)
                //       ],
                //       position: GridTableSummaryRowPosition.bottom)
                // ],
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
    var productList = await GET_ACC_Statement(controller.GUID);
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns() {
    return <GridColumn>[
      GridColumn(
          columnName: 'ATC11',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                controller.SelectDataSSID=='203'?'StringAccount_NO'.tr:'StringSMDED2'.tr, style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'ATC12',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  controller.SelectDataSSID=='203'?'StringAANO'.tr:'StringType'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName:controller.SelectDataSSID=='203'? 'ATC1': 'ATC2',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  controller.SelectDataSSID=='203'?'StringLast_Balance_R'.tr:'StringSMMID'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      if(controller.SelectDataSSID!='203')
      GridColumn(
          columnName: 'ATC13',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringBMMNO'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      controller.SelectTYPE_CUR=='2'?
      GridColumn(
          columnName: 'ATC20',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child: Text('StringSCIDlableText'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))):
      GridColumn(
          columnName: 'ATC20',
          width: 1,
          label: Container(
              )),
      GridColumn(
          columnName: 'ATC22',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child: Text('StringAMDMD'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'ATC23',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringAMDDA'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      controller.EQ_V ?
      GridColumn(
          columnName: 'ATC26',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringTotalequivalent'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))):
      GridColumn(
          columnName: 'ATC26',
          width: 1,
          label: Container()),
      GridColumn(
          columnName:controller.SelectDataSSID=='203'?'ATC4': 'ATC15',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  controller.SelectDataSSID=='203'?'StringCurrent_Balance'.tr
                      :'StringBAL_ACC'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName:controller.SelectDataSSID=='203'?'ATC17' : 'ATC21',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(controller.SelectDataSSID=='203'?'StringAddress'.tr
                  :'StringDetails'.tr,style: const TextStyle(fontFamily: 'Hacen')
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
  late List<Acc_Sta_D_Local> productList;

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[0].value.toString()=='null'?'':row.getCells()[0].value.toString(),
            overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[1].value.toString()=='null'?'': row.getCells()[1].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            controller.SelectDataSSID=='203'?
            row.getCells()[10].value.toString()=='null'?'':
            controller.formatter.format(row.getCells()[10].value).toString()
                :  row.getCells()[2].value.toString()=='null'?'':row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      if(controller.SelectDataSSID!='203')
      Container(
          alignment: Alignment.center,
          child: Text(row.getCells()[3].value.toString()=='null'?'':
          row.getCells()[3].value.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )),
      controller.SelectTYPE_CUR=='2'?
      Container(
          alignment: Alignment.center,
          child: Text(
              row.getCells()[4].value.toString()=='null'?'':row.getCells()[4].value.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )):
      Container(),
      Container(
        alignment: Alignment.center,
        child: Text(
            controller.SelectDataSSID=='203'?
            row.getCells()[2].value.toString()=='null'?'':
            controller.formatter.format(row.getCells()[2].value).toString()
            : row.getCells()[5].value.toString()=='null'?'':row.getCells()[5].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            controller.SelectDataSSID=='203'?
            row.getCells()[11].value.toString()=='null'?'':
            controller.formatter.format(row.getCells()[11].value).toString()
            : row.getCells()[6].value.toString()=='null'?'':row.getCells()[6].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      controller.EQ_V ?
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[7].value.toString()=='null'?'':row.getCells()[7].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ):
      Container(),
      Container(
        alignment: Alignment.center,
        child: Text(
            controller.SelectDataSSID=='203'?
            row.getCells()[12].value.toString()=='null'?'':
            controller.formatter.format(row.getCells()[12].value).toString()
            : row.getCells()[8].value.toString()=='null'?'':
            row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style:  TextStyle(fontFamily: 'Hacen',color:
            controller.SelectDataSSID=='203'?row.getCells()[12].value<0?Colors.red:
            Colors.black:Colors.black)
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            controller.SelectDataSSID=='203'?
            row.getCells()[13].value.toString()=='null'?'':
            row.getCells()[13].value.toString()
            : row.getCells()[9].value.toString()=='null'?'': row.getCells()[9].value.toString(),
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
    dataGridRows = ACC_STA_DDataList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'ATC11', value: dataGridRow.ATC11),
        DataGridCell(columnName: 'ATC12', value: dataGridRow.ATC12),
        DataGridCell(columnName: 'ATC2', value: dataGridRow.ATC2),
        DataGridCell(columnName: 'ATC13', value: dataGridRow.ATC13),
        DataGridCell(columnName: 'ATC20', value: dataGridRow.ATC20),
        DataGridCell(columnName: 'ATC22', value: dataGridRow.ATC22),
        DataGridCell(columnName: 'ATC23', value: dataGridRow.ATC23),
        DataGridCell(columnName: 'ATC26', value: dataGridRow.ATC26),
        DataGridCell<String>(columnName: 'ATC15', value: dataGridRow.ATC15),
        DataGridCell<String>(columnName: 'ATC21', value: dataGridRow.ATC21),
        DataGridCell(columnName: 'ATC1', value: dataGridRow.ATC1),
        DataGridCell(columnName: 'ATC3', value: dataGridRow.ATC3),
        DataGridCell(columnName: 'ATC4', value: dataGridRow.ATC4),
        DataGridCell(columnName: 'ATC17', value: dataGridRow.ATC17),
        // DataGridCell<DateTime>(
        //     columnName: 'orderDate', value: dataGridRow.SMMID),
      ]);
    }).toList(growable: false);
  }
  void updateDataSource() {
    notifyListeners();
  }
}
