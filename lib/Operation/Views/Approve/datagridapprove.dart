import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../database/invoices_db.dart';
import '../../Controllers/counter_sale_approving_controller.dart';
import '../../models/bif_cou_c.dart';

class DataGridApprovePage extends StatefulWidget {
  @override
  _DataGridApprovePageState createState() => _DataGridApprovePageState();
}
class _DataGridApprovePageState extends State<DataGridApprovePage> {

  Future<InventoryDataGridSource> getInventoryDataSource() async {
    var InvoicesList = await GET_BIF_COU_C(controller.BCMID);
    return InventoryDataGridSource(InvoicesList);
  }

  final Counter_Sales_Approving_Controller controller = Get.find();

  Widget _bildswipeingEdit(BuildContext context, DataGridRow row, int rowIndex) {
    return GestureDetector(
        onTap: () => setState(() {
          controller.BCCID = row.getCells()[0].value;
          controller.BCCIDController.text = row.getCells()[0].value.toString();
          controller.SelectDataCIMID = row.getCells()[5].value.toString();
          controller.BCMRNController.text = row.getCells()[3].value.toString().contains('.0')
              ? row.getCells()[3].value.round().toString()
              : row.getCells()[3].value.toString();
          controller.BCMROController.text = row.getCells()[4].value.toString().contains('.0')
              ? row.getCells()[4].value.round().toString()
              : row.getCells()[4].value.toString();
          controller.DEF_COUController.text =
          ((double.parse(row.getCells()[3].value.toString())-double.parse(row.getCells()[4].value.toString())).toString()).contains('.0')?
          (double.parse(row.getCells()[3].value.toString())-double.parse(row.getCells()[4].value.toString())).round().toString()
              :(double.parse(row.getCells()[3].value.toString())-double.parse(row.getCells()[4].value.toString())).toString();
          // controller.AMDMOController.text = row.getCells()[controller.AMKID==2?8:9].value.toString();
          // controller.AMDINController.text = row.getCells()[5].value.toString();
          // controller.SelectDataSCID2 = row.getCells()[6].value.toString();
          // controller.SCEX2 = double.parse(row.getCells()[7].value);
          controller.titleScreen = 'StringEdit'.tr;
          controller.titleAddScreen = 'StringEdit'.tr;
          controller.StringButton = 'StringEdit'.tr;
          controller.editd = true;
          controller.displayAddItemsWindo();
          controller.myFocusNode.requestFocus();
        }),
        child: Container(
            color: Colors.blueAccent,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Icon(
                  Icons.edit,
                  color: Colors.white,
                ),
              ],
            )));
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Counter_Sales_Approving_Controller>(
      init: Counter_Sales_Approving_Controller(),
      builder: ((controller) => FutureBuilder(
        future: getInventoryDataSource(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          return snapshot.hasData
              ? SfDataGridTheme(
                data: SfDataGridThemeData(headerColor: const Color(0xFFECEFF0)),
                child: SfDataGrid(
                  allowEditing: true,
                  allowSwiping: true,
                  selectionMode: SelectionMode.single,
                  swipeMaxOffset: 80,
                  controller: controller.dataGridController,
                  columnWidthMode: ColumnWidthMode.fill,
                  endSwipeActionsBuilder: _bildswipeingEdit,
                  navigationMode: GridNavigationMode.cell,
                  source: snapshot.data,
                  editingGestureType: EditingGestureType.tap,
                  columns: getColumns(),
                  startSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
                    return GestureDetector(
                        onTap: () {
                          setState(() {
                            print(row.getCells()[1].value.toString());
                            print(row.getCells()[0].value.toString());
                           controller.DeleteBIF_COU_C_P(row.getCells()[1].value.toString(), row.getCells()[0].value.toString());
                          });
                        },
                        child: Container(
                            color: Colors.redAccent,
                            child: const Center(
                              child: Icon(Icons.delete),
                            )));
                  },
                ),
              )
              : const Center(
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                  ),
                );
        },
      )),
    );
  }

  List<GridColumn> getColumns() {
    return  <GridColumn>[
            GridColumn(
                columnName: 'CIMNA_D',
                allowEditing: false,
                width: double.nan,
                label: Container(
                alignment: Alignment.center,
                child:  Text('Stringcounter_label'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            GridColumn(
                columnName: 'BCMID',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(alignment: Alignment.center,
                child: Text('StringReadBefore'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            GridColumn(
                columnName: 'BCMID',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(alignment: Alignment.center,
                child: Text('StringReadAfter'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            GridColumn(
                columnName: 'BCMID',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                alignment: Alignment.center,
                child:  Text(
                'StrinDef_BCMRO'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            GridColumn(
                columnName: 'BCMAM',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                alignment: Alignment.center,
                child: Text(
                'StrinlChice_item_Total'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
          ];
  }
}

class InventoryDataGridSource extends DataGridSource {
  final Counter_Sales_Approving_Controller controller = Get.find();
  InventoryDataGridSource(this.ApproveList) {
    buildDataGridRow();
  }
  List<DataGridRow> dataGridRows = <DataGridRow>[];
  List<Bif_Cou_C_Local> ApproveList = <Bif_Cou_C_Local>[];
  dynamic newCellValue;
  void DataGrid() {
        DataGridApprovePage();
        controller.loading(false);
        controller.update();
    }


  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return  DataGridRowAdapter(cells: [
            Container(
              alignment: Alignment.center,
              child:  Text(row.getCells()[2].value.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(row.getCells()[4].value.toString().contains('.0')
    ? row.getCells()[4].value.round().toString()
        : row.getCells()[4].value.toString(),
                  overflow: TextOverflow.ellipsis, style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString().contains('.0')
    ? row.getCells()[3].value.round().toString()
        : row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
            Container(
              alignment: Alignment.center,
              child: Text('${((double.parse(row.getCells()[3].value.toString())-double.parse(row.getCells()[4].value.toString())).toString()).contains('.0')?
              (double.parse(row.getCells()[3].value.toString())-double.parse(row.getCells()[4].value.toString())).round().toString()
                  :(double.parse(row.getCells()[3].value.toString())-double.parse(row.getCells()[4].value.toString())).toString()}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
              alignment: Alignment.center,
              child: Text('${row.getCells()[7].value.toString()}',
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
          ]);
  }
  @override
  List<DataGridRow> get rows => dataGridRows;
  // Future<void> handleRefresh() async {
  //   await Future.delayed(Duration(seconds: 5));
  // //  _addMoreRows(InvoiceList, 15);
  //   buildDataGridRow();
  //   notifyListeners();
  // }
  void buildDataGridRow() {
    dataGridRows = ApproveList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'BCCID', value: dataGridRow.BCCID),//0
        DataGridCell(columnName: 'BCMID', value: dataGridRow.BCMID),//1
        DataGridCell(columnName: 'CIMNA_D', value: dataGridRow.CIMNA_D),//2
        DataGridCell(columnName: 'BCMRN', value: dataGridRow.BCMRN),//3
        DataGridCell(columnName: 'BCMRO', value: dataGridRow.BCMRO),//4
        DataGridCell(columnName: 'CIMID', value: dataGridRow.CIMID),//5
        DataGridCell(columnName: 'BCMAM', value: dataGridRow.BCMAM),//6
        DataGridCell(columnName: 'BCMAMSUM', value: dataGridRow.BCMAMSUM),//7
        // DataGridCell(columnName: 'BCCID', value: dataGridRow.BCCID),//8
        // DataGridCell(columnName: 'BCCID', value: dataGridRow.BCCID),//9
      ]);
    }).toList(growable: false);
  }
  void updateDataSource() {
    notifyListeners();
  }
}