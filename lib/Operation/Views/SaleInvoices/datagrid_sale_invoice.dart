import 'dart:async';
import 'dart:math';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Operation/models/bil_mov_d.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../database/invoices_db.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'AddItem.dart';

class DataGridPageInvoice extends StatefulWidget {
  @override
  _DataGridPageInvoiceState createState() => _DataGridPageInvoiceState();
}
class _DataGridPageInvoiceState extends State<DataGridPageInvoice> {

  Future<InventoryDataGridSource> getInventoryDataSource() async {
    var InvoicesList = await GET_BIL_MOV_D(controller.BMKID==11 || controller.BMKID==12?'BIF_MOV_D':'BIL_MOV_D',controller.BMMID.toString(),controller.SER_MINA.toString(),'2');
    return InventoryDataGridSource(InvoicesList);
  }

  final Sale_Invoices_Controller controller = Get.find();

 EDIT_INV(BuildContext context, DataGridRow row, int rowIndex) async {
   controller.ClearBil_Mov_D_Data();
   if(controller.TTID1!=null){
     await controller.GET_TAX_LIN_P('MAT',row.getCells()[2].value.toString(),row.getCells()[11].value.toString());
   }
   controller.BMMIDController.text = row.getCells()[0].value.toString();
   controller.BMDIDController.text = row.getCells()[1].value.toString();
   controller.MGNOController.text = row.getCells()[2].value.toString();
   controller.SelectDataMGNO = row.getCells()[2].value.toString();
   controller.SelectDataMGNO2 = "${row.getCells()[2].value.toString() + " +++ " +
       "${LoginController().LAN==2?row.getCells()[24].value.toString():row.getCells()[23].value.toString()}"}";
   controller.SelectDataMINO = row.getCells()[11].value.toString();
   controller.SelectDataMUID = row.getCells()[12].value.toString();
   controller.MINAController.text = row.getCells()[13].value.toString();
   controller.SIID_V2= row.getCells()[35].value.toString();
   controller.BMDNOController.text =  controller.USE_BMDFN=='1'?row.getCells()[4].value.toString():(row.getCells()[4].value+row.getCells()[5].value).toString();
   controller.BMDNO_V = row.getCells()[4].value;
   controller.BMDNFController.text = row.getCells()[5].value.toString();
   controller.BMDAMController.text = row.getCells()[6].value.toString();
   controller.BMDAM1 = row.getCells()[6].value;
   controller.BMDDIController.text = row.getCells()[7].value.toString();
   controller.BMDDIRController.text = row.getCells()[8].value.toString();
   controller.SelectDataSNED = row.getCells()[9].value.toString();
   controller.BMDEDController.text = row.getCells()[9].value.toString();
   controller.BMDTXAController.text = row.getCells()[10].value.toString();
   controller.BMDTX = row.getCells()[14].value;
   controller.BMDTXController.text = row.getCells()[26].value.toString();
   controller.BMDTX2Controller.text = row.getCells()[27].value.toString();
   controller.BMDTX3Controller.text = row.getCells()[28].value.toString();
   controller.SelectDataMUCNA=row.getCells()[3].value.toString();
   controller.BMDINController.text=row.getCells()[15].value.toString();
   controller.SUMBMDAMController.text=row.getCells()[16].value.toString();
   controller.SUMBMDAMTFController.text=row.getCells()[17].value.toString();
   controller.BMDTXTController.text=row.getCells()[18].value.toString();
   controller.BMDDITController.text=row.getCells()[19].value.toString();
   controller.SUM_Totle_BMDDI=row.getCells()[20].value;
   controller.MITSK=row.getCells()[21].value;
   controller.MGKI=row.getCells()[22].value;
   controller.BMDTXA=row.getCells()[29].value;
   controller.BMDTXA2=row.getCells()[30].value;
   controller.BMDTXA3=row.getCells()[31].value;
   controller.BMDTXT1=row.getCells()[32].value;
   controller.BMDTXT2=row.getCells()[33].value;
   controller.BMDTXT3=row.getCells()[34].value;
   controller.TCRA=row.getCells()[36].value;
   controller.TCID_D=row.getCells()[37].value;
   controller.TCSY_D=row.getCells()[38].value.toString();
   controller.TCSDID=row.getCells()[39].value;
   controller.TCSDSY=row.getCells()[40].value.toString();
   controller.TCVL=row.getCells()[41].value;
   controller.BMDAM_TX=row.getCells()[42].value;
   controller.BMDDI_TX=row.getCells()[43].value;
   controller.BMDAMT3=row.getCells()[44].value;
   controller.TCAMT=row.getCells()[45].value;
   controller.titleAddScreen = 'StringEdit'.tr;
   controller.TextButton_title = 'StringEdit'.tr;
   await controller.GET_STO_NUM_P(controller.SelectDataMUID.toString());
   Timer(const Duration(seconds: 1), () {
     controller.fetchAutoCompleteData(2, '2');
     controller. Calculate_BMD_NO_AM();
     Additem().displayAddItemsWindo();
     controller.myFocusNode.requestFocus();
     controller.update();
   });
}

 DELETE_INV(DataGridRow row) async {
   await deleteBIL_MOV_D_ONE(
       row.getCells()[25].value==11 || row.getCells()[25].value==12?'BIF_MOV_D':'BIL_MOV_D',
       row.getCells()[0].value.toString(),row.getCells()[1].value.toString());
   controller.update();
   await controller.GET_SUMBIL_P();
   await controller.GET_CountRecode(row.getCells()[0].value);
   controller.update();
   //الخصم علي مستوى الفاتورة
   if(controller.SelectDataBMMDN=='0' && (double.parse(controller.BMMDIController.text)>0 ||
       double.parse(controller.BMMDIRController.text)>0 )){
     await controller.UPDATE_BMMDI();
   }
   controller.update();
   Fluttertoast.showToast(
       msg: 'StringDelete'.tr,
       toastLength: Toast.LENGTH_LONG,
       textColor: Colors.white,
       backgroundColor: Colors.redAccent);
   await UpdateBIL_MOV_M_SUM(
       controller.BMKID==11 || controller.BMKID==12?'BIF_MOV_M':'BIL_MOV_M',
       controller.BMKID!,
       controller.BMMID!,
       controller.roundDouble(double.parse(controller.BMMAMController.text)+double.parse(controller.SUMBMDTXTController.text),controller.SCSFL),
       controller.SUMBMDTXT!,
       int.parse(controller.CountRecodeController.text),
       controller.roundDouble((double.parse(controller.BMMAMController.text)+double.parse(controller.SUMBMDTXTController.text)) * double.parse(controller.SCEXController.text), 2).toString(),
       controller.SUMBMMDIF!,
       controller.SelectDataBMMDN=='1'? controller.SUMBMMDI!: controller.BMMDIController.text.isNotEmpty ? double.parse(controller.BMMDIController.text) : 0,
       controller.BMMDIRController.text.isNotEmpty ? double.parse(controller.BMMDIRController.text) : 0,
       double.parse(controller.BMMAMTOTController.text),
       controller.SUMBMDTXT1!,
       controller.SUMBMDTXT2!,
       controller.SUMBMDTXT3!,
       controller.BMMAM_TX,
       controller.BMMDI_TX,
       controller.TCAM);
}

  Widget _bildswipeingEdit(BuildContext context, DataGridRow row, int rowIndex) {
    return GestureDetector(
        onTap: ()   async {
          EDIT_INV(context,row,rowIndex);
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

  @override
  Widget build(BuildContext context) {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) =>FutureBuilder(
      future: getInventoryDataSource(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        return snapshot.hasData
            ? SfDataGridTheme(
          data: SfDataGridThemeData(headerColor: const Color(0xFFECEFF0)),
          child: SfDataGrid(
            columnWidthMode: ColumnWidthMode.fill,
            navigationMode: GridNavigationMode.cell,
            source: snapshot.data,
            selectionMode: SelectionMode.single,
            onSelectionChanged: (addedRows, removedRows) {
              if (addedRows.isNotEmpty) {
                int index = snapshot.data.rows.indexOf(addedRows.first);
                controller.selectedRowIndex.value = index;
              } else {
                controller.selectedRowIndex.value = -1;
              }
            },
            allowSwiping: true,
            swipeMaxOffset:80,
            editingGestureType: EditingGestureType.tap,
            columns: getColumns(),
            onCellTap: ((details) {
              if (details.rowColumnIndex.rowIndex != 0) {
                int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
                var row = snapshot.data.effectiveRows.elementAt(selectedRowIndex);
                EDIT_INV(context,row, selectedRowIndex);
              }
            }),
            // onCellDoubleTap: ((details) async {
            //   if (details.rowColumnIndex.rowIndex != 0) {
            //     int selectedRowIndex = details.rowColumnIndex.rowIndex - 1;
            //     var row = snapshot.data.effectiveRows.elementAt(selectedRowIndex);
            //     await DELETE_INV(row);
            //   }
            // }),
            endSwipeActionsBuilder: _bildswipeingEdit,
            startSwipeActionsBuilder: (BuildContext context, DataGridRow row, int rowIndex) {
              return GestureDetector(
                  onTap: () async {
                   await DELETE_INV(row);
                   // await controller.renumberbmdid(row.getCells()[25].value==11
                   //     || row.getCells()[25].value==12?'BIF_MOV_D':'BIL_MOV_D',
                   //     row.getCells()[0].value.toString());
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
    )));
  }

  List<GridColumn> getColumns() {
    return  controller.SelectDataBMMDN=='1' && controller.Allow_give_Discount=='1' && controller.UPIN_BMMDI==1?
    <GridColumn>[
      GridColumn(
          columnName: 'MGNO',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMgno'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'NAM',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMINO'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      controller.Use_Multi_Stores=='1' && ((controller.BMKID==3 || controller.BMKID==4)
          && StteingController().MULTI_STORES_BO==true)
          || ((controller.BMKID==1 || controller.BMKID==2)
          && StteingController().MULTI_STORES_BI==true)?GridColumn(
          columnName: 'SIID',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSIIDlableText'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
      GridColumn(columnName: 'SIID', width: 1, label: Container()),
      GridColumn(
          columnName: 'BMDNO',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSNNO'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
          controller.BMKID==1 || controller.BMKID==2 || controller.Allow_give_Free_Quantities=='1' && controller.UPIN_BMDNF==1?GridColumn(
          columnName: 'BMDNF',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringBMDNF'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
      GridColumn(columnName: 'BMDNF', width: 1, label: Container()),
      GridColumn(
          columnName: 'BMDAM',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMPCO'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'BMDDI',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringBMMDI'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'BMDDIR',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  const Text(
                '%',
                style: TextStyle(fontFamily: 'Hacen'),
              ))),
          controller.SMDED !='2' && controller.BMKID!=11  && controller.BMKID!=12?GridColumn(
          columnName: 'BMDED',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSMDED'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
          GridColumn(
          columnName: 'BMDED',
          width: 1,
          label: Container()),
      controller.SVVL_TAX!='2'?GridColumn(
          columnName: 'BMDTXA',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSUM_BMMTX'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
      GridColumn(
          columnName: 'BMDTXA',
          width: 1,
          label: Container()),
      GridColumn(
          columnName: 'SUMBMDAM',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSUMBMDAM'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      controller.SVVL_TAX!='2'?GridColumn(
          columnName: 'SUMBMDTXA',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSUM_BMDTX'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
      GridColumn(
          columnName: 'SUMBMDTXA',
          width: 1,
          label: Container()),
    ]:
    <GridColumn>[
      GridColumn(
          columnName: 'MGNO',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMgno'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      GridColumn(
          columnName: 'NAM',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMINO'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      controller.Use_Multi_Stores=='1' && ((controller.BMKID==3 || controller.BMKID==4) && StteingController().MULTI_STORES_BO==true)
          || ((controller.BMKID==1 || controller.BMKID==2) && StteingController().MULTI_STORES_BI==true)?GridColumn(
          columnName: 'SIID',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSIIDlableText'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
      GridColumn(columnName: 'SIID', width: 1, label: Container()),
      GridColumn(
          columnName: 'BMDNO',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSNNO'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
          controller.BMKID==1 || controller.BMKID==2 || controller.Allow_give_Free_Quantities=='1' && controller.UPIN_BMDNF==1?GridColumn(
          columnName: 'BMDNF',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringBMDNF'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
          GridColumn(
          columnName: 'BMDNF',
          width: 1,
          label: Container()),
      GridColumn(
          columnName: 'BMDAM',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringMPCO'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      // GridColumn(
      //     columnName: 'BMDDI',
      //     width: double.nan,
      //     columnWidthMode: ColumnWidthMode.auto,
      //     label: Container(
      //         alignment: Alignment.center,
      //         child:  Text(
      //           'StringBMMDI'.tr,
      //           style: const TextStyle(fontFamily: 'Hacen'),
      //         ))),
          controller.SMDED !='2' && controller.BMKID!=11 && controller.BMKID!=12?GridColumn(
          columnName: 'BMDED',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSMDED'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
          GridColumn(
          columnName: 'BMDED',
          width: 1,
          label: Container()),
      controller.SVVL_TAX!='2'?GridColumn(
          columnName: 'BMDTXA',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSUM_BMMTX'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
      GridColumn(
          columnName: 'BMDTXA',
          width: 1,
          label: Container()),
      GridColumn(
          columnName: 'SUMBMDAM',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSUMBMDAM'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))),
      controller.SVVL_TAX!='2'?GridColumn(
          columnName: 'SUMBMDTXA',
          width: double.nan,
          columnWidthMode: ColumnWidthMode.auto,
          label: Container(
              alignment: Alignment.center,
              child:  Text(
                'StringSUM_BMDTX'.tr,
                style: const TextStyle(fontFamily: 'Hacen'),
              ))):
      GridColumn(
          columnName: 'SUMBMDTXA',
          width: 1,
          label: Container()),
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

  double roundDouble(double value, int places){
    num mod = pow(10.0, places);
    return ((value * mod).round().toDouble() / mod);
  }

  @override
  DataGridRowAdapter? buildRow(DataGridRow row) {
    int rowIndex = dataGridRows.indexOf(row);
    bool isSelected = rowIndex == controller.selectedRowIndex.value;

   // bool isSelected = rowIndex == employeeData.indexWhere((e) => e.id == row.getCells()[0].value);

    return   controller.SelectDataBMMDN=='1' && controller.Allow_give_Discount=='1' && controller.UPIN_BMMDI==1?
    DataGridRowAdapter(
        color: isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
        cells: [
      Container(
        alignment: Alignment.center,
        child:  Text(row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      controller.Use_Multi_Stores=='1' && ((controller.BMKID==3 || controller.BMKID==4) && StteingController().MULTI_STORES_BO==true)
          || ((controller.BMKID==1 || controller.BMKID==2) && StteingController().MULTI_STORES_BI==true)?Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[35].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):
      Container(),
      Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[4].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
        controller.BMKID==1 || controller.BMKID==2 || controller.Allow_give_Free_Quantities=='1' && controller.UPIN_BMDNF==1?Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[5].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):Container(),
      Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[6].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[7].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[8].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      controller.SMDED !='2' && controller.BMKID!=11 && controller.BMKID!=12?Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[9].value.toString()=='null'?'':row.getCells()[9].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):Container(),
      controller.SVVL_TAX!='2'?Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[10].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):Container(),
      Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(roundDouble(row.getCells()[16].value,controller.SCSFL)).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      controller.SVVL_TAX!='2'? Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(roundDouble(row.getCells()[16].value+ row.getCells()[18].value,controller.SCSFL)).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):
      Container(),
    ]):
    DataGridRowAdapter(
        color: isSelected ? Colors.grey.withOpacity(0.2) : Colors.transparent,
        cells: [
      Container(
        alignment: Alignment.center,
        child:  Text(row.getCells()[2].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[3].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      controller.Use_Multi_Stores=='1' && ((controller.BMKID==3 || controller.BMKID==4) && StteingController().MULTI_STORES_BO==true)
          || ((controller.BMKID==1 || controller.BMKID==2) && StteingController().MULTI_STORES_BI==true)?Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[35].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):
      Container(),
      Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[4].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      controller.BMKID==1 || controller.BMKID==2 ||  controller.Allow_give_Free_Quantities=='1' && controller.UPIN_BMDNF==1?Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[5].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):Container(),
      Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[6].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      // Container(
      //   alignment: Alignment.center,
      //   child: Text(controller.formatter.format(row.getCells()[7].value).toString(),
      //       overflow: TextOverflow.ellipsis,
      //       style: const TextStyle(fontFamily: 'Hacen')),
      // ),
      controller.SMDED !='2' && controller.BMKID!=11 && controller.BMKID!=12?Container(
        alignment: Alignment.center,
        child: Text(row.getCells()[9].value.toString()=='null'?'':row.getCells()[9].value.toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):Container(),
      controller.SVVL_TAX!='2'?Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(row.getCells()[10].value).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ):Container(),
      Container(
        alignment: Alignment.center,
        child: Text(controller.formatter.format(roundDouble(row.getCells()[16].value,controller.SCSFL)).toString(),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontFamily: 'Hacen')),
      ),
      controller.SVVL_TAX!='2'? Container(
    alignment: Alignment.center,
    child: Text(controller.formatter.format(roundDouble(row.getCells()[16].value+ row.getCells()[18].value,controller.SCSFL)).toString(),
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontFamily: 'Hacen')),
    ):
      Container(),
    ]);
  }

  @override
  List<DataGridRow> get rows => dataGridRows;
  void buildDataGridRow() {
    dataGridRows = InvoiceList.map<DataGridRow>((dataGridRow) {
      return DataGridRow(cells: [
        DataGridCell(columnName: 'BMMID', value: dataGridRow.BMMID),
        DataGridCell(columnName: 'BMDID', value: dataGridRow.BMDID),
        DataGridCell<String>(columnName: 'MGNO', value: dataGridRow.MGNO),
        DataGridCell<String>(columnName: 'NAM', value: dataGridRow.NAM),
        DataGridCell(columnName: 'BMDNO', value: dataGridRow.BMDNO),
        DataGridCell(columnName: 'BMDNF', value: dataGridRow.BMDNF),
        DataGridCell(columnName: 'BMDAM', value: dataGridRow.BMDAM),
        DataGridCell(columnName: 'BMDDI', value: dataGridRow.BMDDI),
        DataGridCell(columnName: 'BMDDIR', value: dataGridRow.BMDDIR),
        DataGridCell(columnName: 'BMDED', value: dataGridRow.BMDED),
        DataGridCell(columnName: 'BMDTXA', value: dataGridRow.BMDTXA),
        DataGridCell<String>(columnName: 'MINO', value: dataGridRow.MINO),
        DataGridCell<int>(columnName: 'MUID', value: dataGridRow.MUID),
        DataGridCell<String>(columnName: 'MINA_D', value: dataGridRow.MINA_D),
        DataGridCell(columnName: 'BMDTX', value: dataGridRow.BMDTX),
        DataGridCell(columnName: 'BMDIN', value: dataGridRow.BMDIN),
        DataGridCell(columnName: 'BMDAMT', value: dataGridRow.BMDAMT),
        DataGridCell(columnName: 'BMDAMTF', value: dataGridRow.BMDAMTF),
        DataGridCell(columnName: 'BMDTXT', value: dataGridRow.BMDTXT),
        DataGridCell(columnName: 'BMDDIT', value: dataGridRow.BMDDIT),
        DataGridCell(columnName: 'BMDDIM', value: dataGridRow.BMDDIM),
        DataGridCell(columnName: 'MITSK', value: dataGridRow.MITSK),
        DataGridCell(columnName: 'MGKI', value: dataGridRow.MGKI),
        DataGridCell(columnName: 'MGNA', value: dataGridRow.MGNA),
        DataGridCell(columnName: 'MGNE', value: dataGridRow.MGNE),
        DataGridCell(columnName: 'BMKID', value: dataGridRow.BMKID),
        DataGridCell(columnName: 'BMDTX1', value: dataGridRow.BMDTX1),
        DataGridCell(columnName: 'BMDTX2', value: dataGridRow.BMDTX2),
        DataGridCell(columnName: 'BMDTX3', value: dataGridRow.BMDTX3),
        DataGridCell(columnName: 'BMDTXA1', value: dataGridRow.BMDTXA1),
        DataGridCell(columnName: 'BMDTXA2', value: dataGridRow.BMDTXA2),
        DataGridCell(columnName: 'BMDTXA3', value: dataGridRow.BMDTXA3),
        DataGridCell(columnName: 'BMDTXT1', value: dataGridRow.BMDTXT1),
        DataGridCell(columnName: 'BMDTXT2', value: dataGridRow.BMDTXT2),
        DataGridCell(columnName: 'BMDTXT3', value: dataGridRow.BMDTXT3),
        DataGridCell(columnName: 'SIID', value: dataGridRow.SIID),
        DataGridCell(columnName: 'TCRA', value: dataGridRow.TCRA),
        DataGridCell(columnName: 'TCID', value: dataGridRow.TCID),
        DataGridCell(columnName: 'TCSY', value: dataGridRow.TCSY),
        DataGridCell(columnName: 'TCSDID', value: dataGridRow.TCSDID),
        DataGridCell(columnName: 'TCSDSY', value: dataGridRow.TCSDSY),
        DataGridCell(columnName: 'TCVL', value: dataGridRow.TCVL),
        DataGridCell(columnName: 'BMDAM_TX', value: dataGridRow.BMDAM_TX),
        DataGridCell(columnName: 'BMDDI_TX', value: dataGridRow.BMDDI_TX),
        DataGridCell(columnName: 'BMDAMT3', value: dataGridRow.BMDAMT3),
        DataGridCell(columnName: 'TCAMT', value: dataGridRow.TCAMT),
      ]);
    }).toList(growable: false);
  }
  void updateDataSource() {
    notifyListeners();
  }
}