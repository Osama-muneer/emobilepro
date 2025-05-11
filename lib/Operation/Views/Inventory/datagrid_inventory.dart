import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:ui' as UI;
import '../../../Setting/controllers/setting_controller.dart';
import '../../../database/inventory_db.dart';
import '../../Controllers/inventory_controller.dart';
import '../../models/inventory.dart';


class DataGridPageInventory extends StatefulWidget {
  @override
  _DataGridPageInventoryState createState() => _DataGridPageInventoryState();
}

String ControllerSMDED = '1';

class _DataGridPageInventoryState extends State<DataGridPageInventory> {

  final InventoryController controller = Get.find();
  UI.TextDirection direction = UI.TextDirection.rtl;
  Future<InventoryDataGridSource> getInventoryDataSource() async {
    var InventoryList = await GETSTO_MOV_D(controller.SMMID!,controller.SER_MINA.toString());
    return InventoryDataGridSource(InventoryList);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget _bildswipeingEdit(BuildContext context, DataGridRow row, int rowIndex) {
    return GestureDetector(
        onTap: () => setState(() {
              controller.SMDNFHintController.text = row.getCells()[5].value.toString().contains('.0')
                      ? row.getCells()[5].value.round().toString()
                      : row.getCells()[5].value.toString();
              controller.SMDNOController.text = row.getCells()[5].value.toString();
              controller.MINAController.text = row.getCells()[2].value.toString();
              controller.SelectDataMINO = row.getCells()[7].value.toString();
              controller.MGNOController.text = row.getCells()[8].value.toString();
              controller.SelectDataMUID = row.getCells()[6].value.toString();
              controller.SMDIDController.text = row.getCells()[1].value.toString();
              controller.SMMIDController.text = row.getCells()[0].value.toString();
              controller.SelectDataSNED = row.getCells()[11].value.toString();
              controller.SMDEDController.text = row.getCells()[11].value.toString();
              controller.SMDNFController.text = row.getCells()[4].value.toString();
              controller.SMDAMController.text=row.getCells()[12].value.toString();
              controller.SelectDataMUCNA=row.getCells()[3].value.toString();
              controller.MPCOController.text=row.getCells()[15].value.toString();
              controller.titleScreen = 'StringEdit'.tr;
              controller.titleAddScreen = 'StringEdit'.tr;
              controller.TextButton_T = 'StringEdit'.tr;
              controller.displayAddItemsWindo();
              controller.myFocusNode.requestFocus();
              controller.GET_COU_B();
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
    return  StteingController().Type_Inventory=='2'?
    GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: ((controller) =>FutureBuilder(
      future: getInventoryDataSource(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Padding(
                padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(
                    headerColor: const Color(0xFFECEFF0),
                  ),
                  child: SfDataGrid(
                    //key: _key,
                    allowSwiping: true,
                    swipeMaxOffset: 85.w,
                    columnWidthMode: ColumnWidthMode.fill,
                    allowEditing: true,
                    endSwipeActionsBuilder: _bildswipeingEdit,
                    source: snapshot.data,
                    columns: getColumns(),
                    startSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
                      return GestureDetector(
                          onTap: () {
                            setState(() {
                              controller.DeleteItem(
                                  row.getCells()[0].value.toString(),
                                  row.getCells()[1].value.toString());
                              controller.GET_CountSMDNF();
                              controller.GET_CountRecode();
                              controller.GET_SUMSMMAM();
                              controller.renumberbmdid(row.getCells()[0].value.toString());
                            });
                          },
                          child: Container(
                              color: Colors.redAccent,
                              child: const Center(
                                child: Icon(Icons.delete),
                              )));
                    },
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              );
      },
    ))):
    GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: ((controller) =>FutureBuilder(
      future: getInventoryDataSource(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Padding(
          padding: const EdgeInsets.only(right: 8.0, left: 8.0),
          child: SfDataGridTheme(
            data: SfDataGridThemeData(
              headerColor: const Color(0xFFECEFF0),
            ),
            child: SfDataGrid(
              columnWidthMode: ColumnWidthMode.fill,
              allowEditing: true,
              source: snapshot.data,
              columns: getColumns(),
              allowSwiping: true,
              swipeMaxOffset: 85.w,
              selectionMode: SelectionMode.single,
              navigationMode: GridNavigationMode.cell,
              editingGestureType: EditingGestureType.tap,
              startSwipeActionsBuilder:
                  (BuildContext context, DataGridRow row, int rowIndex) {
                return GestureDetector(
                    onTap: () {
                      setState(() {
                        controller.DeleteItem(
                            row.getCells()[0].value.toString(),
                            row.getCells()[1].value.toString());
                        controller.GET_CountSMDNF();
                        controller.GET_CountRecode();
                        controller.GET_SUMSMMAM();
                      });
                    },
                    child: Container(
                        color: Colors.redAccent,
                        child: const Center(
                          child: Icon(Icons.delete),
                        )));
              },
            ),
          ),
        )
            : const Center(
          child: CircularProgressIndicator(
            strokeWidth: 3,
          ),
        );
      },
    )));
  }

  List<GridColumn> getColumns() {
    return
      // controller.SMDED == '1' || controller.SMDED == '3' ?
      controller.SMKID==17 ?
    <GridColumn>[
            GridColumn(
                columnName: 'MGNO',
                allowEditing: false,
                label: Container(
                    alignment: Alignment.center,
                    child:  Text(
                      'StringMgno'.tr,
                      style: const TextStyle(fontFamily: 'Hacen'),
                    ))),
            GridColumn(
                columnName: 'NAM',
                allowEditing: false,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    alignment: Alignment.center,
                    child:  Text(
                      'StringMINO'.tr,
                      style: TextStyle(fontFamily: 'Hacen'),
                    ))),
            GridColumn(
                columnName: 'SMDED',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    alignment: Alignment.center,
                    child:  Text(
                      'StringSMDED'.tr,
                      style: TextStyle(fontFamily: 'Hacen'),
                    ))),
            GridColumn(
                columnName: 'SMDNF',
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    alignment: Alignment.center,
                    child:  Text(
                      'StringSMDFN'.tr,
                      style: TextStyle(fontFamily: 'Hacen'),
                    ))),
            GridColumn(
                columnName: 'SMDNO',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    alignment: Alignment.center,
                    child:  Text('StringSNNO'.tr,
                        style: const TextStyle(fontFamily: 'Hacen'),
                        overflow: TextOverflow.clip,
                        softWrap: true))),
            GridColumn(
                columnName: 'SMDDF',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    alignment: Alignment.center,
                    child:  Text(
                      'StringSMDDF'.tr,
                      style: TextStyle(fontFamily: 'Hacen'),
                    ))),
          ]
        :
    controller.SMKID==1 || controller.SMKID==3?
    <GridColumn>[
      GridColumn(
          columnName: 'MGNO',
          columnWidthMode: ColumnWidthMode.auto,
          allowEditing: false,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMgno'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'NAM',
          allowEditing: false,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMINO'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'SMDNO',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text('StringSNNO'.tr,
                  style: const TextStyle(fontFamily: 'Hacen'),
                  overflow: TextOverflow.clip,
                  softWrap: true))),
      GridColumn(
          columnName: 'SMDNF',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text('StringSMDNF'.tr,
                  style: const TextStyle(fontFamily: 'Hacen'),
                  overflow: TextOverflow.clip,
                  softWrap: true))),
      GridColumn(
          columnName: 'SMDAM',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMPCO'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'SMDED',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSMDED'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'SMDAMT',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSUMBMDAM'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
    ]
        :
    <GridColumn>[
      GridColumn(
          columnName: 'MGNO',
          columnWidthMode: ColumnWidthMode.auto,
          allowEditing: false,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMgno'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'NAM',
          allowEditing: false,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMINO'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'SMDNO',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text('StringSNNO'.tr,
                  style: const TextStyle(fontFamily: 'Hacen'),
                  overflow: TextOverflow.clip,
                  softWrap: true))),
      GridColumn(
          columnName: 'SMDED',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSMDED'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
      controller.SMKID==11?
      GridColumn(
          columnName: 'SMDAM',
          label: Container()):
      GridColumn(
          columnName: 'SMDAM',
          allowEditing: false,
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMPCO'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
    ]
    //     :
    // controller.SMKID==17?
    // <GridColumn>[
    //         GridColumn(
    //             columnName: 'MGNO',
    //             width: 75.w,
    //             allowEditing: false,
    //             // width:  double.nan,
    //             //columnWidthMode: ColumnWidthMode.auto,
    //             label: Container(
    //                 alignment: Alignment.center,
    //                 child:  Text(
    //                   'StringMgno'.tr,
    //                   style: const TextStyle(fontFamily: 'Hacen'),
    //                 ))),
    //         GridColumn(
    //             columnName: 'NAM',
    //             allowEditing: false,
    //             width: double.nan,
    //             columnWidthMode: ColumnWidthMode.auto,
    //             label: Container(
    //                 alignment: Alignment.center,
    //                 child:  Text(
    //                   'StringMINO'.tr,
    //                   style: TextStyle(fontFamily: 'Hacen'),
    //                 ))),
    //         GridColumn(
    //       columnName: 'SMDNF',
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringSMDFN'.tr,
    //             style: TextStyle(fontFamily: 'Hacen'),
    //           ))),
    //         GridColumn(
    //       columnName: 'SMDNO',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text('StringSNNO'.tr,
    //               style: const TextStyle(fontFamily: 'Hacen'),
    //               overflow: TextOverflow.clip,
    //               softWrap: true))),
    //         GridColumn(
    //             columnName: 'SMDDF',
    //             allowEditing: false,
    //             width: double.nan,
    //             columnWidthMode: ColumnWidthMode.auto,
    //             label: Container(
    //                 alignment: Alignment.center,
    //                 child:  Text(
    //                   'StringSMDDF'.tr,
    //                   style: TextStyle(fontFamily: 'Hacen'),
    //                 )))
    //       ] :
    // controller.SMKID==1 || controller.SMKID==3?
    // <GridColumn>[
    //   GridColumn(
    //       columnName: 'MGNO',
    //       allowEditing: false,
    //        width:  double.nan,
    //       //columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringMgno'.tr,
    //             style: const TextStyle(fontFamily: 'Hacen'),
    //           ))),
    //   GridColumn(
    //       columnName: 'NAM',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringMINO'.tr,
    //             style: TextStyle(fontFamily: 'Hacen'),
    //           ))),
    //   GridColumn(
    //       columnName: 'SMDNO',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text('StringSNNO'.tr,
    //               style: const TextStyle(fontFamily: 'Hacen'),
    //               overflow: TextOverflow.clip,
    //               softWrap: true))),
    //   GridColumn(
    //       columnName: 'SMDNF',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text('StringSMDNF'.tr,
    //               style: const TextStyle(fontFamily: 'Hacen'),
    //               overflow: TextOverflow.clip,
    //               softWrap: true))),
    //   GridColumn(
    //       columnName: 'SMDAM',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringMPCO'.tr,
    //             style: TextStyle(fontFamily: 'Hacen'),
    //           ))),
    //   GridColumn(
    //       columnName: 'SMDAMT',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringSMDAM2'.tr,
    //             style: TextStyle(fontFamily: 'Hacen'),
    //           ))),
    // ]
    //     :
    // <GridColumn>[
    //   GridColumn(
    //       columnName: 'MGNO',
    //       allowEditing: false,
    //       width:  double.nan,
    //       //columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringMgno'.tr,
    //             style: const TextStyle(fontFamily: 'Hacen'),
    //           ))),
    //   GridColumn(
    //       columnName: 'NAM',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringMINO'.tr,
    //             style: TextStyle(fontFamily: 'Hacen'),
    //           ))),
    //   GridColumn(
    //       columnName: 'SMDNO',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text('StringSNNO'.tr,
    //               style: const TextStyle(fontFamily: 'Hacen'),
    //               overflow: TextOverflow.clip,
    //               softWrap: true))),
    //   controller.SMKID==11?
    //   GridColumn(
    //       columnName: 'SMDAM',
    //       label: Container()):
    //   GridColumn(
    //       columnName: 'SMDAM',
    //       allowEditing: false,
    //       width: double.nan,
    //       columnWidthMode: ColumnWidthMode.auto,
    //       label: Container(
    //           alignment: Alignment.center,
    //           child:  Text(
    //             'StringMPCO'.tr,
    //             style: TextStyle(fontFamily: 'Hacen'),
    //           ))),
    // ]
    ;
  }
}

