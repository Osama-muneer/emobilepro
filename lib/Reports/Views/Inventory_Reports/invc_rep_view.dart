import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import '../../../Widgets/theme_helper.dart';
import '../../controllers/invc_mov_rep_controller.dart';

class Invc_Rep_View extends StatefulWidget {
  @override
  State<Invc_Rep_View> createState() => _Invc_Rep_ViewState();
}

class _Invc_Rep_ViewState extends State<Invc_Rep_View> {

  final controller=Get.put(Invc_Mov_RepController());
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('StringInventoryReports'.tr),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Card(
              child:Container(
                color: Colors.white30,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: 0.06 * width,),
                  title:  ThemeHelper().buildText(context,'StringReportWarehouseMovement', Colors.black,'L'),
                  //subtitle: Text("Where You Can Register An Account"),
                  onTap: () {
                    controller.clearData();
                    controller.TypeScreen='Incoming_Store_Rep';
                    Get.toNamed('/Invc_Mov_Rep');
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white30,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: 0.06 * width,),
                  title:ThemeHelper().buildText(context,'StringInvc_Mov_Rep', Colors.black,'L'),
                  onTap: () {
                    controller.clearData();
                    controller.TypeScreen='Inv_Mov_Rep';
                    Get.toNamed('/Invc_Mov_Rep');
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white30,
                child: ListTile(
                  leading:  Icon(Icons.receipt_long,color: Colors.black,size: 0.06 * width,),
                  title:  ThemeHelper().buildText(context,'StringMat_Mov_Rep', Colors.black,'L'),
                  //subtitle: Text("Where You Can Register An Account"),
                  onTap: () {
                    controller.clearData();
                    controller.TypeScreen='Mat_Mov_Rep';
                    Get.toNamed('/Invc_Mov_Rep');
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white30,
                child: ListTile(
                  leading:  Icon(Icons.event_available_sharp,color: Colors.black,size: 0.06 * width,),
                  title: ThemeHelper().buildText(context,'StringItem_Equil', Colors.black,'L'),
                  onTap: () {
                    EasyLoading.instance
                      ..displayDuration = const Duration(milliseconds: 2000)
                      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                      ..loadingStyle = EasyLoadingStyle.custom
                      ..indicatorSize = 50.0
                      ..radius = 10.0
                      ..progressColor = Colors.white
                      ..backgroundColor = Colors.green
                      ..indicatorColor = Colors.white
                      ..textColor = Colors.white
                      ..maskColor = Colors.blue.withOpacity(0.5)
                      ..userInteractions = true
                      ..dismissOnTap = false;
                    EasyLoading.show();
                    controller.FetchGET_Equ_Min_Plus_ITEM_RepPdfData("Equil");
                    Timer(Duration(seconds: 3), () async {
                      if(STO_MOV_D_List.isEmpty){
                        Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                            backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
                            colorText:Colors.white,
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                            forwardAnimationCurve: Curves.easeOutBack);
                        EasyLoading.dismiss();
                        controller.isloading.value=false;
                      }else {
                        final pdfFile = await Pdf.Plus_Equil_Minus_Mat_Pdf(
                            controller.SDDSA,
                            controller.SONA,
                            controller.SONE,
                            controller.SORN,
                            controller.SOLN,
                            controller.SMDED,
                            'Equil',
                            LoginController().SUNA);
                        PdfPakage.openFile(pdfFile);
                        EasyLoading.dismiss();
                        controller.isloading.value=false;
                      }
                    });
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white30,
                child: ListTile(
                  leading:  Icon(Icons.add,color: Colors.black,size: 0.06 * width,),
                  title:  ThemeHelper().buildText(context,'String_Item_PLUS', Colors.black,'L'),
                  onTap: () {
                    EasyLoading.instance
                      ..displayDuration = const Duration(milliseconds: 2000)
                      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                      ..loadingStyle = EasyLoadingStyle.custom
                      ..indicatorSize = 50.0
                      ..radius = 10.0
                      ..progressColor = Colors.white
                      ..backgroundColor = Colors.green
                      ..indicatorColor = Colors.white
                      ..textColor = Colors.white
                      ..maskColor = Colors.blue.withOpacity(0.5)
                      ..userInteractions = true
                      ..dismissOnTap = false;
                    EasyLoading.show();
                    controller.FetchGET_Equ_Min_Plus_ITEM_RepPdfData("Plus");
                    Timer(Duration(seconds: 3), () async {
                      if(STO_MOV_D_List.isEmpty){
                        Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                            backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
                            colorText:Colors.white,
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                            forwardAnimationCurve: Curves.easeOutBack);
                        EasyLoading.dismiss();
                        controller.isloading.value=false;
                      }else {
                        final pdfFile = await Pdf.Plus_Equil_Minus_Mat_Pdf(
                            controller.SDDSA,
                            controller.SONA,
                            controller.SONE,
                            controller.SORN,
                            controller.SOLN,
                            controller.SMDED,
                            'Plus',
                            LoginController().SUNA);
                        PdfPakage.openFile(pdfFile);
                        EasyLoading.dismiss();
                        controller.isloading.value=false;
                      }
                    });
                  },
                ),
              ),
            ),
            Card(
              child:Container(
                color: Colors.white30,
                child: ListTile(
                  leading:  Icon(Icons.minimize,color: Colors.black,size: 0.06 * width,),
                  title:   ThemeHelper().buildText(context,'String_Item_MINES', Colors.black,'L'),
                  onTap: () {
                    EasyLoading.instance
                      ..displayDuration = const Duration(milliseconds: 2000)
                      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                      ..loadingStyle = EasyLoadingStyle.custom
                      ..indicatorSize = 50.0
                      ..radius = 10.0
                      ..progressColor = Colors.white
                      ..backgroundColor = Colors.green
                      ..indicatorColor = Colors.white
                      ..textColor = Colors.white
                      ..maskColor = Colors.blue.withOpacity(0.5)
                      ..userInteractions = true
                      ..dismissOnTap = false;
                    EasyLoading.show();
                    controller.FetchGET_Equ_Min_Plus_ITEM_RepPdfData("Minus");
                    Timer(const Duration(seconds: 3), () async {
                      if(STO_MOV_D_List.isEmpty){
                        Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                            backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.black),
                            colorText:Colors.white,
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                            forwardAnimationCurve: Curves.easeOutBack);
                        EasyLoading.dismiss();
                        controller.isloading.value=false;
                      }else {
                        final pdfFile = await Pdf.Plus_Equil_Minus_Mat_Pdf(
                            controller.SDDSA,
                            controller.SONA,
                            controller.SONE,
                            controller.SORN,
                            controller.SOLN,
                            controller.SMDED,
                            'Minus',
                            LoginController().SUNA);
                        PdfPakage.openFile(pdfFile);
                        EasyLoading.dismiss();
                        controller.isloading.value=false;
                      }
                    });
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
