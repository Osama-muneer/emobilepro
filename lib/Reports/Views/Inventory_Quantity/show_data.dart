import 'dart:math';
import '../../../Reports/controllers/sto_num_controller.dart';
import '../../../Setting/models/sto_num_local.dart';
import '../../../database/sto_num_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:intl/intl.dart' as intl;

late Map<String, double> columnWidths = {
  'MINA': double.nan,
  'MUNA': double.nan,
  'SNNO': double.nan,
  'SNHO': double.nan,
  'MPCO': double.nan,
  'MGNA': double.nan,
  'SNDE': double.nan,
  'SINA': double.nan,
};

class DataGridPage extends StatefulWidget {
  @override
  _DataGridPageState createState() => _DataGridPageState();
}
String ControllerSMDED='1';
int UPIN=1;
class _DataGridPageState extends State<DataGridPage> {
  final Sto_NumController controller = Get.find();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ControllerSMDED=controller.SMDED;
    UPIN=controller.UPIN!;
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
    );
  }

  Future<ProductDataGridSource> getProductDataSource() async {
    var productList = await query_STO_NUM(controller.SelectDataBIID.toString(),controller.SelectDataSIID.toString(),
        controller.SelectDataMGNO2.toString(),controller.SelectDataMINO.toString(),
        controller.SelectDataMINO_TO.toString(),controller.NOT_Quantities,
        controller.SCID.toString(),controller.STO_V_N,controller.TYPE_DATA,controller.TYPE_T);
    return ProductDataGridSource(productList);
  }

  List<GridColumn> getColumns() {
    return
      //controller.SMDED!='2'?
    <GridColumn>[
      GridColumn(
          columnName: 'MINA_D',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMINO'.tr, style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'MUNA_D',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringMUID'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SNNO',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSNNO'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SNHO',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSNHO'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SNRE',
          columnWidthMode: ColumnWidthMode.auto,
          width:  double.nan,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringReturn_quantity'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      if(controller.UPIN!=2)GridColumn(
          columnName: 'MPCO',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:   Text(
                  'StringMPCO2'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'SUM',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StrinCount_BMDAMC'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      GridColumn(
          columnName: 'MGNA_D',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringMgno'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
      if(controller.SMDED!='2')
        GridColumn(
          columnName: 'SNDE',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child: Text('StringSMDED'.tr, overflow: TextOverflow.clip, softWrap: true,style: const TextStyle(fontFamily: 'Hacen'),))),
        GridColumn(
          columnName: 'SINA_D',
          width:  double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                  'StringSIIDlableText'.tr,style: const TextStyle(fontFamily: 'Hacen')
              ))),
    ];
    // <GridColumn>[
    //   GridColumn(
    //       columnName: 'MINA_D',
    //       width:  double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringMINO'.tr, style: const TextStyle(fontFamily: 'Hacen'),
    //           ))),
    //   GridColumn(
    //       columnName: 'MUNA_D',
    //       columnWidthMode: ColumnWidthMode.auto,
    //       width:  double.nan,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //               'StringMUID'.tr,style: const TextStyle(fontFamily: 'Hacen')
    //           ))),
    //   GridColumn(
    //       columnName: 'SNNO',
    //       columnWidthMode: ColumnWidthMode.auto,
    //       width:  double.nan,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //               'StringSNNO'.tr,style: const TextStyle(fontFamily: 'Hacen')
    //           ))),
    //   GridColumn(
    //       columnName: 'SNHO',
    //       columnWidthMode: ColumnWidthMode.auto,
    //       width:  double.nan,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //               'StringSNHO'.tr,style: const TextStyle(fontFamily: 'Hacen')
    //           ))),
    //   controller.UPIN!=2?GridColumn(
    //       columnName: 'MPCO',
    //       width:  double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:   Text(
    //               'StringMPCO2'.tr,style: const TextStyle(fontFamily: 'Hacen')
    //           ))):
    //   GridColumn(columnName: 'MPCO', label: const Text("")),
    //   GridColumn(
    //       columnName: 'SUM',
    //       width:  double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //               'StrinCount_BMDAMC'.tr,style: const TextStyle(fontFamily: 'Hacen')
    //           ))),
    //   GridColumn(
    //       columnName: 'MGNA_D',
    //       width:  double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //               'StringMgno'.tr,style: const TextStyle(fontFamily: 'Hacen')
    //           ))),
    //   GridColumn(
    //       columnName: 'SINA_D',
    //       width:  double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //               'StringSIIDlableText'.tr,style: const TextStyle(fontFamily: 'Hacen')
    //           ))),
    // ];
  }
}

