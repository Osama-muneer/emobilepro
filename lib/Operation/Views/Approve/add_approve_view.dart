import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Setting/models/acc_cas.dart';
import '../../../Setting/models/acc_cos.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/setting_db.dart';
import '../../../routes/routes.dart';
import '../../Controllers/counter_sale_approving_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'datagridapprove.dart';

class Add_Approve_View extends StatefulWidget {
  @override
  State<Add_Approve_View> createState() => _Add_Approve_ViewState();
}

class _Add_Approve_ViewState extends State<Add_Approve_View> {
  final Counter_Sales_Approving_Controller controller = Get.find();
  String query = '';
  final txtController = TextEditingController();
  @override



  TimeOfDay _Fromtime = new TimeOfDay.now();
  TimeOfDay _Totime = new TimeOfDay.now();
  static const MaterialColor buttonTextColor = const MaterialColor(
    0xFFEF5350,
    const <int, Color>{
      50: Color(0xFFFFEBEE),
      100: Color(0xFFFFCDD2),
      200: Color(0xFFEF9A9A),
      300: Color(0xFFE57373),
      400: Color(0xFFEF5350),
      500: Color(0xFFF44336),
      600: Color(0xFFE53935),
      700: Color(0xFFD32F2F),
      800: Color(0xFFC62828),
      900: Color(0xFFB71C1C),
    },
  );

