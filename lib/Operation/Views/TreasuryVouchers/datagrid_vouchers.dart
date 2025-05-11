import 'dart:async';
import '../../../Operation/Controllers/Pay_Out_Controller.dart';
import '../../../Operation/models/acc_mov_d.dart';
import '../../../database/TreasuryVouchers_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class DataGridPageVouchers extends StatefulWidget {
  @override
  _DataGridPageVouchersState createState() => _DataGridPageVouchersState();
}
class _DataGridPageVouchersState extends State<DataGridPageVouchers> {

  Future<InventoryDataGridSource> getInventoryDataSource() async {
    var InvoicesList = await GET_ACC_MOV_D(controller.AMKID.toString(),controller.AMMID.toString());
    return InventoryDataGridSource(InvoicesList);
  }

  final Pay_Out_Controller controller = Get.find();

  EDIT_VOU (BuildContext context, DataGridRow row, int rowIndex) async {
    controller.Debit=false;
    controller.Credit=false;
    controller.AMMID = row.getCells()[0].value;
    controller.AMDIDController.text = row.getCells()[1].value.toString();
    controller.SelectDataAANO = row.getCells()[2].value.toString();
    controller.AANAController.text = row.getCells()[3].value.toString();
    controller.AMKID!=15?controller.AMDMOController.text = row.getCells()[controller.AMKID==2
        ? 8 : 9 ].value.toString().replaceAll(controller.regex, ''):
    row.getCells()[8].value.toString()!='0.0'?
    controller.AMDMOController.text=row.getCells()[8].value.toString().replaceAll(controller.regex, ''):
    controller.AMDMOController.text=row.getCells()[9].value.toString().replaceAll(controller.regex, '');

    controller.AMKID!=15?controller.AMDMO = double.parse(row.getCells()[controller.AMKID==2
        ? 8 : 9 ].value.toString().replaceAll(controller.regex, '')):
    row.getCells()[8].value.toString()!='0.0'?
    controller.AMDMO=double.parse(row.getCells()[8].value.toString().replaceAll(controller.regex, '')):
    controller.AMDMO=double.parse(row.getCells()[9].value.toString().replaceAll(controller.regex, ''));

    controller.AMKID!=15?controller.AMDMOSController.text = controller.formatter.format(
        row.getCells()[controller.AMKID==2 ? 8 : 9 ].value).toString():
    row.getCells()[8].value.toString()!='0.0'?
    controller.AMDMOSController.text=controller.formatter.format(row.getCells()[8].value).toString():
    controller.AMDMOSController.text=controller.formatter.format(row.getCells()[9].value).toString();

    controller.AMDINController.text = row.getCells()[5].value.toString();
    controller.AMDEQController.text = row.getCells()[4].value.toString();
    controller.AMDEQSController.text = controller.formatter.format(row.getCells()[4].value).toString();
    row.getCells()[8].value.toString()!='0.0'?controller.Debit=true:controller.Credit=true;
    if((controller.ValueAMMCC || controller.AMKID==15) && row.getCells()[6].value.toString()!=controller.SelectDataSCID){
      controller.SelectDataSCID2 = row.getCells()[6].value.toString()=='null'?null:row.getCells()[6].value.toString();
      controller.SCEX2 = double.parse(row.getCells()[7].value);
    }
    controller.titleAddScreen = 'StringEdit'.tr;
    controller.StringButton = 'StringEdit'.tr;
    controller.Repeatingedit = true;
    controller.GET_AMDIN_P();
    controller.displayAddItemsWindo();
    controller.myFocusNode.requestFocus();
  }

