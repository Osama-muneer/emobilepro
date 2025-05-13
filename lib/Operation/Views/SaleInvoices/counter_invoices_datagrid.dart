import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';
import '../../../Widgets/dimensions.dart';
import '../../../database/invoices_db.dart';
import '../../Controllers/sale_invoices_controller.dart';
import '../../models/bil_mov_d.dart';

class DataGridPage extends StatefulWidget {
  @override
  _DataGridPageState createState() => _DataGridPageState();
}
class _DataGridPageState extends State<DataGridPage> {


  Future<InventoryDataGridSource> getInventoryDataSource() async {
    var InvoicesList = await GET_BIL_MOV_D(controller.BMKID==11 || controller.BMKID==12?'BIF_MOV_D':'BIL_MOV_D',controller.BMMID.toString(),''.toString(),'2');
    return InventoryDataGridSource(InvoicesList);
  }

  final Sale_Invoices_Controller controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getInventoryDataSource(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? Padding(
                padding:  EdgeInsets.only(right:  Dimensions.height5,left:  Dimensions.height5),
                child: SfDataGridTheme(
                  data: SfDataGridThemeData(headerColor: const Color(0xFFECEFF0)),
                  child: SfDataGrid(
                    allowEditing: true,
                    controller: controller.dataGridController,
                    gridLinesVisibility: GridLinesVisibility.both,
                    headerGridLinesVisibility: GridLinesVisibility.both,
                    columnWidthMode: ColumnWidthMode.fill,
                    selectionMode: SelectionMode.single,
                    navigationMode: GridNavigationMode.cell,
                    source: snapshot.data,
                    editingGestureType: EditingGestureType.tap,
                    columns: getColumns(),
                   // rowHeight: 50,
                  //  contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8),
                  ),
                ),
              )
            : const Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                ),
              );
      },
    );
  }

  List<GridColumn> getColumns() {
    return  <GridColumn>[
            GridColumn(
                columnName: 'CIMNA_D',
                allowEditing: false,
                width: double.nan,
                columnWidthMode: ColumnWidthMode.auto,
                label: Container(
                    alignment: Alignment.center,
                    child:  Text(
                      'Stringcounter_label'.tr,
                      style: const TextStyle(fontFamily: 'Hacen'),
                    ))),
            GridColumn(
                columnName: 'BMDNO',
                label: Container(
                    alignment: Alignment.center,
                    child:  Text(
                      'StringSNNO'.tr,
                      style: TextStyle(fontFamily: 'Hacen'),
                    ))),
            GridColumn(
          columnName: 'BMDAM1',
                allowEditing: false,
          // columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringPrice'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
            GridColumn(
          columnName: 'BMDAMT',
          // width: double.nan,
          // columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StrinCount_BMDAMC'.tr,
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
          ];
  }
}
class InventoryDataGridSource extends DataGridSource {
  final Sale_Invoices_Controller controller = Get.find();
  InventoryDataGridSource(this.InvoiceList) {
    buildDataGridRow();
  }
  List<DataGridRow> dataGridRows = <DataGridRow>[];
  List<Bil_Mov_D_Local> InvoiceList = <Bil_Mov_D_Local>[];
  dynamic newCellValue;
  void DataGrid() {
        DataGridPage();
        controller.loading(false);
        controller.update();
    }
  @override
  Future<void> onCellSubmit(DataGridRow dataGridRow, RowColumnIndex rowColumnIndex,
      GridColumn column) async {
    final dynamic oldValue = dataGridRow.getCells().firstWhereOrNull((DataGridCell dataGridCell) =>
    dataGridCell.columnName == column.columnName)?.value ?? '';


    if (newCellValue == null || oldValue == newCellValue) {
      return;
    }
    if (column.columnName == 'BMDNO' ) {

      await UpdateBIF_MOV_D(
          controller.BMDNO_V!,
          double.parse( controller.SUMBMDAMController.text),
          controller.BMMID,
          dataGridRow.getCells()[3].value,
          controller.BMDAM1!,
          controller.roundDouble(controller.BMDAM1! * double.parse(controller.SCEXController.text), 6),
          double.parse(controller.BMDTXController.text) + double.parse(controller.BMDTX2Controller.text) +
              double.parse(controller.BMDTX3Controller.text),
          controller.BMDTXController.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
          controller.BMDTX2Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
          controller.BMDTX3Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
          controller.BMDTXA!,
          controller.BMDTXA2!,
          controller.BMDTXA3!,
          controller.BMDTXA! + controller.BMDTXA2! + controller.BMDTXA3!,
          controller.BMDTXT1!,
          controller.BMDTXT2!,
          controller.BMDTXT3!,
          double.parse(controller.BMDTXTController.text),
          controller.BMDAM_TX,
          controller.BMDDI_TX,
          controller.BMDAMT3,
          controller.TCAMT);


      await  controller.GET_SUMBMDTXA();
      await  controller.GET_SUMBMMDIF();
      await  controller.GET_SUMBMMDI();
      await  controller.GET_SUMBMMAM();
      await  controller.GET_SUMBMMAM2();
      await  controller.GET_CountRecode( controller.BMMID!);
      await  controller.GET_COUNT_BMDNO_P( controller.BMMID!);
      await  controller.GET_SUMBMDTXT();
      await  controller.GET_SUM_AM_TXT_DI();
      // UpdateBIF_MOV_D(newCellValue,controller.BMDAMT!,controller.BMMID,dataGridRow.getCells()[3].value,controller.BMDTXA,
      //     controller.BMDTXAT,controller.roundDouble(controller.BMDAM!*controller.SCEX!,6));
      controller.BMDAM_VAL=controller.BMDAMT;
      DataGrid();
      controller.update();
      print('BMMAMTOTController111');
      print(controller.BMMAMTOTController.text);
    }else if(column.columnName == 'BMDAMT'){

      await UpdateBIF_MOV_D(
          controller.BMDNO_V!,
          double.parse( controller.SUMBMDAMController.text),
          controller.BMMID,
          dataGridRow.getCells()[3].value,
          controller.BMDAM1!,
          controller.roundDouble(controller.BMDAM1! * double.parse(controller.SCEXController.text), 6),
          double.parse(controller.BMDTXController.text) + double.parse(controller.BMDTX2Controller.text) +
              double.parse(controller.BMDTX3Controller.text),
          controller.BMDTXController.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
          controller.BMDTX2Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
          controller.BMDTX3Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
          controller.BMDTXA!,
          controller.BMDTXA2!,
          controller.BMDTXA3!,
          controller.BMDTXA! + controller.BMDTXA2! + controller.BMDTXA3!,
          controller.BMDTXT1!,
          controller.BMDTXT2!,
          controller.BMDTXT3!,
          double.parse(controller.BMDTXTController.text),
          controller.BMDAM_TX,
          controller.BMDDI_TX,
          controller.BMDAMT3,
          controller.TCAMT);

      await  controller.GET_SUMBMDTXA();
      await  controller.GET_SUMBMMDIF();
      await  controller.GET_SUMBMMDI();
      await  controller.GET_SUMBMMAM();
      await  controller.GET_SUMBMMAM2();
      await  controller.GET_CountRecode( controller.BMMID!);
      await  controller.GET_COUNT_BMDNO_P( controller.BMMID!);
      await  controller.GET_SUMBMDTXT();
      await  controller.GET_SUM_AM_TXT_DI();
      // UpdateBIF_MOV_D(controller.roundDouble(controller.BMDNO!,controller.SCSFL),controller.BMDAMT!,controller.BMMID,
      //     dataGridRow.getCells()[3].value,controller.BMDTXA,controller.BMDTXAT,
      //     controller.roundDouble(controller.BMDAM!*controller.SCEX!,6));
      controller.loading(true);
      DataGrid();
      controller.update();
    }

  }
  @override
  Widget? buildEditWidget(DataGridRow dataGridRow,
      RowColumnIndex rowColumnIndex, GridColumn column, CellSubmit submitCell) {
    // Text going to display on editable widget
    final String displayText = dataGridRow.getCells().firstWhereOrNull((DataGridCell dataGridCell) => dataGridCell.columnName == column.columnName)
        ?.value
        ?.toString() ?? '';
    // The new cell value must be reset.
    // To avoid committing the [DataGridCell] value that was previously edited
    // into the current non-modified [DataGridCell].
    newCellValue = null;

    final bool isNumericType = column.columnName == 'BMDNO' || column.columnName == 'BMDAMT';
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
        onChanged: (String value) async {
          if (value.isNotEmpty && double.parse(value)>0) {
            if (isNumericType && column.columnName == 'BMDNO' ) {
              newCellValue = double.parse(value);
              print(newCellValue);
              controller.BMDNO_VAL=newCellValue;
              controller.BMDNOController.text=newCellValue.toString();

              await controller.Calculate_BMD_NO_AM();

              controller.BMDAM_TX= controller.BMDAM1! + controller.BMDTXA2!;

              controller.BMDNF = controller.BMDNFController.text.isEmpty ? 0 : double.parse(controller.BMDNFController.text);

              controller.BMDDI_TX=  (controller.roundDouble((((double.parse(controller.BMDDIController.text)+ ((controller.BMDAM1!+controller.BMDTXA2!)
                  *(0/100)))*controller.BMDNO_V!)+(controller.BMDNF! <= 0 ? 0  : controller.BMDAM1! * controller.BMDNF!)),controller.SCSFL )) /(controller.BMDNO_V!+controller.BMDNF!);

              controller.BMDAMT3=controller.roundDouble((controller.BMDAM_TX!-controller.BMDDI_TX!)*(controller.BMDNO_V!+controller.BMDNF!),controller.SCSFL);

              controller.TCAMT=controller.roundDouble((controller.BMDAMT3! * (controller.TCRA!/100))/controller.BMDNO_V! * controller.BMDNO_V!,controller.SCSFL_TX);

           //    //يحسب الاجمالي
           //    controller.BMDAMT=controller.roundDouble(controller.BMDAM!* newCellValue,6);
           //    //مبلع الضريبة
           //    controller.BMDTXAT= controller.roundDouble(controller.BMDTXA!*newCellValue,6);
           //    //الاجمالي الكلي
           //    controller.BMMAMController.text=controller.roundDouble(controller.BMDAMT!+ controller.BMDTXAT!,controller.SCSFL).toString();
           //    //اجمالي الضريبه
           //    controller.BMMTXController.text=controller.roundDouble((controller.BMDTXAT!),controller.SCSFL).toString();
           // //   dataGridRow.getCells().elementAt(1).value=3;
           //    UpdateBIF_MOV_D(newCellValue,controller.BMDAMT!,controller.BMMID,dataGridRow.getCells()[3].value,
           //        controller.BMDTXA,controller.BMDTXAT,controller.roundDouble(controller.BMDAM!*controller.SCEX!,6));

              print(controller.BMDAM1);
              print(controller.SUMBMDAMTFController.text);
              print('BMDAM11111');


              await UpdateBIF_MOV_D(
                  controller.BMDNO_V!,
                  double.parse( controller.SUMBMDAMController.text),
                  controller.BMMID,
                  dataGridRow.getCells()[3].value,
                  controller.BMDAM1!,
                  controller.roundDouble(controller.BMDAM1! * double.parse(controller.SCEXController.text), 6),
                  double.parse(controller.BMDTXController.text) + double.parse(controller.BMDTX2Controller.text) +
                      double.parse(controller.BMDTX3Controller.text),
                  controller.BMDTXController.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
                  controller.BMDTX2Controller.text.isEmpty ? 0 : double.parse(controller.BMDTX2Controller.text),
                  controller.BMDTX3Controller.text.isEmpty ? 0 : double.parse(controller.BMDTX3Controller.text),
                  controller.BMDTXA!,
                  controller.BMDTXA2!,
                  controller.BMDTXA3!,
                  controller.BMDTXA! + controller.BMDTXA2! + controller.BMDTXA3!,
                  controller.BMDTXT1!,
                  controller.BMDTXT2!,
                  controller.BMDTXT3!,
                  double.parse(controller.BMDTXTController.text),
                  controller.BMDAM_TX,
                  controller.BMDDI_TX,
                  controller.BMDAMT3,
                  controller.TCAMT);


              await  controller.GET_SUMBMDTXA();
              await  controller.GET_SUMBMMDIF();
              await  controller.GET_SUMBMMDI();
              await  controller.GET_SUMBMMAM();
              await  controller.GET_SUMBMMAM2();
              await  controller.GET_CountRecode(controller.BMMID!);
              await  controller.GET_COUNT_BMDNO_P(controller.BMMID!);
              await  controller.GET_SUMBMDTXT();
              await  controller.GET_SUM_AM_TXT_DI();
              // controller.BMDAM_VAL=controller.BMDAMT;
              controller.loading(true);
              DataGrid();
              controller.update();
              //      handleRefresh();
              print('BMMAMTOTController111');
              print(controller.BMMAMTOTController.text);
            }

            else if(isNumericType && column.columnName == 'BMDAMT'){
              newCellValue = double.parse(value);
              controller.BMDAM_VAL=newCellValue;
              print(controller.USING_TAX_SALES);
              print(controller.BMDTX);
              print(newCellValue);
              print('newCellValue');
              double tmpAm=double.parse(controller.BMDAMController.text);
              if(controller.USING_TAX_SALES=='2' && controller.BMDTX!=0){
                tmpAm+=(tmpAm*(controller.BMDTX!/100));
              }

              print(newCellValue);
              //يحسب الكمية
              controller.BMDNO=(newCellValue/tmpAm);
              controller.BMDNOController.text= controller.roundDouble(controller.BMDNO!,6).toString();


              print('controller.BMDAMController.text');
              print(controller.BMDAMController.text);
              print(controller.BMDNOController.text);

              // controller.BMDNOController.text.isEmpty ? controller.BMDNOController.text='0.0'
              //     :controller.BMDNOController.text;

              await controller.Calculate_BMD_NO_AM();


             //يحسب الكمية
             // controller.BMDNO=(newCellValue/double.parse(controller.BMDAMController.text));
             // controller.BMDNOController.text= controller.roundDouble(controller.BMDNO!,2).toString();
             // controller.BMDNOController.text= controller.roundDouble(controller.BMDNO!,6).toString();


              controller.BMDAMTXController.text= newCellValue.toString();

              print('controller.BMDNOController.text');
              print(controller.BMDNOController.text);
              print(controller.BMDAMController.text);

              controller.BMDAM_TX= controller.BMDAM1! + controller.BMDTXA2!;

              controller.BMDNF = controller.BMDNFController.text.isEmpty ? 0.0 : double.parse(controller.BMDNFController.text);

              controller.BMDDI_TX=  (controller.roundDouble((((double.parse(controller.BMDDIController.text)+ ((controller.BMDAM1!+controller.BMDTXA2!)
                  *(0/100)))*controller.BMDNO_V!)+(controller.BMDNF! <= 0 ? 0  : controller.BMDAM1! * controller.BMDNF!)),controller.SCSFL )) /(controller.BMDNO_V!+controller.BMDNF!);

              controller.BMDAMT3=controller.roundDouble((controller.BMDAM_TX!-controller.BMDDI_TX!)*(controller.BMDNO_V!+controller.BMDNF!),controller.SCSFL);

              controller.TCAMT=controller.roundDouble((controller.BMDAMT3! * (controller.TCRA!/100))/controller.BMDNO_V! * controller.BMDNO_V!,controller.SCSFL_TX);

              // //يحسب الاجمالي
              // controller.BMDAMT=controller.roundDouble(controller.BMDAM! * double.parse(controller.BMDNOController.text),6);
              // //مبلع الضريبة
              // controller.BMDTXAT = controller.roundDouble(controller.BMDTXA!*double.parse(controller.BMDNOController.text),6);
              // //الاجمالي الكلي
              // controller.BMMAMController.text=controller.roundDouble((controller.BMDAMT!) + (controller.BMDTXAT!),controller.SCSFL).toString();
              // //اجمالي الضريبه
              // controller.BMMTXController.text=controller.roundDouble((controller.BMDTXAT!),controller.SCSFL).toString();

              // controller.BMDNO_VAL=controller.roundDouble(controller.BMDNO!,controller.SCSFL);

              await UpdateBIF_MOV_D(
                  controller.BMDNO_V!,
                  double.parse(controller.SUMBMDAMController.text),
                  controller.BMMID,
                  dataGridRow.getCells()[3].value,
                  controller.BMDAM1!,
                  controller.roundDouble(controller.BMDAM1! * double.parse(controller.SCEXController.text), 6),
                  double.parse(controller.BMDTXController.text) + double.parse(controller.BMDTX2Controller.text) +
                      double.parse(controller.BMDTX3Controller.text),
                  controller.BMDTXController.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
                  controller.BMDTX2Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
                  controller.BMDTX3Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
                  controller.BMDTXA!,
                  controller.BMDTXA2!,
                  controller.BMDTXA3!,
                  controller.BMDTXA! + controller.BMDTXA2! + controller.BMDTXA3!,
                  controller.BMDTXT1!,
                  controller.BMDTXT2!,
                  controller.BMDTXT3!,
                  double.parse(controller.BMDTXTController.text),
                  controller.BMDAM_TX,
                  controller.BMDDI_TX,
                  controller.BMDAMT3,
                  controller.TCAMT);

              await  controller.GET_SUMBMDTXA();
              await  controller.GET_SUMBMMDIF();
              await  controller.GET_SUMBMMDI();
              await  controller.GET_SUMBMMAM();
              await  controller.GET_SUMBMMAM2();
              await  controller.GET_CountRecode( controller.BMMID!);
              await  controller.GET_COUNT_BMDNO_P( controller.BMMID!);
              await  controller.GET_SUMBMDTXT();
              await  controller.GET_SUM_AM_TXT_DI();

              // UpdateBIF_MOV_M(double.parse(controller.BMMAMController.text),
              //     double.parse(controller.BMMTXController.text),controller.BMMID);
              controller.loading(true);
              DataGrid();
              controller.update();
          //    handleRefresh();
            }
            else {
              newCellValue = value;
            }
          }
          else {
            newCellValue = 0.0;
            controller.BMDAMT=0.0;
            controller.BMMAMController.text='0.0';
            controller.BMDNOController.text= '0';
            await controller.Calculate_BMD_NO_AM();
            await UpdateBIF_MOV_D(
                controller.BMDNO_V!,
                double.parse( controller.SUMBMDAMController.text),
                controller.BMMID,
                dataGridRow.getCells()[3].value,
                controller.BMDAM1!,
                controller.roundDouble(controller.BMDAM1! * double.parse(controller.SCEXController.text), 6),
                double.parse(controller.BMDTXController.text) + double.parse(controller.BMDTX2Controller.text) +
                    double.parse(controller.BMDTX3Controller.text),
                controller.BMDTXController.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
                controller.BMDTX2Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
                controller.BMDTX3Controller.text.isEmpty ? 0 : double.parse(controller.BMDTXController.text),
                controller.BMDTXA!,
                controller.BMDTXA2!,
                controller.BMDTXA3!,
                controller.BMDTXA! + controller.BMDTXA2! + controller.BMDTXA3!,
                controller.BMDTXT1!,
                controller.BMDTXT2!,
                controller.BMDTXT3!,
                double.parse(controller.BMDTXTController.text),
                controller.BMDAM_TX,
                controller.BMDDI_TX,
                controller.BMDAMT3,
                controller.TCAMT);

            await  controller.GET_SUMBMDTXA();
            await  controller.GET_SUMBMMDIF();
            await  controller.GET_SUMBMMDI();
            await  controller.GET_SUMBMMAM();
            await  controller.GET_SUMBMMAM2();
            await  controller.GET_CountRecode( controller.BMMID!);
            await  controller.GET_COUNT_BMDNO_P( controller.BMMID!);
            await  controller.GET_SUMBMDTXT();
            await  controller.GET_SUM_AM_TXT_DI();

            // UpdateBIF_MOV_D(newCellValue,controller.BMDAMT!,controller.BMMID,dataGridRow.getCells()[3].value,
            //     controller.BMDTXA,controller.BMDTXAT,controller.roundDouble(controller.BMDAM! * controller.SCEX!,6));
             controller.update();
          }
        },
        onTap: (){
          if (controller.UPDATEController.text.isEmpty) {
            return;
          } else {
            controller.UPDATEController.selection = TextSelection(baseOffset: 0,
                extentOffset: controller.UPDATEController.text.length);
          }
          //controller.UPDATEController.clear();
        },
        onSubmitted: (String value) {
          submitCell();
        },
      ),
    );
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    return  DataGridRowAdapter(cells: [
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
        DataGridCell(columnName: 'CIMNA_D', value: dataGridRow.CIMNA_D),
        DataGridCell(columnName: 'BMDNO', value: dataGridRow.BMDNO),
        DataGridCell(columnName: 'BMDAM1', value: dataGridRow.BMDAM),
        DataGridCell(columnName: 'BMDID', value: dataGridRow.BMDID),
        DataGridCell(columnName: 'BMDAMT', value: dataGridRow.BMDAMT),
        DataGridCell(columnName: 'BMDAMO', value: dataGridRow.BMDAMO),
        DataGridCell(columnName: 'BMDAM', value: dataGridRow.BMDAM),
        DataGridCell(columnName: 'BMDDI', value: dataGridRow.BMDDI),
      ]);
    }).toList(growable: false);
  }
  void updateDataSource() {
    notifyListeners();
  }
}