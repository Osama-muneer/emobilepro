import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/sizes_helpers.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../routes/routes.dart';
import '../../Controllers/sale_invoices_controller.dart';
import '../SaleInvoices/counter_invoices_datagrid.dart';

class Add_Edit_CounterSalesInvoiceView extends StatefulWidget {
  const Add_Edit_CounterSalesInvoiceView({Key? key}) : super(key: key);
  @override
  State<Add_Edit_CounterSalesInvoiceView> createState() => _Add_Edit_CounterSalesInvoiceViewState();
}


class _Add_Edit_CounterSalesInvoiceViewState extends State<Add_Edit_CounterSalesInvoiceView> {
  final Sale_Invoices_Controller controller = Get.find();

  void DataGrid() {
    setState(() {
      DataGridPage();
      controller.update();
    });
  }

  List<Widget> createRadioListPay_Kin() {
    List<Widget> widgets = [];
    for (Pay_Kin_Local user in controller.PAY_KIN_LIST) {
      widgets.add(GetBuilder<Sale_Invoices_Controller>( init: Sale_Invoices_Controller(),
        builder: ((controller)=>
            InkWell(
              onTap: () => controller.setSelectedPay_Kin(user.PKID!),
              child: Row(
                  children: [
                    Radio<dynamic>(
                      value: user.PKID,
                      groupValue: controller.PKID,
                      // title: Text(user.PKNA_D.toString()),
                      onChanged: (currentUser) {
                        controller.loading(true);
                        controller.setSelectedPay_Kin(currentUser!);
                        print('user.PKID');
                        print(user.PKID);
                        print(controller.SelectDataPKID);
                        controller.BCIDController.clear();
                        controller.BCNAController.clear();
                        controller.AANOController.clear();
                        controller.BCCIDController.clear();
                        controller.BCCNAController.clear();
                        controller.update();
                      },
                      activeColor: AppColors.MainColor ,
                    ),
                    Text(user.PKNA_D.toString(),style:
                    ThemeHelper().buildTextStyle(context, Colors.grey,'M')),
                  ]),
            )),
      )
      );
    }
    return widgets;
  }