  Widget _bildswipeingEdit(BuildContext context, DataGridRow row, int rowIndex) {
    return GestureDetector(
        onTap: () {
          EDIT_VOU(context,row,rowIndex);
        },
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

  DELETE_VOU(DataGridRow row) async {
    controller.DeleteACC_MOV_D(row.getCells()[0].value.toString(), row.getCells()[1].value.toString());
    controller.GET_CountRecode();
    controller.update();
  }


  @override
  Widget build(BuildContext context) {
    return GetBuilder<Pay_Out_Controller>(
      init: Pay_Out_Controller(),
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
                  onCellTap: ((details) {
                    if (details.rowColumnIndex.rowIndex != 0) {
                      int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
                      var row = snapshot.data.effectiveRows.elementAt(selectedRowIndex);
                      EDIT_VOU(context,row, selectedRowIndex);
                    }
                  }),
                  // onCellDoubleTap: ((details) async {
                  //   if (details.rowColumnIndex.rowIndex != 0) {
                  //     int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
                  //     var row = snapshot.data.effectiveRows.elementAt(selectedRowIndex);
                  //     await DELETE_VOU(row);
                  //   }
                  // }),
                  startSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
                    return GestureDetector(
                        onTap: () async{
                            await DELETE_VOU(row);
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
                columnName: 'AANA',
                width: 120,
                allowEditing: false,
                // width: double.nan,
                // columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                alignment: Alignment.center,
                child:  Text('StringAccount'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            GridColumn(
                columnName: controller.AMKID==2 || controller.AMKID==15 ? 'AMDMD':'AMDDA',
                allowEditing: false,
                // width: double.nan,
                // columnWidthMode: ColumnWidthMode.auto,
                label: Container(alignment: Alignment.center,
                child: Text(controller.AMKID==2 || controller.AMKID==15 ? 'StringAMDMD'.tr : 'StringAMDDA'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            GridColumn(
                columnName: controller.AMKID==15 ? 'AMDDA':'AMDEQ',
                allowEditing: false,
                // width: double.nan,
                // columnWidthMode: ColumnWidthMode.auto,
                label: Container(alignment: Alignment.center,
                child: Text(controller.AMKID==15 ?'StringAMDDA'.tr: 'StringTotalequivalent'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            if(controller.AMKID==15)GridColumn(
                columnName: 'SCSY',
                allowEditing: false,
                // width: double.nan,
                // columnWidthMode: ColumnWidthMode.auto,
                label: Container(alignment: Alignment.center,
                child: Text( 'StringSCIDlableText'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            if(controller.AMKID==15)GridColumn(
                columnName: 'AMDEQ',
                allowEditing: false,
                // width: double.nan,
                // columnWidthMode: ColumnWidthMode.auto,
                label: Container(alignment: Alignment.center,
                child: Text( 'StringTotalequivalent'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
            GridColumn(
                columnName: 'AMDIN',
                allowEditing: false,
                // width: double.nan,
                // columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                alignment: Alignment.center,
                child:  Text(
                'StringDetails'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),))),
          ];
  }
}

class InventoryDataGridSource extends DataGridSource {
  final Pay_Out_Controller controller = Get.find();
  InventoryDataGridSource(this.InvoiceList) {
    buildDataGridRow();
  }
  List<DataGridRow> dataGridRows = <DataGridRow>[];
  List<Acc_Mov_D_Local> InvoiceList = <Acc_Mov_D_Local>[];
  dynamic newCellValue;
  void DataGrid() {
        DataGridPageVouchers();
        controller.loading(false);
        controller.update();
    }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return  DataGridRowAdapter(cells: [
            Container(
              width: 150,
              alignment: Alignment.center,
              child:  Text(row.getCells()[3].value.toString(),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(controller.formatter.format(
                  double.parse(row.getCells()[controller.AMKID==2 || controller.AMKID==15 ? 8 : 9].value.toString())),
                  softWrap: true,
                  overflow: TextOverflow.visible,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
            alignment: Alignment.center,
            child: Text(controller.formatter.format(double.parse(row.getCells()[controller.AMKID==15?9:4].value.toString())),
            softWrap: true,
            overflow: TextOverflow.visible,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
            if(controller.AMKID==15)Container(
              alignment: Alignment.center,
            child: Text(row.getCells()[10].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
            if(controller.AMKID==15)Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(double.parse(row.getCells()[4].value.toString())),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
            Container(
              alignment: Alignment.center,
              child: Text(row.getCells()[5].value.toString(),
                  softWrap: true,
                  overflow: TextOverflow.visible,
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
    dataGridRows = InvoiceList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'AMMID', value: dataGridRow.AMMID),//0
        DataGridCell(columnName: 'AMDID', value: dataGridRow.AMDID),//1
        DataGridCell(columnName: 'AANO', value: dataGridRow.AANO),//2
        DataGridCell(columnName: 'AANA', value: dataGridRow.AANA_D),//3
        DataGridCell(columnName: 'AMDEQ', value: dataGridRow.AMDEQ),//4
        DataGridCell(columnName: 'AMDIN', value: dataGridRow.AMDIN),//5
        DataGridCell(columnName: 'SCID', value: dataGridRow.SCID),//6
        DataGridCell(columnName: 'SCEX', value: dataGridRow.SCEX),//7
        DataGridCell(columnName: 'AMDMD', value: dataGridRow.AMDMD),//8
        DataGridCell(columnName: 'AMDDA', value: dataGridRow.AMDDA),//9
        DataGridCell(columnName: 'SCSY', value: dataGridRow.SCSY),//10
      ]);
    }).toList(growable: false);
  }
  void updateDataSource() {
    notifyListeners();
  }
}