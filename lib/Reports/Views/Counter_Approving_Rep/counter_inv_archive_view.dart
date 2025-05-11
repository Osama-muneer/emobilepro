import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Setting/models/bil_poi.dart';
import '../../../Setting/models/cou_inf_m.dart';
import '../../../Setting/models/cou_typ_m.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/report_db.dart';
import '../../../database/setting_db.dart';
import '../../controllers/Counter_inv_archive_controller.dart';
import 'show_counter_bif_mov.dart';

class Counter_Inv_Archive_View extends StatefulWidget {
  @override
  State<Counter_Inv_Archive_View> createState() => _Counter_Inv_Archive_ViewState();
}
class _Counter_Inv_Archive_ViewState extends State<Counter_Inv_Archive_View> {
  final Counter_Inv_Archive_controller controller = Get.find();

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
                controller.SelectDataFromBINA=item.BINA_D.toString();
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
            },
            onChanged: (value) {
              controller.SelectDataToBIID = value.toString();
              controller.SelectDataF_SIID=null;
              controller.SelectDataT_SIID=null;
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
              controller.SelectDataFromBPID = value.toString();
              controller.update();
              GET_COU_INF_M_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString(),
                  controller.SelectDataFromCTMID.toString(), controller.SelectDataToCTMID.toString(),
                  controller.SelectDataFromBPID.toString(),controller.SelectDataToBPID.toString());
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
              controller.SelectDataToBPID = value.toString();
              GET_COU_INF_M_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString(),
                  controller.SelectDataFromCTMID.toString(), controller.SelectDataToCTMID.toString(),
                  controller.SelectDataFromBPID.toString(),controller.SelectDataToBPID.toString());
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
              controller.SelectDataFromCTMID = value.toString();
              controller.update();
              GET_COU_INF_M_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString(),
                  controller.SelectDataFromCTMID.toString(), controller.SelectDataToCTMID.toString(),
                  controller.SelectDataFromBPID.toString(),controller.SelectDataToBPID.toString());
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
              controller.SelectDataToCTMID = value.toString();
              controller.update();
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
              controller.SelectDataToCIMID = value.toString();
            },
          );
        });
  }
  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CURBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCIDlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
            value: controller.SelectDataSCID,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
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
          );
        });
  }
  FutureBuilder<List<Pay_Kin_Local>> DropdownPAY_KINBuilder() {
    return FutureBuilder<List<Pay_Kin_Local>>(
        future: GET_PAY_KIN(controller.UPIN_PKID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringPKIDlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_PAY', Colors.grey,'S'),
            value: controller.PKID,
            style: TextStyle(fontFamily: 'Hacen', color: Colors.black),
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
          );
        });
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
                  icon: const Icon(Icons.cleaning_services,color: Colors.white,),
                  onPressed: () {
                    controller.clear();
                    controller.update();
                  },
                ),

              ],
            )
          ],
          title: Text('StrinInvoices_Archive'.tr,style: 
          ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width),
          child: GetBuilder<Counter_Inv_Archive_controller>(
            init: Counter_Inv_Archive_controller(),
            builder: ((value)=>
                ListView(
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
                                          child:ThemeHelper().buildText(context,'StringToDate', Colors.white,'M')
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
                    //تقرير جرد محدد
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ThemeHelper().buildText(context,'StringINV_Rep_CH', Colors.black,'L'),
                        Checkbox(
                          value: controller.value,
                            onChanged: (value) {
                              if(controller.value1==true  ){
                                controller.value1=false;
                                controller.value = value!;
                                controller.update();
                              }
                              else{
                                controller.value = value!;
                                controller.update();
                              }
                          //     if(controller.SelectDataFromBPID == '')
                          //      {
                          //   controller.SelectDataFromBPID =   null;
                          // }
                          //     if(controller.SelectDataToBPID == '')
                          //      {
                          //       controller.SelectDataToBPID =   null;
                          //     }
                          //     if(controller.SelectDataFromCTMID == '')
                          //     {
                          //       controller.SelectDataFromCTMID =   null;
                          //     }
                          //     if(controller.SelectDataToCTMID == '')
                          //     {
                          //       controller.SelectDataToCTMID =   null;
                          //     }
                          //     if(controller.SelectDataFromCIMID == '')
                          //     {
                          //       controller.SelectDataFromCIMID =   null;
                          //     }
                          //     if(controller.SelectDataToCIMID == '')
                          //     {
                          //       controller.SelectDataToCIMID =   null;
                          //     }
                              controller.update();
                          },
                          activeColor: AppColors.MainColor,
                        ),
                      ],
                    ),
                    controller.value? Padding(
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
                          SizedBox(height:0.02 * height),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * width)),
                                    child:  DropdownSYS_CURBuilder()
                                ),
                              ),

                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(right: 0.02 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * width)),
                                    child:   DropdownPAY_KINBuilder()
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ):Container(),
                    controller.TypeScreen=='Tra_Mov_Rep'?Container():
                    SizedBox(height: 0.02 * height,),
                    Obx(
                          () => controller.isloading.value == true
                          ? ThemeHelper().circularProgress()
                          : Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: MaterialButton(
                            onPressed: ()  {
                              Get.to(() => Show_Counter_Bif_Mov());
                            },
                            child: Container(
                              height: 0.05 * height,
                              width: 2 * width,
                              alignment: Alignment.center,

                              decoration: BoxDecoration(
                                  color: AppColors.MainColor,
                                  borderRadius:
                                  BorderRadius.circular(0.02 * height)),
                              child:ThemeHelper().buildText(context,'StringSEARCH', Colors.white,'L')
                            )),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