  Future<Null> selectFromTime() async {
    final TimeOfDay? picked = await showTimePicker(context: context, initialTime: _Fromtime,
        builder: (context, child) {
      return Theme(
        data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4A5BF6),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
        ),
        child: child!,
      );
    },);

    if (picked != null && picked != _Fromtime) {
      setState(() {
        _Fromtime = picked;
        controller.Fromtimeperiod=_Fromtime.period.toString().substring(_Fromtime.period.toString().length- 2).toUpperCase();
        controller.SelectFromTime = "${_Fromtime.hour}:${_Fromtime.minute} ${controller.Fromtimeperiod}";
        controller.FromTime = controller.SelectToTime!='00:01 AM'?(_Fromtime.hour + (_Fromtime.minute / 60)):0;
        controller.ToTime = controller.SelectToTime!='23:59 PM'?(_Totime.hour + (_Totime.minute/ 60)):24;
        //controller.timecompare = FromTime - ToTime;
        if(controller.FromTime>controller.ToTime){
          Fluttertoast.showToast(
              msg: "${'StringcompareTime'.tr}",
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
      });
    }
  }
  Future<Null> selectToTime() async {
    final TimeOfDay? picked =
    await showTimePicker(context: context, initialTime: _Totime,builder: (context, child) {
      return   Theme(
        data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4A5BF6),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
        ),
        child: child!,
      );
    });
    if (picked != null && picked != _Totime) {
      setState(() {
        _Totime = picked;
        controller.Totimeperiod=_Totime.period.toString().substring(_Totime.period.toString().length- 2).toUpperCase();
        controller.SelectToTime = "${_Totime.hour}:${_Totime.minute} ${controller.Totimeperiod}";
        controller.FromTime = controller.SelectToTime!='00:01 AM'?(_Fromtime.hour + (_Fromtime.minute / 60)):0;
        controller.ToTime = controller.SelectToTime!='23:59 PM'?(_Totime.hour + (_Totime.minute/ 60)):24;
        //controller.timecompare = FromTime - ToTime;
        if(controller.FromTime>controller.ToTime){
          Fluttertoast.showToast(
              msg: "${'StringcompareTime'.tr}",
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
      });
    }
  }
  Future<bool> onWillPop() async {
    final shouldPop;
    if((controller.edit == true || controller.CheckBack == 0)){
      Navigator.of(context).pop(false);
      controller.GET_BIF_COU_M_P('DateNow');
      controller.titleScreen='';
      controller.update();
      shouldPop = await Get.toNamed(Routes.Counter_Sale_Posting_Approving);
    }else{
      shouldPop = await Get.defaultDialog(
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
          bool isValid = controller.delete_BIF_COU(controller.BCMID, 2);
          controller.titleScreen='';
          controller.update();
          if (isValid) {
            controller.titleScreen='';
            Get.offAndToNamed(Routes.Counter_Sale_Posting_Approving);
          }
        },
      );
    }

    return shouldPop ?? false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.MainColor,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.sync,color: Colors.white),
                  onPressed: () {
                    controller.Socket_IP();
                    controller.myFocusNode.requestFocus();
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.save,color: Colors.white),
                  onPressed: () async {
                    controller.GET_COUNTBCCID_P();
                    await Future.delayed(Duration(milliseconds: 400));
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
                  },
                ),
              ],
            )

          ],
          title: Text(controller.titleScreen,
              style: ThemeHelper().buildTextStyle(context,AppColors.textColor,'L')),
          centerTitle: true,
        ),
         body: Form(
           key: controller.formKey,
           child: GetBuilder<Counter_Sales_Approving_Controller>(
               init: Counter_Sales_Approving_Controller(),
               builder: ((controller)=>
                   Padding(
                     padding:  EdgeInsets.all(Dimensions.width10),
                     child:  Column(
                       children: [
                         Column(
                           mainAxisAlignment: MainAxisAlignment.start,
                           crossAxisAlignment: CrossAxisAlignment.start,
                           children: [
                             Center(
                               child: SizedBox(
                                 width: Dimensions.width200,
                                 child: ElevatedButton(
                                   onPressed: () {
                                     controller.buildShowSetting();
                                   },
                                   style: ElevatedButton.styleFrom(
                                     backgroundColor: AppColors.MainColor, // Background color
                                   ),
                                   child: Text('StringBasicData'.tr,style:
                                   ThemeHelper().buildTextStyle(context, Colors.white,'M')),
                                 ),
                               ),
                             ),

                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width / 2.2,
                                   child: Container(
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.grey.shade500),
                                         borderRadius: BorderRadius.circular(Dimensions.width10)),
                                     child: TextButton(onPressed: (){controller.selectDateFromDays(context);},
                                       child: Text("${'StringFromDate'.tr} : ${controller.SelectFromDays == null ?
                                       controller.SelectFromDays=controller.dateFromDays.toString().split(" ")[0]
                                           : controller.SelectFromDays.toString().split(" ")[0]}",
                                           style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),),
                                   ),
                                 ),
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width / 2.2,
                                   child:   Container(
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.grey.shade500),
                                         borderRadius: BorderRadius.circular(Dimensions.width10)),
                                     child: TextButton(onPressed: (){controller.selectDateToDays(context);},
                                       child: Text("${'StringToDate'.tr} : ${controller.SelectToDays == null ?
                                       controller.SelectToDays=controller.dateTimeToDays.toString().split(" ")[0]
                                           : controller.SelectToDays.toString()
                                           .split(" ")[0]}",style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),),
                                   ),
                                 ),
                               ],
                             ),
                             SizedBox(height: 5),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width / 2.2,
                                   child: Container(
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.grey.shade500),
                                         borderRadius: BorderRadius.circular(Dimensions.width10)),
                                     child: TextButton(onPressed: (){selectFromTime();},
                                       child: Text("${'StringFromTime'.tr} : ${controller.SelectFromTime}",
                                           style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),),
                                   ),
                                 ),
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width / 2.2,
                                   child:  Container(
                                     decoration: BoxDecoration(
                                         border: Border.all(color: Colors.grey.shade500),
                                         borderRadius: BorderRadius.circular(Dimensions.width10)),
                                     child: TextButton(onPressed: (){selectToTime();},
                                       child: Text("${'StringToTime'.tr} : ${controller.SelectToTime}",
                                           style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),),
                                   ),
                                 ),
                               ],
                             ),
                             SizedBox(height: Dimensions.height10),
                             Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width / 2.2,
                                   child: DropdownACC_CASBuilder(),
                                 ),
                                 SizedBox(
                                   width: MediaQuery.of(context).size.width / 2.2,
                                   height: MediaQuery.of(context).size.width / 7.0,
                                   child:  Obx(() {
                                     if (controller.loading.value == true) {
                                       return TextFormField(
                                         controller: controller.BCMTAController,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: 'StrinDef_BCMAM'.tr,
                                             labelStyle: TextStyle(color: Colors.grey),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(Dimensions.width15),
                                                 borderSide:
                                                 BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       );
                                     } else {
                                       return TextFormField(
                                         controller: controller.BCMTAController,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: 'StrinDef_BCMAM'.tr,
                                             labelStyle: TextStyle(color: Colors.grey),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(Dimensions.width15),
                                                 borderSide:
                                                 BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       );
                                     }
                                   }),
                                 ),
                               ],
                             ),
                             SizedBox(height: Dimensions.height10),
                             controller.BIL_CRE_C_List.length==3?
                             Column(
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child:  TextFormField(
                                         controller: controller.BCMAM1Controller,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: controller.BCCNA1Controller.text,
                                             labelStyle: TextStyle(color: Colors.grey),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(Dimensions.width15),
                                                 borderSide:
                                                 BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       ),
                                     ),
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child:  TextFormField(
                                         controller: controller.BCMAM2Controller,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: controller.BCCNA2Controller.text,
                                             labelStyle: TextStyle(color: Colors.grey),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(Dimensions.width15),
                                                 borderSide:
                                                 BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       ),
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: Dimensions.height10),
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child:  TextFormField(
                                         controller: controller.BCMAM3Controller,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: controller.BCCNA3Controller.text,
                                             labelStyle: TextStyle(color: Colors.grey),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius: BorderRadius.circular(Dimensions.width15),
                                                 borderSide: BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       ),
                                     ),
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child:   DropdownACC_COSBuilder(),
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: Dimensions.height10),
                                 buildRow(controller),
                               ],
                             ) : controller.BIL_CRE_C_List.length==2 ?
                             Column(
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child:  TextFormField(
                                         controller: controller.BCMAM1Controller,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: controller.BCCNA1Controller.text,
                                             labelStyle: TextStyle(color: Colors.grey),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(Dimensions.width15),
                                                 borderSide:
                                                 BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       ),
                                     ),
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child: TextFormField(
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                         controller: controller.BCMAM2Controller,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: controller.BCCNA2Controller.text,
                                             labelStyle: TextStyle(color: Colors.grey.shade800),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(Dimensions.width15),
                                                 borderSide:
                                                 BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       ),
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: Dimensions.height10),
                                 DropdownACC_COSBuilder(),
                                 SizedBox(height: Dimensions.height10),
                                 buildRow(controller),
                               ],
                             ) : controller.BIL_CRE_C_List.length==1 ?
                             Column(
                               children: [
                                 Row(
                                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                   children: [
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child:  TextFormField(
                                         style: TextStyle(fontWeight: FontWeight.bold),
                                         controller: controller.BCMAM1Controller,
                                         textAlign: TextAlign.center,
                                         keyboardType: TextInputType.number,
                                         decoration: InputDecoration(
                                             labelText: controller.BCCNA1Controller.text,
                                             labelStyle: TextStyle(color: Colors.grey.shade800),
                                             focusedBorder: OutlineInputBorder(
                                                 borderRadius:
                                                 BorderRadius.circular(Dimensions.width15),
                                                 borderSide:
                                                 BorderSide(color: Colors.grey.shade500)),
                                             border: OutlineInputBorder(
                                                 borderRadius: BorderRadius.all(
                                                     Radius.circular(Dimensions.height15)))),
                                       )
                                     ),
                                     SizedBox(
                                       width: MediaQuery.of(context).size.width / 2.2,
                                       height: MediaQuery.of(context).size.width / 7.0,
                                       child:   DropdownACC_COSBuilder(),
                                     ),
                                   ],
                                 ),
                                 SizedBox(height: Dimensions.height10),
                                 buildRow(controller),
                               ],
                             ) :
                             Column(
                               children: [
                                 DropdownACC_COSBuilder(),
                                 SizedBox(height: Dimensions.height10),
                                 buildRow(controller),
                               ],
                             ),
                             SizedBox(height: Dimensions.height10),

                             // MaterialButton(
                             //   onPressed: () async {
                             //     //final difference = controller.SelectFromDays!.difference(controller.SelectToDays).inDays;
                             //     if(controller.FromTime>controller.ToTime){
                             //       Fluttertoast.showToast(
                             //           msg: "${'StringcompareTime'.tr}",
                             //           toastLength: Toast.LENGTH_LONG,
                             //           textColor: Colors.white,
                             //           backgroundColor: Colors.redAccent);
                             //     }else{
                             //       controller.GET_BCMNO_P();
                             //       Get.defaultDialog(
                             //         title: 'StringMestitle'.tr,
                             //         middleText: 'StringMessave'.tr,
                             //         backgroundColor: Colors.white,
                             //         radius: 40,
                             //         textCancel: 'StringNo'.tr,
                             //         cancelTextColor: Colors.red,
                             //         textConfirm: 'StringYes'.tr,
                             //         confirmTextColor: Colors.white,
                             //         onConfirm: () {
                             //           Navigator.of(context).pop(false);
                             //           controller.editMode();
                             //           controller.get_BIF_COU_M('DateNow');
                             //         },
                             //         // barrierDismissible: false,
                             //       );
                             //     }
                             //
                             //   },
                             //   child: Container(
                             //     height: 40.h,
                             //     width: 330.w,
                             //     alignment: Alignment.center,
                             //     decoration: BoxDecoration(
                             //         color: AppColors.MainColor,
                             //         borderRadius: BorderRadius.circular(Dimensions.height35)),
                             //     child: Text('StringSave'.tr,style: TextStyle(
                             //       color: Colors.white, fontSize: Dimensions.font20,
                             //     ),)
                             //     ,
                             //   ),
                             // ),
                           ],
                         ),
                         Expanded(
                           child: DataGridApprovePage(),
                         ),
                       ],
                     ),
                   )
               )
           ),

         ),
        bottomNavigationBar:  GetBuilder<Counter_Sales_Approving_Controller>(
    init: Counter_Sales_Approving_Controller(),
    builder: ((value) => Container(
            decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text("${'StringDeservedAmount'.tr} :",
                  style: ThemeHelper().buildTextStyle(context, Colors.red,'M'),),
                Text("${controller.SUMBCMAMCController.text.isEmpty?controller.SUMBCMAMCController.text='0':
                controller.roundDouble(double.parse(controller.SUMBCMAMCController.text)  , 2)}",
                  style: ThemeHelper().buildTextStyle(context, Colors.red,'M'),),
              ],
            ),
          ))
        ),
      ),
    );
  }

  Row buildRow(Counter_Sales_Approving_Controller controller) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Expanded(
                                   child: SizedBox(
                                     height: MediaQuery.of(context).size.width / 7.0,
                                     child:    TextFormField(
                                       style: TextStyle(fontWeight: FontWeight.bold),
                                       controller: controller.BCMINController,
                                       textAlign: TextAlign.start,
                                       decoration: InputDecoration(
                                           labelText: 'StringDetails'.tr,
                                           labelStyle: TextStyle(color: Colors.grey.shade800),
                                           focusedBorder: OutlineInputBorder(
                                               borderRadius:
                                               BorderRadius.circular(Dimensions.width15),
                                               borderSide:
                                               BorderSide(color: Colors.grey.shade500)),
                                           border: OutlineInputBorder(
                                               borderRadius: BorderRadius.all(
                                                   Radius.circular(Dimensions.height15)))),
                                     ),
                                   ),
                                 ),
                                 IconButton(
                                     icon:Icon(
                                       Icons.add_circle,color: AppColors.MainColor, size: 0.05 * height,
                                     ),
                                     onPressed: () {
                                       setState(() {
                                         if (controller.SelectDataBIID == null) {
                                           Fluttertoast.showToast(
                                               msg: 'StringStoch'.tr,
                                               textColor: Colors.white,
                                               backgroundColor: Colors.red);
                                         }
                                         else if (controller.SelectDataSCID == null) {
                                           Fluttertoast.showToast(
                                               msg: 'StringChi_currency'.tr,
                                               textColor: Colors.white,
                                               backgroundColor: Colors.red);
                                         }
                                         else if (controller.SelectDataBPID == null) {
                                           Fluttertoast.showToast(
                                               msg: 'StringPoint'.tr,
                                               textColor: Colors.white,
                                               backgroundColor: Colors.red);
                                         }
                                         else if (controller.SelectDataBPID == null) {
                                           Fluttertoast.showToast(
                                               msg: 'StringFuelType'.tr,
                                               textColor: Colors.white,
                                               backgroundColor: Colors.red);
                                         }
                                         else {
                                           // controller.ClearACC_MOV_D();
                                           controller.GET_COU_INF_M_ONE_P();
                                            displayAddItems();
                                         }
                                       });
                                       // buildAlert(context).show();
                                     }),
                               ],
                             );
  }

  displayAddItems() {
    setState(() {
      controller.titleAddScreen = 'StringAdd'.tr;
      controller.StringButton = 'StringAdd'.tr;
      controller.GET_CIMID_P();
      controller.clearBIF_COU_C();
      controller.update();

      controller.displayAddItemsWindo();
    });
  }
  GetBuilder<Counter_Sales_Approving_Controller> DropdownACC_CASBuilder() {
    return   GetBuilder<Counter_Sales_Approving_Controller>( init: Counter_Sales_Approving_Controller(),
    builder: ((controller)=> FutureBuilder<List<Acc_Cas_Local>>(
        future:GET_ACC_CAS(controller.SelectDataBIID.toString(),controller.SelectDataSCID.toString(),
           'BF',11),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cas_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'StringACIDlableText'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.height15),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.width15),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_ACID', Colors.grey,'S'),
            value: controller.SelectDataACID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.ACID.toString(),
              child: Text(
                item.ACNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
             controller.SelectDataACID=value.toString();
             controller.update();
            },
          );
        })));
  }
  GetBuilder<Counter_Sales_Approving_Controller> DropdownACC_COSBuilder() {
    return   GetBuilder<Counter_Sales_Approving_Controller>( init: Counter_Sales_Approving_Controller(),
    builder: ((controller)=> FutureBuilder<List<Acc_Cos_Local>>(
        future:GET_ACC_COS(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'StringACNOlableText'.tr,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.height15),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.width15),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
            isExpanded: true,
            hint:ThemeHelper().buildText(context,'StringChi_ACNO', Colors.grey,'S'),
            value: controller.SelectDataACNO,
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black,
                fontWeight: FontWeight.bold),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.ACNO.toString(),
              child: Text(
                item.ACNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
             controller.SelectDataACNO=value.toString();
             controller.update();
            },
          );
        })));
  }
}
