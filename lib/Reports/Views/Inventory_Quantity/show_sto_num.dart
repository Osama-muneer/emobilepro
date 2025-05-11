import 'dart:async';
import 'package:flutter/services.dart';
import '../../../Reports/Views/Inventory_Quantity/show_data.dart';
import '../../../Reports/controllers/sto_num_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../Widgets/theme_helper.dart';



class Show_Sto_Num extends StatefulWidget {
  @override
  State<Show_Sto_Num> createState() => _Show_Sto_NumState();
}

class _Show_Sto_NumState extends State<Show_Sto_Num> {
  final Sto_NumController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // تنفيذ الدالة المطلوبة
        if(controller.isTablet==true){
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
         // Get.off(() => Sto_Num_View());
        }
        return true; // للسماح بالمغادرة
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MainColor,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('StringInventoryQuantities'.tr,
                  style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
                ),
                 controller.SelectDataSIID.toString()!='null'?
                    Text('${controller.SelectBINA.toString()}-${controller.SelectDataSINA.toString()}',
                      style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
                    ):
                    Text(controller.SelectBINA.toString(),
                      style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
                    ),
            ],
          ),
          iconTheme: const IconThemeData(color: Colors.white),
          actions: [
            Padding(
              padding: EdgeInsets.only(left: 3),
              child: IconButton(icon: const Icon(Icons.picture_as_pdf),
                  onPressed: ()async{
                  if(controller.UPPR2==1){
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
                      controller.FetchPdfData();

                    Timer(const Duration(seconds: 1), () async{
                      final pdfFile = await Pdf.Sto_Num_Pdf(
                          controller.SelectBINA.toString(),
                          controller.SelectDataSINA.toString()=='null'?'':controller.SelectDataSINA.toString()
                          ,controller.SDDSA,controller.SMDED, controller.SONA,
                          controller.SONE,
                          controller.SORN,
                          controller.SOLN,'Quantities',
                          LoginController().SUNA,
                          controller.SUM_SNNO,
                          controller.SUM_MPS1,
                          controller.COUNT_MINO!,
                          controller.UPIN!,
                          controller.STO_V_N);
                      EasyLoading.dismiss();
                      PdfPakage.openFile(pdfFile);
                    });
                  }else{
                    Get.snackbar('StringQuantity_UPPR'.tr, 'String_CHK_Quantity_UPPR'.tr,
                        backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                        colorText:Colors.white,
                        isDismissible: true,
                        dismissDirection: DismissDirection.horizontal,
                        forwardAnimationCurve: Curves.easeOutBack);
                  }
                  }),
            ),
            IconButton(
              icon: const Icon(Icons.rotate_left),
              onPressed: () {
                if(controller.isTablet==false){
                  controller.isTablet=true;
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.landscapeLeft,
                    DeviceOrientation.landscapeRight,
                  ]);
                }else{
                  controller.isTablet=false;
                  SystemChrome.setPreferredOrientations([
                    DeviceOrientation.portraitUp,
                    DeviceOrientation.portraitDown,
                  ]);
                }
              },
            ),
          ],
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            StatefulBuilder(builder: (BuildContext context, StateSetter setState) {
              return Expanded(
                  child: DataGridPage());
            }),
            Card(
              child: StteingController().SHOW_ALTER_REP==false?Text("Stringdetails_Sto_Num".tr,
                style:  ThemeHelper().buildTextStyle(context, Colors.red,'M')):Text(''),
            ),
          ],
        )

      ),
    );
  }
}