class InventoryDataGridSource extends DataGridSource {
  final InventoryController controller = Get.find();
  late List<Sto_Mov_D_Local> SUM_COUNT;
  InventoryDataGridSource(this.InventoryList) {
    buildDataGridRow();
  }
  List<DataGridRow> dataGridRows = <DataGridRow>[];
  List<Sto_Mov_D_Local> InventoryList = <Sto_Mov_D_Local>[];
  dynamic newCellValue;
  void DataGrid() {
    DataGridPageInventory();
    controller.GET_CountSMDNF2(2);
    controller.loading(false);
    controller.update();
  }


  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow.getCells().firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
        ?.value
        ?.toString() ?? '';
    newCellValue = null;
    final bool isNumericType = column.columnName == 'SMDNF';
    return   Container(
      padding: const EdgeInsets.all(8.0),
      alignment: isNumericType ? Alignment.centerRight : Alignment.centerLeft,
      child: TextField(
        autofocus: true,
        textInputAction: TextInputAction.done,
        controller:  controller.UPDATEController..text = displayText,
        textAlign: isNumericType ? TextAlign.center : TextAlign.center,
        decoration: const InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 16.0),
        ),
        keyboardType: isNumericType ? TextInputType.number : TextInputType.text,
        onChanged: (String value) {
          if (value.isNotEmpty && double.parse(value)>0) {
            if (isNumericType && column.columnName == 'SMDNF' ) {
              newCellValue = double.parse(value);
             controller.SMDDF = (double.parse(value.toString()) - dataGridRow.getCells()[5].value).toPrecision(1);
              UpdateSto_Mov_D(
                  controller.SMKID!,
                  dataGridRow.getCells()[0].value,
                  dataGridRow.getCells()[1].value,
                  dataGridRow.getCells()[8].value,
                  dataGridRow.getCells()[7].value,
                  dataGridRow.getCells()[6].value,
                  newCellValue,
                  double.parse(controller.SMDDF.toString()).toPrecision(1),
                  dataGridRow.getCells()[11].value,0,0,0,0,0,0,0);
                  DataGrid();
            } else {
              newCellValue = value;
            }
          } else {
            newCellValue = 0;
          }
        },
        onTap: (){
          controller.UPDATEController.clear();
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }
  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return ControllerSMDED == '1'  || ControllerSMDED == '3'
        ? controller.SMKID==17?DataGridRowAdapter(cells: [
            Container(
              child: Text(row.getCells()[8].value.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
              alignment: Alignment.center,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                  row.getCells()[13].value.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
              alignment: Alignment.center,
              child: Text(row.getCells()[11].value.toString()=='null'?'':row.getCells()[11].value.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
                alignment: Alignment.center,
                child: Text(controller.formatter.format(row.getCells()[4].value).toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'Hacen'))),
            Container(
                alignment: Alignment.center,
                child: Text(controller.formatter.format(row.getCells()[5].value).toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'Hacen'))),
            Container(
                // '${(double.parse(row.getCells()[9].value.toString()).toPrecision(1))}'
                alignment: Alignment.center,
                child: Text(
            controller.formatter.format(row.getCells()[9].value).toString(),
                    overflow: TextOverflow.ellipsis,
                    style: row.getCells()[9].value < 0
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )
                        : row.getCells()[9].value > 0
                            ? const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontFamily: 'Hacen')
                            : const TextStyle(
                                color: Colors.black, fontFamily: 'Hacen'))),
          ]):
          controller.SMKID==1 || controller.SMKID==3?
          DataGridRowAdapter(cells: [
      Container(
        child: Text(row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[13].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
               alignment: Alignment.center,
               child: Text(controller.formatter.format(row.getCells()[5].value).toString(),
                   overflow: TextOverflow.ellipsis,
                   style: const TextStyle(fontFamily: 'Hacen'))),
      Container(
               alignment: Alignment.center,
               child: Text(controller.formatter.format(row.getCells()[4].value).toString(),
                   overflow: TextOverflow.ellipsis,
                   style: const TextStyle(fontFamily: 'Hacen'))),
      Container(
               alignment: Alignment.center,
               child: Text(
                controller.formatter.format(row.getCells()[12].value).toString(),
                   overflow: TextOverflow.ellipsis,
                   style: const TextStyle(fontFamily: 'Hacen'))),
      Container(
             alignment: Alignment.center,
             child: Text(row.getCells()[11].value.toString()=='null'?'':row.getCells()[11].value.toString(),
                 overflow: TextOverflow.ellipsis,
                 style: const TextStyle(fontFamily: 'Hacen')),
           ),
      Container(
                alignment: Alignment.center,
                child: Text(controller.formatter.format(row.getCells()[14].value).toString(),
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontFamily: 'Hacen'))),
    ]):
          DataGridRowAdapter(cells: [
      Container(
        child: Text(row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[13].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
          alignment: Alignment.center,
          child: Text(controller.formatter.format(row.getCells()[5].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[11].value.toString()=='null'?'':row.getCells()[11].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
            controller.SMKID==11?Container():Container(
          alignment: Alignment.center,
          child: Text(
              controller.formatter.format(row.getCells()[12].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
    ])
        :controller.SMKID==17?
    DataGridRowAdapter(cells: [
            Container(
              child: Text(row.getCells()[8].value.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
              alignment: Alignment.center,
            ),
            Container(
              alignment: Alignment.center,
              child: Text(
                  row.getCells()[13].value.toString(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontFamily: 'Hacen')),
            ),
            Container(
          alignment: Alignment.center,
          child: Text(
              row.getCells()[4].value.toString().contains('.0')
                  ? row.getCells()[4].value.round().toString()
                  : row.getCells()[4].value.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
            Container(
          alignment: Alignment.center,
          child: Text(
              row.getCells()[5].value.toString().contains('.0')
                  ? row.getCells()[5].value.round().toString()
                  : row.getCells()[5].value.toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
            Container(
                // '${(double.parse(row.getCells()[9].value.toString()).toPrecision(1))}'
                alignment: Alignment.center,
                child: Text(
                    row.getCells()[9].value.toString().contains('.0')
                        ? row.getCells()[9].value.round().toString()
                        : row.getCells()[9].value.toString(),
                    overflow: TextOverflow.ellipsis,
                    style: row.getCells()[9].value < 0
                        ? const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                          )
                        : row.getCells()[9].value > 0
                            ? const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                                fontFamily: 'Hacen')
                            : const TextStyle(
                                color: Colors.black, fontFamily: 'Hacen'))),
          ]):
    controller.SMKID==1 || controller.SMKID==3?
    DataGridRowAdapter(cells: [
      Container(
        child: Text(row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[13].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
          alignment: Alignment.center,
          child: Text(
              controller.formatter.format(row.getCells()[5].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
      Container(
          alignment: Alignment.center,
          child: Text(
              controller.formatter.format(row.getCells()[4].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
      Container(
          alignment: Alignment.center,
          child: Text(controller.formatter.format(row.getCells()[12].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
      Container(
          alignment: Alignment.center,
          child: Text(controller.formatter.format(row.getCells()[14].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
    ]):
    DataGridRowAdapter(cells: [
      Container(
        child: Text(row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
        alignment: Alignment.center,
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
            row.getCells()[13].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
          alignment: Alignment.center,
          child: Text(
           controller.formatter.format(row.getCells()[5].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
      controller.SMKID==11?Container():Container(
          alignment: Alignment.center,
          child: Text(controller.formatter.format(row.getCells()[12].value).toString(),
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontFamily: 'Hacen'))),
    ]);
  }
  @override
  List<DataGridRow> get rows => dataGridRows;
  void buildDataGridRow() {
    dataGridRows = InventoryList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'SMMID', value: dataGridRow.SMMID),//0
        DataGridCell(columnName: 'SMDID', value: dataGridRow.SMDID),//1
        DataGridCell<String>(columnName: 'MINA', value: dataGridRow.MINA),//2
        DataGridCell<String>(columnName: 'MUNA', value: dataGridRow.MUNA),//3
        DataGridCell<double>(columnName: 'SMDNF', value: dataGridRow.SMDNF),//4
        DataGridCell(columnName: 'SMDNO', value: dataGridRow.SMDNO),//5
        DataGridCell<int>(columnName: 'MUID', value: dataGridRow.MUID),//6
        DataGridCell<String>(columnName: 'MINO', value: dataGridRow.MINO),//7
        DataGridCell<String>(columnName: 'MGNO', value: dataGridRow.MGNO),//8
        DataGridCell(columnName: 'SMDDF', value: dataGridRow.SMDDF),//9
        DataGridCell<String>(columnName: 'MINA', value: dataGridRow.MINA),//10
        DataGridCell(columnName: 'SMDED', value: dataGridRow.SMDED),//11
        DataGridCell(columnName: 'SMDAM', value: dataGridRow.SMDAM),//12
        DataGridCell<String>(columnName: 'NAM', value: dataGridRow.NAM),//13
        DataGridCell(columnName: 'SMDAMT', value: dataGridRow.SMDAMT),//14
        DataGridCell(columnName: 'SMDAMR', value: dataGridRow.SMDAMR),//15
      ]);
    }).toList(growable: false);
  }

  void updateDataSource() {
    notifyListeners();
  }

}
