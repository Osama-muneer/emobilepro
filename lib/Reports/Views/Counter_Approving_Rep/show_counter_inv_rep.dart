import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/bil_poi.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/cou_inf_m.dart';
import '../../../Setting/models/cou_typ_m.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/report_db.dart';
import '../../controllers/counter_inv_rep_controller.dart';

class Show_Counter_Inv_Rep extends StatefulWidget {
  @override
  State<Show_Counter_Inv_Rep> createState() => _Show_Counter_Inv_RepState();
}

class _Show_Counter_Inv_RepState extends State<Show_Counter_Inv_Rep> {
  final Counter_Inv_Rep_Controller controller = Get.find();

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA_INF(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIID_FlableText'.tr}"),
            isExpanded: true,
            hint:  ThemeHelper().buildText(context,'StringFromBrach', Colors.grey,'S'),
            value: controller.SelectDataFromBIID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              onTap: (){
                controller.SelectDataFromBINA=item.BINA.toString();
              },
              child: Text(
                item.BINA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataFromBIID = value.toString();
              controller.SelectDataF_SIID=null;
              controller.SelectDataT_SIID=null;
              controller.value=false;
              //if(controller.SelectDataF_SIID!=null  || controller.SelectDataT_SIID!=null){
              Timer(const Duration(milliseconds: 10), () {
                setState(() {
                  controller.SelectDataF_SIID=null;
                  controller.SelectDataT_SIID=null;
                });
              });

            },
          );
        });
  }
  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_ToBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA_INF(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIID_TlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
            value: controller.SelectDataToBIID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: (){
                controller.SelectDataToBINA=item.BINA.toString();
              },
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataToBIID = value.toString();
            },
          );
        });
  }
  FutureBuilder<List<Bil_Poi_Local>> DropdownBil_Poi_FromBuilder() {
    return FutureBuilder<List<Bil_Poi_Local>>(
        future: GET_BIL_POI(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bil_Poi_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBPID_FlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringBPID_FlableText', Colors.grey,'S'),
            value: controller.SelectDataFromBPID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.BPID.toString(),
              child: Text(
                item.BPNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataFromBPID = value.toString();
              controller.update();
            },
          );
        });
  }
  FutureBuilder<List<Bil_Poi_Local>> DropdownBil_Poi_ToBuilder() {
    return FutureBuilder<List<Bil_Poi_Local>>(
        future: GET_BIL_POI(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bil_Poi_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBPID_TlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringBPID_TlableText', Colors.grey,'S'),
            value: controller.SelectDataToBPID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.BPID.toString(),
              child: Text(
                item.BPNA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataToBPID = value.toString();
              controller.update();
            },
          );
        });
  }
  FutureBuilder<List<Cou_Typ_M_Local>> DropdownCou_Typ_M_FromBuilder() {
    return FutureBuilder<List<Cou_Typ_M_Local>>(
        future: GET_COU_TYP_M_REP(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Cou_Typ_M_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringCTMID_FlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringCTMID_FlableText', Colors.grey,'S'),
            value: controller.SelectDataFromCTMID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.CTMID.toString(),
              child: Text(
                item.CTMNA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataFromCTMID = value.toString();
              controller.update();
            },
          );
        });
  }
  FutureBuilder<List<Cou_Typ_M_Local>> DropdownCou_Typ_M_ToBuilder() {
    return FutureBuilder<List<Cou_Typ_M_Local>>(
        future: GET_COU_TYP_M_REP(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Cou_Typ_M_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringCTMID_TlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringCTMID_TlableText', Colors.grey,'S'),
            value: controller.SelectDataToCTMID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.CTMID.toString(),
              child: Text(
                item.CTMNA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataToCTMID = value.toString();
              controller.update();
            },
          );
        });
  }
  FutureBuilder<List<Cou_Inf_M_Local>> DropdownCou_Inf_M_ToBuilder() {
    return FutureBuilder<List<Cou_Inf_M_Local>>(
        future: GET_COU_INF_M_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString(),
            controller.SelectDataFromCTMID.toString(), controller.SelectDataToCTMID.toString(),
            controller.SelectDataFromBPID.toString(),controller.SelectDataToBPID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Cou_Inf_M_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringCIMID_TlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringCIMID_TlableText', Colors.grey,'S'),
            value: controller.SelectDataToCIMID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.CIMID.toString(),
              child: Text(
                item.CIMNA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataToCIMID = value.toString();
            },
          );
        });
  }
  FutureBuilder<List<Cou_Inf_M_Local>> DropdownCou_Inf_M_FromBuilder() {
    return FutureBuilder<List<Cou_Inf_M_Local>>(
        future: GET_COU_INF_M_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString(),
            controller.SelectDataFromCTMID.toString(), controller.SelectDataToCTMID.toString(),
            controller.SelectDataFromBPID.toString(),controller.SelectDataToBPID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Cou_Inf_M_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringCIMID_FlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringCIMID_FlableText', Colors.grey,'S'),
            value: controller.SelectDataFromCIMID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.CIMID.toString(),
              child: Text(
                item.CIMNA_D.toString(),
                style:   ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'Please select gender.';
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataFromCIMID = value.toString();
            },
          );
        });
  }

  Future<void> generatePdfReport() async {
    // إظهار حالة التحميل
    controller.isloading.value = true;

    try {
      // جلب بيانات التقرير (تأكد أن الدالة تُعيد البيانات المطلوبة)
      await controller.Fetch_GET_BIF_REP_PdfData();

      // انتظار بعض الوقت للسماح بتحميل البيانات (يمكن تعديل الوقت حسب الحاجة)
      await Future.delayed(const Duration(seconds: 3));

      // التحقق من أن القوائم المطلوبة غير فارغة
      if (BIF_MOV_M_List.isEmpty ||
          BIF_MOV_M_REP.isEmpty ||
          BIF_MOV_M_REP2.isEmpty) {
        Get.snackbar(
          'StringNo_Data_Rep'.tr,
          'StringChk_No_Data'.tr,
          backgroundColor: Colors.red,
          icon: const Icon(Icons.error, color: Colors.white),
          colorText: Colors.white,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          forwardAnimationCurve: Curves.easeOutBack,
        );
      } else {
        // إنشاء ملف الـ PDF باستخدام البيانات المتوفرة
        final pdfFile = await Pdf.Total_Amount_of_Counter_Point_Pdf(
          controller.SelectFromDays.toString().substring(0, 10),
          controller.SelectToDays.toString().substring(0, 10),
          controller.SelectDataFromBIID.toString(),
          controller.SelectDataToBIID.toString(),
          LoginController().SUNA,
          controller.SONA.toString(),
        );
        // فتح ملف الـ PDF الناتج
        PdfPakage.openFile(pdfFile);
      }
    } catch (e, stackTrace) {
      // التعامل مع أي أخطاء أثناء العملية
      print('Error in generatePdfReport: $e\n$stackTrace');
      Get.snackbar(
        'Error',
        'An error occurred while generating the PDF report.',
        backgroundColor: Colors.red,
        icon: const Icon(Icons.error, color: Colors.white),
        colorText: Colors.white,
      );
    } finally {
      // إخفاء حالة التحميل
      controller.isloading.value = false;
    }
  }


  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          backgroundColor: AppColors.MainColor,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.cleaning_services,color: Colors.white),
                  onPressed: () {
                    controller.clear();
                    controller.update();
                  },
                ),
              ],
            )
          ],
          title: Text('StringInv_Mov_Rep'.tr,
              style: ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width),
          child: GetBuilder<Counter_Inv_Rep_Controller>(
            init: Counter_Inv_Rep_Controller(),
            builder: ((value)=>
                Form(
                  child: ListView(
                    children: <Widget>[
                      SizedBox(height: 0.02 * height,),
                      //من فرع الى فرع
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * height)),
                                    child: DropdownBra_InfBuilder()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0.02 * height)),
                                    child: DropdownBra_Inf_ToBuilder()
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      //من تاريخ الى تاريخ
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 0.02 * height,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0.02 * width)),
                                    child: Column(
                                      children: [
                                        Text(
                                            (controller.SelectFromDays == null ?
                                            controller.SelectFromDays=controller.dateFromDays.toString().split(" ")[0]
                                                : controller.SelectFromDays.toString())
                                                .split(" ")[0],style:
    ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                        SizedBox(
                                          width: 0.3 * width,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.selectDateFromDays(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.MainColor, // Background color
                                            ),
                                            child: ThemeHelper().buildText(context,'StringFromDate', Colors.white,'M')
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(0.02 * width)),
                                    child:  Column(
                                      children: [
                                        Text(
                                            controller.SelectToDays == null ?
                                            controller.SelectToDays=controller.dateTimeToDays.toString().split(" ")[0]
                                                : controller.SelectToDays.toString()
                                                .split(" ")[0],style:
                                        ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                        Container(
                                          width: 0.3 * width,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.selectDateToDays(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.MainColor, // Background color
                                            ),
                                            child: ThemeHelper().buildText(context,'StringToDate', Colors.white,'M')
                                      
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.02 * height,),
                      Padding(
                        padding:  EdgeInsets.all(0.02 * width),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height:0.02 * height),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 0.02 * height),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular( 0.02 * width)),
                                      child:  DropdownBil_Poi_FromBuilder()
                                  ),
                                ),
                                
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: 0.02 * height),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular( 0.02 * width)),
                                      child:  DropdownBil_Poi_ToBuilder()
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height:0.02 * height),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 0.02 * height),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular( 0.02 * width)),
                                      child:  DropdownCou_Typ_M_FromBuilder()
                                  ),
                                ),
                                
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: 0.02 * height),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular( 0.02 * width)),
                                      child:   DropdownCou_Typ_M_ToBuilder()
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height:0.02 * height),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(left: 0.02 * height),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular( 0.02 * width)),
                                      child:  DropdownCou_Inf_M_FromBuilder()
                                  ),
                                ),
                                
                                Expanded(
                                  child: Container(
                                      margin: EdgeInsets.only(right: 0.02 * height),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular( 0.02 * width)),
                                      child:   DropdownCou_Inf_M_ToBuilder()
                                  ),
                                ),
                              ],
                            ),
                            // SizedBox(height:0.02 * height),
                            // Row(
                            //   children: [
                            //     Expanded(
                            //       child: Container(
                            //           margin: EdgeInsets.only(left: 0.02 * height),
                            //           decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius: BorderRadius.circular( 0.02 * width)),
                            //           child:  DropdownSYS_CURBuilder()
                            //       ),
                            //     ),
                            //     
                            //     Expanded(
                            //       child: Container(
                            //           margin: EdgeInsets.only(left: 0.02 * height),
                            //           decoration: BoxDecoration(
                            //               color: Colors.white,
                            //               borderRadius: BorderRadius.circular( 0.02 * width)),
                            //           child:   DropdownPAY_KINBuilder()
                            //       ),
                            //     ),
                            //   ],
                            // ),
                          ],
                        ),
                      ),
                      SizedBox(height:0.02 * height,),
                      Obx(() => controller.isloading.value == true
                            ? ThemeHelper().circularProgress()
                            : Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: MaterialButton(
                              onPressed: ()  async {
                               await generatePdfReport();
                                  // controller.Fetch_GET_BIF_REP_PdfData();
                                  // Timer(const Duration(seconds: 3), () async {
                                  //   if(BIF_MOV_M_List.isEmpty ||
                                  //       BIF_MOV_M_REP.isEmpty || BIF_MOV_M_REP2.isEmpty){
                                  //     Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                                  //         backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
                                  //         colorText:Colors.white,
                                  //         isDismissible: true,
                                  //         dismissDirection: DismissDirection.horizontal,
                                  //         forwardAnimationCurve: Curves.easeOutBack);
                                  //       controller.isloading.value=false;
                                  //   }else {
                                  //     final pdfFile = await Pdf.Total_Amount_of_Counter_Point_Pdf(
                                  //       controller.SelectFromDays.toString().substring(0, 10),
                                  //       controller.SelectToDays.toString().substring(0, 10),
                                  //       controller.SelectDataFromBIID.toString(),
                                  //       controller.SelectDataToBIID.toString(),
                                  //       LoginController().SUNA,
                                  //       controller.SONA.toString()
                                  //     );
                                  //     PdfPakage.openFile(pdfFile);
                                  //     controller.isloading.value=false;
                                  //   }
                                  // });
                              },
                              child: Container(
                                height: 0.05 * height,
                                width: 2 * width,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.MainColor,
                                    borderRadius:
                                    BorderRadius.circular(0.02 * height)),
                                child: ThemeHelper().buildText(context,'StringPrint', Colors.white,'L')
                              )),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
        ));
  }
}