  Future<bool> onWillPop() async {
    final shouldPop = await Get.defaultDialog(
      title: 'StringChiksave2'.tr,
      middleText: 'StringChiksave'.tr,
      backgroundColor: Colors.white,
      radius: 40,
      textCancel: 'StringNo'.tr,
      cancelTextColor: Colors.red,
      textConfirm: 'StringYes'.tr,
      confirmTextColor: Colors.white,
      onConfirm: () {
        Navigator.of(context).pop(false);
        bool isValid = controller.delete_BIL_MOV(null, 1);
        if (isValid) {
          Get.offAndToNamed(Routes.Counter_Sale_Invoice);
        }
      },
    );
    return shouldPop ?? false;
  }
  Future<bool> onWillPop2() async {
    if(controller.edit == true){
      UpdateBIL_MOV_M_SUM(
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
    Navigator.of(context).pop(false);
    controller.GET_BIL_MOV_M_P('DateNow');
    final shouldPop = await Get.toNamed(Routes.Counter_Sale_Invoice);
    return shouldPop ?? false;
  }
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (controller.edit == true || controller.CheckBack == 0)
          ? onWillPop2
          : onWillPop,
      child: Scaffold(
        appBar:AppBar(
          iconTheme: IconThemeData(color: Colors.white),
          backgroundColor: AppColors.MainColor,
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.save,color: Colors.white),
                  onPressed: () async {
                    await controller.GET_BMMNO_P_COU();
                    controller.BMMST=2;
                    if(  controller.ASK_SAVE=='1'){
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'StringMessave'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringNo'.tr,
                        cancelTextColor: Colors.red,
                        textConfirm: 'StringYes'.tr,
                        confirmTextColor: Colors.white,
                        onConfirm: () {
                          Navigator.of(context).pop(false);
                          controller.editMode();
                          //      controller. get_BIF_MOV_M('DateNow');
                        },
                        // barrierDismissible: false,
                      );
                    }else{
                      controller.editMode();
                      //  controller. get_BIF_MOV_M('DateNow');
                    }
                  },
                ),
              ],
            )
          ],
          title: Text('${controller.titleScreen} - ${controller.BMMNO} ',style:
          ThemeHelper().buildTextStyle(context,AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: GetBuilder<Sale_Invoices_Controller>(
          init: Sale_Invoices_Controller(),
          builder: ((value) => SingleChildScrollView(child:
          Padding(
            padding:  EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
            child: Column(
              children: [
                Container(
                  height: displayHeight(context)  * 0.7,
                  child: Column(
                    children: [
                      SizedBox(height: 0.003 * height),
                      SizedBox(
                        height: displayHeight(context)  * 0.52,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GridView.builder(
                              shrinkWrap: true,
                              itemCount:  controller.COU_TYP_M_List.length,
                              gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: controller.COU_TYP_M_List.length==3?3:controller.COU_TYP_M_List.length==2?2:4,
                                childAspectRatio:controller.COU_TYP_M_List.length==3?2.4:controller.COU_TYP_M_List.length==2?4:2,
                                crossAxisSpacing: 5,
                              ),
                              itemBuilder: (BuildContext context, int index) {
                                return   Padding(
                                  padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                                  child: TextButton(
                                    onPressed: () {
                                      setState(() {
                                        controller.loading(true);
                                        controller.SelectDataCTMID=controller.COU_TYP_M_List[index].CTMID.toString();
                                        controller.CTMTYController.text=controller.COU_TYP_M_List[index].CTMTY.toString();
                                        LoginController().SET_P('CTMID_V',controller.COU_TYP_M_List[index].CTMID.toString());
                                        LoginController().SET_P('CTMTY_V',controller.COU_TYP_M_List[index].CTMTY.toString());
                                        controller.update();
                                        print(controller.COU_TYP_M_List[index].CTMTY.toString());
                                        controller.GET_COU_INF_M_P();
                                      });
                                    },
                                    style:  controller.COU_TYP_M_List[index].CTMID.toString()==controller.SelectDataCTMID?
                                    TextButton.styleFrom(
                                      side: const BorderSide(color: Colors.red),
                                      //foregroundColor: Colors.black,
                                      // backgroundColor: Colors.grey[400],
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.02 * height), // <-- Radius
                                      ),
                                    ):TextButton.styleFrom(
                                      side: const BorderSide(color: Colors.black45),
                                      // foregroundColor: Colors.black,
                                      shape:RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(0.02 * height), // <-- Radius
                                      ),
                                    ),
                                    child: Text(
                                        controller.COU_TYP_M_List[index].CTMNA_D.toString(),
                                        style:
                                        ThemeHelper().buildTextStyle(context, controller.COU_TYP_M_List[index].CTMID.toString()==controller.SelectDataCTMID?
                                        Colors.red:Colors.black,'M')
                                    ),
                                  ),
                                );
                              },
                            ),
                            const Divider(color: Colors.black,height: 7,),
                            Expanded(
                              child: GridView.builder(
                                  shrinkWrap: true,
                                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                    maxCrossAxisExtent: 250,
                                    childAspectRatio: 1.1,
                                  ),
                                  itemCount: controller.COU_INF_M_List.length,
                                  itemBuilder: (_,index){
                                    return Stack(
                                      alignment: Alignment.topCenter,
                                      children: [
                                        Positioned(
                                            child: Text(
                                              controller.COU_INF_M_List[index].CIMNA_D.toString(),
                                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                            )),
                                        InkWell(
                                          child: Container(
                                            margin: EdgeInsets.symmetric(vertical:  height * 0.028),
                                            decoration: BoxDecoration(
                                              image: controller.CTMTYController.text=='1'?
                                              const DecorationImage(
                                                  image:  AssetImage("${ImagePath}petrol.jpg"),
                                                  fit: BoxFit.contain) : controller.CTMTYController.text=='2'?
                                              const DecorationImage(
                                                  image:  AssetImage("${ImagePath}petrol95.jpg"),
                                                  fit: BoxFit.contain): controller.CTMTYController.text=='3'?
                                              const DecorationImage(
                                                  image:  AssetImage("${ImagePath}petrol91.jpg"),
                                                  fit: BoxFit.contain):controller.CTMTYController.text=='4'?
                                              const DecorationImage(
                                                  image:  AssetImage("${ImagePath}diesel.jpg"),
                                                  fit: BoxFit.contain):
                                              controller.CTMTYController.text=='5'?
                                              const DecorationImage(
                                                  image:  AssetImage("${ImagePath}Gas.jpg"),
                                                  fit: BoxFit.contain): const DecorationImage(
                                                  image:  AssetImage("${ImagePath}petrol.jpg"),
                                                  fit: BoxFit.contain),
                                              borderRadius: BorderRadius.circular(
                                                  0.01 * height),
                                            ),
                                          ),
                                          onTap: () async {
                                            controller.loading(true);
                                            print('--1');
                                            deleteBIF_MOV_D(controller.BMMID!);

                                            controller.GET_SUMBMDTXA();
                                            controller.GET_SUMBMMDIF();
                                            controller.GET_SUMBMMDI();
                                            controller.GET_SUMBMMAM();
                                            controller.GET_SUMBMMAM2();
                                            controller.GET_CountRecode( controller.BMMID!);
                                            controller.GET_COUNT_BMDNO_P( controller.BMMID!);
                                            controller.GET_SUMBMDTXT();
                                            controller.GET_SUM_AM_TXT_DI();

                                            controller.update();

                                            controller.BMMAMController.clear();
                                            controller.BMMAMController.text='0';
                                            print('--2');
                                            controller.SIIDController.text = controller.COU_INF_M_List[index].SIID.toString();
                                            controller.SelectDataSIID = controller.COU_INF_M_List[index].SIID.toString();
                                            controller.SIID_V2 = controller.COU_INF_M_List[index].SIID.toString();
                                            controller.MGNOController.text = controller.COU_INF_M_List[index].MGNO.toString();
                                            controller.MINOController.text =controller.COU_INF_M_List[index].MINO.toString();
                                            controller.MUIDController.text = controller.COU_INF_M_List[index].MUID.toString();
                                            controller.SelectDataMUID = controller.COU_INF_M_List[index].MUID.toString();
                                            controller.CTMIDController.text = controller.COU_INF_M_List[index].CTMID.toString();
                                            controller.CIMIDController.text = controller.COU_INF_M_List[index].CIMID.toString();
                                            // controller.BMDAM1 = double.parse(controller.COU_INF_M_List[index].MPS1.toString());
                                            controller.BMDAMController.text = controller.COU_INF_M_List[index].MPS1.toString();
                                            controller.SelectDataMINO = controller.COU_INF_M_List[index].MINO.toString();
                                            controller.MGNOController.text = controller.COU_INF_M_List[index].MGNO.toString();
                                            controller.SCIDOController.text = controller.COU_INF_M_List[index].SCIDO.toString();
                                            // controller.MITSK =controller.COU_INF_M_List[index].MITSK;
                                            // controller.MGKI = controller.COU_INF_M_List[index].MGKI;
                                            //  controller.GUIDMT = controller.COU_INF_M_List[index].GUID;
                                            await controller.GET_STO_NUM_P(controller.SelectDataMUID.toString());
                                            // await  controller.GETMUIDS();
                                            //  controller.MINAController.text = controller.COU_INF_M_List[index].MINA_D.toString();
                                            // controller.MIED = controller.COU_INF_M_List[index].MIED;
                                            controller.BMDNOController.text = '';
                                            controller.BMDNO_V = 0;
                                            controller.BMDNFController.text = '0';
                                            controller.SUMBMDAMController.text = '0';
                                            controller.BMDDIRController.text = '0';
                                            controller.BMDDIController.text = '0';
                                            if (controller.TTID1 != null) {
                                              await controller.GET_TAX_LIN_P('MAT', controller.COU_INF_M_List[index].MGNO.toString(),
                                                  controller.COU_INF_M_List[index].MINO.toString());
                                            }
                                            // controller.SVVL_TAX == '1' ?
                                            // controller.BMDTXController.text = controller.COU_INF_M_List[index].MITS.toString()
                                            //     : null;
                                            await controller.GET_COUNT_CIMID();
                                            Timer(const Duration(milliseconds: 300), () async {
                                              print('--4');
                                              //   controller.GET_USING_TAX_P();
                                              bool isValid =await controller.Save_BIF_MOV_D_P_COU();
                                              if (isValid) {
                                                DataGrid();
                                                print('--5');
                                                Timer(const Duration(milliseconds: 500), () {
                                                  if(StteingController().Type_Serach==0){
                                                    controller.dataGridController.beginEdit(RowColumnIndex(0, 1));
                                                  }else{
                                                    controller.dataGridController.beginEdit(RowColumnIndex(0, 3));
                                                  }
                                                  controller.UPDATEController.clear();
                                                  if (controller.UPDATEController.text.isEmpty) {
                                                    return;
                                                  } else {
                                                    controller.UPDATEController.selection = TextSelection(baseOffset: 0,
                                                        extentOffset: controller.UPDATEController.text.length);
                                                  }
                                                });
                                              }

                                            });
                                          },
                                        ),
                                        Positioned(
                                            bottom: height * 0.047,
                                            child: Row(
                                              children: [
                                                Text("${controller.SCSY} ",
                                                    style: ThemeHelper().buildTextStyle(context, Colors.white,'M')
                                                ),
                                                Text("${controller.COU_INF_M_List[index].MPS1.toString()}",
                                                  style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
                                                ),
                                              ],
                                            )),
                                      ],
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: displayHeight(context)  *0.17,
                        child: DataGridPage(),
                      ),
                    ],
                  ),
                ),
                Container(
                  width: double.infinity,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding:  EdgeInsets.only(right: 0.01 * height,left:0.01 * height),
                        child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: createRadioListPay_Kin(),),
                      ),
                      controller.SelectDataPKID.toString()!= '8' ? Padding(
                        padding: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                        child: TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCNAController,
                          textAlign: TextAlign.center,
                          decoration: ThemeHelper().InputDecorationDropDown('StringBCID'.tr),
                          onTap: (){
                            controller.GET_BIL_CUS_CER(1);
                          },
                        ),
                      )
                          : controller.SelectDataPKID.toString()== '8' ? Padding(
                        padding: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                        child: TextFormField(
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          controller: controller.BCCNAController,
                          textAlign: TextAlign.center,
                          decoration: ThemeHelper().InputDecorationDropDown('StringCreditCard'.tr),
                          onTap: (){
                            controller.GET_BIL_CUS_CER(2);
                          },
                        ),
                      ) : Container(),
                      Padding(
                        padding:  EdgeInsets.all(0.01 * height),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('StringAdditional_Data'.tr, style: ThemeHelper().buildTextStyle(context,Colors.black,'L')),
                            Checkbox(
                              value: controller.value,
                              onChanged: (value) {
                                if(controller.value==true  ){
                                  controller.value=false;
                                  controller.value = value!;
                                  controller.update();
                                }
                                else{
                                  controller.value = value!;
                                  controller.update();
                                }
                                controller.update();
                              },
                              activeColor: AppColors.MainColor,
                            ),
                          ],
                        ),
                      ),
                     if( controller.value ) Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                            child: TextFormField(
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.BMMREController,
                              textAlign: TextAlign.center,
                              decoration: ThemeHelper().InputDecorationDropDown('StringManualNO'.tr),
                            ),
                          ),
                          SizedBox(height:0.01 * height),
                          Padding(
                            padding: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                            child: TextFormField(
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.BMMINController,
                              textAlign: TextAlign.center,
                              decoration: ThemeHelper().InputDecorationDropDown('StringDetails'.tr),
                            ),
                          ),
                          SizedBox(height:0.01 * height),
                          Padding(
                            padding: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                            child: TextFormField(
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.BMMDRController,
                              textAlign: TextAlign.center,
                              decoration: ThemeHelper().InputDecorationDropDown('StringDriver'.tr),
                            ),
                          ),
                          SizedBox(height:0.01 * height),
                          Padding(
                            padding: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                            child: TextFormField(
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.BMMCRTController,
                              textAlign: TextAlign.center,
                              decoration: ThemeHelper().InputDecorationDropDown('StringCarType'.tr),
                            ),
                          ),
                          SizedBox(height:0.01 * height),
                          Padding(
                            padding: EdgeInsets.only(left: 0.01 * height, right: 0.01 * height),
                            child: TextFormField(
                              style: const TextStyle(fontWeight: FontWeight.bold),
                              controller: controller.BMMTNController,
                              textAlign: TextAlign.center,
                              decoration: ThemeHelper().InputDecorationDropDown('StringCarNo'.tr),
                            ),
                          ),
                          SizedBox(height:0.01 * height),
                        ],
                      ),
                    ],
                  ),
                ),
              ],),
          )
          )
          ),
        ),
        bottomNavigationBar:  Container(
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text("${'StrinCount_SMDFN'.tr}..................................",
                style: ThemeHelper().buildTextStyle(context,AppColors.red,'L'),),
              Text("${controller.BMMAMTOTController.text.isEmpty?controller.BMMAMTOTController.text='0':controller.formatter.format(double.parse(controller.BMMAMTOTController.text))} ${controller.SCSY}",
                style: ThemeHelper().buildTextStyle(context,AppColors.red,'L'),),
            ],
          ),
        ),
      ),
    );
  }
}



