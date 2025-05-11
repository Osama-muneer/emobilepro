import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Reports/controllers/Acc_Rep_Controller.dart';
import '../../../Reports/controllers/Inv_Rep_Controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/report_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Show_Acc_Rep extends StatefulWidget {
  @override
  State<Show_Acc_Rep> createState() => Show_Acc_RepState();
}
final List<Map> Type_Movement  = [
  {"id": '0', "name": 'StringAll'.tr},
  {"id": '1', "name": 'StringReceipt'.tr},
  {"id": '2', "name": 'StringPayment'.tr},
  {"id": '3', "name": 'StringCollectionsVoucher'.tr}
].obs;

class Show_Acc_RepState extends State<Show_Acc_Rep> {
  final Acc_Rep_Controller controller = Get.find();
  FutureBuilder DropdownType_MovementBuilder2() {
    return FutureBuilder<List>(
        builder: (BuildContext context, AsyncSnapshot<List> snapshot) {
          return DropdownButtonFormField2(
            decoration: InputDecoration(
              isDense: true,
              labelText: 'StringType'.tr,
              labelStyle: const TextStyle(color: Colors.black54),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Dimensions.height15),
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.width15),
                  borderSide: BorderSide(color: Colors.grey.shade400)),
            ),
            isExpanded: true,
            value: controller.AMKID.toString(),
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black,
                fontWeight: FontWeight.bold),
            items: Type_Movement
                .map((item) => DropdownMenuItem<String>(
              value: item['id'],
              child: Text(
                item['name'],
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (v) {
              if (v == null) {
                return 'StringBrach'.tr;
              }
              return null;
            },
            onChanged: (value) {
              //Do something when changing the item if you want.
              controller.AMKID = int.parse(value.toString());
            },
          );
        }, future: null,);
  }
  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA_INF(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                  top: Dimensions.height10,bottom: Dimensions.height10),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                top: Dimensions.height10,bottom: Dimensions.height10),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                labelText: 'StringBIID_FlableText'.tr,
                labelStyle: TextStyle(color: Colors.grey.shade800),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    borderSide: BorderSide(color: Colors.grey.shade500)),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.width15),
                ),
              ),
              isExpanded: true,
              hint:  ThemeHelper().buildText(context,'StringFromBrach', Colors.grey,'S'),
              value: controller.SelectDataFromBIID,
              style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
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
                controller.value=false;
              },
            ),
          );
        });
  }
  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_ToBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA_INF(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                  top: Dimensions.height10,bottom: Dimensions.height10),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                top: Dimensions.height10,bottom: Dimensions.height10),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                labelText: 'StringBIID_TlableText'.tr,
                labelStyle: TextStyle(color: Colors.grey.shade800),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    borderSide: BorderSide(color: Colors.grey.shade500)),
                isDense: true,
                contentPadding: EdgeInsets.zero,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.width15),
                ),
              ),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
              value: controller.SelectDataToBIID,
              style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
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
            ),
          );
        });
  }
  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CURBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                  top: Dimensions.height10,bottom: Dimensions.height10),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                top: Dimensions.height10,bottom: Dimensions.height10),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'StringSCIDlableText'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.height15),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
              value: controller.SelectDataSCID,
              style: const TextStyle(
                  fontFamily: 'Hacen',
                  color: Colors.black),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.SCID.toString(),
                child: Text(
                  "${item.SCNA_D.toString()                        } ",
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              )).toList().obs,
              validator: (v) {
                if (v == null) {
                  return 'StringBrach'.tr;
                };
return null;
              },
              onChanged: (value) {
                controller.SelectDataSCID = value.toString();
              },
            ),
          );
        });
  }
  FutureBuilder<List<Pay_Kin_Local>> DropdownPAY_KINBuilder() {
    return FutureBuilder<List<Pay_Kin_Local>>(
        future: GET_PAY_KIN('1'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Padding(
              padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                  top: Dimensions.height10,bottom: Dimensions.height10),
              child: Dropdown(josnStatus: josnStatus, GETSTRING: '',),
            );
          }
          return Padding(
            padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10,
                top: Dimensions.height10,bottom: Dimensions.height10),
            child: DropdownButtonFormField2(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'StringPKIDlableText'.tr,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Dimensions.height15),
                ),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.width15),
                    borderSide: BorderSide(color: Colors.grey.shade400)),
              ),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringChi_PAY', Colors.grey,'S'),
              value: controller.PKID,
              style: const TextStyle(
                  fontFamily: 'Hacen',
                  color: Colors.black),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.PKID.toString(),
                child: Text(
                  "${item.PKNA_D.toString()}         ",
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              )).toList().obs,
              validator: (v) {
                if (v == null) {
                  return 'StringBrach'.tr;
                };
return null;
              },
              onChanged: (value) {
                controller.PKID = value.toString();
              },
            ),
          );
        });
  }

  Widget build(BuildContext context) {
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
          title: Text('StringTotal_AccountsReports'.tr, style: TextStyle(
              fontSize: Dimensions.fonAppBar,color: AppColors.textColor,
              fontWeight: FontWeight.bold
          )),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left:Dimensions.height20,right: Dimensions.height20,top: Dimensions.height15),
          child: GetBuilder<Inv_Rep_Controller>(
            init: Inv_Rep_Controller(),
            builder: ((value)=>
                Form(
                  child: ListView(
                    children: <Widget>[
                      Container(
                          margin: EdgeInsets.only(left: Dimensions.height5,right: Dimensions.height5),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular( Dimensions.width10)),
                          child: DropdownType_MovementBuilder2(),
                      ),
                      SizedBox(height: Dimensions.height10,),
                      //من فرع الى فرع
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: Dimensions.height5,right: Dimensions.height5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( Dimensions.width10)),
                                    child: DropdownBra_InfBuilder()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: Dimensions.height5,left: Dimensions.height5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimensions.width10)),
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
                          SizedBox(height: Dimensions.height10,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: Dimensions.height5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimensions.width10)),
                                    child: Column(
                                      children: [
                                        Text(
                                            (controller.SelectFromDays == null ?
                                            controller.SelectFromDays=controller.dateFromDays.toString().split(" ")[0]
                                                : controller.SelectFromDays.toString())
                                                .split(" ")[0],style: TextStyle(fontSize: Dimensions.fonText),),
                                        SizedBox(
                                          width: Dimensions.width100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.selectDateFromDays(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.MainColor, // Background color
                                            ),
                                            child: Text('StringFromDate'.tr,style: TextStyle(
                                              color: Colors.white, fontSize: Dimensions.fonText,
                                            ),),
                                          ),
                                        ),
                                      ],
                                    )
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: Dimensions.height5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimensions.width10)),
                                    child:  Column(
                                      children: [
                                        Text(
                                            controller.SelectToDays == null ?
                                            controller.SelectToDays=controller.dateTimeToDays.toString().split(" ")[0]
                                                : controller.SelectToDays.toString()
                                                .split(" ")[0],style: TextStyle(fontSize: Dimensions.fonText),),
                                        Container(
                                          width: Dimensions.width100,
                                          child: ElevatedButton(
                                            onPressed: () {
                                              controller.selectDateToDays(context);
                                            },
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: AppColors.MainColor, // Background color
                                            ),
                                            child: Text('StringToDate'.tr,style: TextStyle(
                                                color: Colors.white, fontSize: Dimensions.fonText),),
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
                      SizedBox(height: Dimensions.height10,),
                      Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: Dimensions.height5,right: Dimensions.height5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( Dimensions.width10)),
                                    child: DropdownSYS_CURBuilder()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: Dimensions.height5,left: Dimensions.height5),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(Dimensions.width10)),
                                    child: DropdownPAY_KINBuilder()
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: Dimensions.height20,),
                      Obx(() => controller.isloading.value == true
                            ? ThemeHelper().circularProgress()
                            : Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: MaterialButton(
                              onPressed: ()  {
                                  controller.Fetch_GET_ACC_REP_PdfData();
                                  Timer(const Duration(seconds: 3), () async {
                                    if(ACC_MOV_M_List.isEmpty || ACC_MOV_M_List.isEmpty ){
                                      Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                                          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                          colorText:Colors.white,
                                          isDismissible: true,
                                          dismissDirection: DismissDirection.horizontal,
                                          forwardAnimationCurve: Curves.easeOutBack);
                                        controller.isloading.value=false;
                                    } else {
                                      print(controller.AMKID.toString());
                                      print(controller.SelectFromDays.toString().substring(0, 10));
                                      print(controller.SelectToDays.toString().substring(0, 10));
                                      print(controller.SelectDataFromBIID.toString());
                                      print(controller.SelectDataToBIID.toString());
                                      print(LoginController().SUNA);
                                      final pdfFile = await Pdf.Total_Amount_of_Accounts_Pdf(
                                        controller.AMKID.toString(),
                                        controller.SelectFromDays.toString().substring(0, 10),
                                        controller.SelectToDays.toString().substring(0, 10),
                                        controller.SelectDataFromBIID.toString(),
                                        controller.SelectDataToBIID.toString(),
                                        LoginController().SUNA,
                                      );
                                      PdfPakage.openFile(pdfFile);
                                      controller.isloading.value=false;
                                    }
                                  });
                              },
                              child: Container(
                                height:Dimensions.height50,
                                width: Dimensions.width100,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: AppColors.MainColor,
                                    borderRadius:
                                    BorderRadius.circular(Dimensions.height10)),
                                child: Text('StringPrint'.tr,
                                  style: TextStyle(color: Colors.white, fontSize: Dimensions.fonText),
                                ),
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