class ProductDataGridSource extends DataGridSource {
  final Sto_NumController controller = Get.find();
  ProductDataGridSource(this.productList) {
    buildDataGridRow();
  }
  late List<DataGridRow> dataGridRows;
  late List<Sto_Num> productList;
  final formatter = intl.NumberFormat.decimalPattern();
  double roundDouble(double value, int places) {
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return DataGridRowAdapter(cells: [
      Container(
        alignment: Alignment.center,
        child: Text(
          row.getCells()[0].value.toString(),
          overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          row.getCells()[1].value.toString(),
          overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          formatter.format(row.getCells()[2].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          formatter.format(row.getCells()[7].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          formatter.format((row.getCells()[2].value-row.getCells()[7].value)).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
      if(UPIN!=2)Container(
          alignment: Alignment.center,
          child: Text(
          formatter.format(roundDouble(row.getCells()[5].value,6)).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )),
      Container(
          alignment: Alignment.center,
          child: Text(
              formatter.format(roundDouble(row.getCells()[2].value*row.getCells()[5].value,6)).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )),
      Container(
          alignment: Alignment.center,
          child: Text(
            row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )),
      if(ControllerSMDED!='2')
        Container(
          alignment: Alignment.center,
          child: Text(
            row.getCells()[4].value.toString(),
            overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen')
          )),
      Container(
        alignment: Alignment.center,
        child: Text(
            controller.STO_V_N==true?'كافة المخازن':row.getCells()[6].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')
        ),
      ),
    ]);
    // DataGridRowAdapter(cells: [
    //   Container(
    //     alignment: Alignment.center,
    //     child: Text(
    //         row.getCells()[0].value.toString(),
    //         overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: 'Hacen')
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     child: Text(
    //         row.getCells()[1].value.toString(),
    //         overflow: TextOverflow.ellipsis,
    //         style: const TextStyle(fontFamily: 'Hacen')
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     child: Text(
    //         row.getCells()[2].value.toString(),
    //         overflow: TextOverflow.ellipsis,
    //         style: const TextStyle(fontFamily: 'Hacen')
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     child: Text(
    //         row.getCells()[7].value.toString(),
    //         overflow: TextOverflow.ellipsis,
    //         style: const TextStyle(fontFamily: 'Hacen')
    //     ),
    //   ),
    //   Container(
    //     alignment: Alignment.center,
    //     child: Text(
    //         (row.getCells()[2].value-row.getCells()[7].value).toString(),
    //         overflow: TextOverflow.ellipsis,
    //         style: const TextStyle(fontFamily: 'Hacen')
    //     ),
    //   ),
    //   if(UPIN!=2)Container(
    //       alignment: Alignment.center,
    //       child: Text(
    //      formatter.format(roundDouble(row.getCells()[5].value,6)).toString(),
    //           overflow: TextOverflow.ellipsis,
    //           style: const TextStyle(fontFamily: 'Hacen')
    //       )),
    //   Container(
    //       alignment: Alignment.center,
    //       child: Text(
    //           formatter.format(roundDouble(row.getCells()[2].value*row.getCells()[5].value,6)).toString(),
    //           overflow: TextOverflow.ellipsis,
    //           style: const TextStyle(fontFamily: 'Hacen')
    //       )),
    //   Container(
    //       alignment: Alignment.center,
    //       child: Text(
    //           row.getCells()[3].value.toString(),
    //           overflow: TextOverflow.ellipsis,
    //           style: const TextStyle(fontFamily: 'Hacen')
    //       )),
    //   Container(
    //     alignment: Alignment.center,
    //     child: Text(
    //         controller.STO_V_N==true?'كافة المخازن':row.getCells()[6].value.toString(),
    //         overflow: TextOverflow.ellipsis,
    //         style: const TextStyle(fontFamily: 'Hacen')
    //     ),
    //   ),
    // ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  void buildDataGridRow() {
    dataGridRows = productList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell<String>(columnName: 'MINA_D', value: dataGridRow.MINA_D),
        DataGridCell<String>(columnName: 'MUNA_D', value: dataGridRow.MUNA_D),
        DataGridCell(columnName: 'SNNO', value: dataGridRow.SNNO),
        DataGridCell<String>(columnName: 'MGNA_D', value: dataGridRow.MGNA_D),
        DataGridCell<String>(columnName: 'SNDE', value: dataGridRow.SNED),
        DataGridCell(columnName: 'MPCO', value: dataGridRow.MPCO),
        DataGridCell<String>(columnName: 'SINA_D', value: dataGridRow.SINA_D),
        DataGridCell(columnName: 'SNHO', value: dataGridRow.SNHO),
        // DataGridCell<DateTime>(
        //     columnName: 'orderDate', value: dataGridRow.SMMID),
      ]);
    }).toList(growable: false);
  }
  void updateDataSource() {
    notifyListeners();
  }
}
