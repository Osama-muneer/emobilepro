import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';

import '../../../PrintFile/share_mode.dart';
import '../../../Reports/Views/Invoices_Archive/show_data_archive.dart';
import '../../../Reports/controllers/invoices_archive_controller.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import 'invoices_archive_pdf.dart';

class Show_Bif_Mov extends StatefulWidget {
  @override
  State<Show_Bif_Mov> createState() => _Show_Bif_MovState();
}

class _Show_Bif_MovState extends State<Show_Bif_Mov> {
  final Invoices_ArchiveController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.MainColor,
        title: Text('StrinInvoices_Archive'.tr,
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: height*0.02),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: Dimensions.height5),
            child: IconButton(icon: const Icon(Icons.picture_as_pdf),
                onPressed: (){
                  controller.GET_BIL_MOV_REP_P();
                  Timer(const Duration(seconds: 2), () async{
                    Invoices_Archive_Pdf(
                      mode: ShareMode.view,GetBINAF: controller.SelectDataFromBIID.toString(),
                      GetBINAT:   controller.SelectDataToBIID.toString(),
                      GetBMMDAF:   controller.SelectFromDays2 == null ?
                      controller.SelectFromDays2=controller.dateFromDays.toString().split(" ")[0]
                          : controller.SelectFromDays2.toString(),
                      GetBMMDAT:     controller.SelectToDays2 == null ?
                      controller.SelectToDays2=controller.dateTimeToDays.toString().split(" ")[0]
                          : controller.SelectToDays2.toString(),
                    );
                  });
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
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () => showFilterSheet(context),
          ),
        ],
      ),
      body:  Show_DataGrid_archive(),
      bottomNavigationBar: GetBuilder<Invoices_ArchiveController>(
          builder: ((value) => SafeArea(
            child: Container(
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomColumn(context,
                      title: "${'StrinCount_SMDFN'.tr}",
                      value: "${ controller.formatter.format(controller.totalBmmam)}"),
                  _buildBottomColumn(context,
                      title: "${'StringSUMBMMDI2'.tr}",
                      value: "${ controller.formatter.format(controller.totalBmmdi)}"),
                  _buildBottomColumn(context,
                      title: "${'StringSUM_BMMTX_ORD'.tr}",
                      value: "${ controller.formatter.format(controller.totalBmmtx)}"),
                  _buildBottomColumn(context,
                      title: "${'StringSMDNF'.tr}:",
                      value: "${ controller.formatter.format(controller.totalBmmdif)}"),
                  _buildBottomColumn(context,
                      title: "${'StringNet_Amount'.tr}",
                      value:
                      "${ controller.formatter.format(controller.totalBmmam)}"),
                ],
              ),
            ),
          ))),
    );
  }

  Widget _buildBottomColumn(BuildContext context,{required String title, required String value}) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          title,
          style: ThemeHelper().buildTextStyle(context, Colors.red, 'M'),
        ),
        Text(
          value,
          style: ThemeHelper().buildTextStyle(context, Colors.red, 'M'),
        ),
      ],
    );
  }


  showFilterSheet(BuildContext  context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: const EdgeInsets.all(10),
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.9,
        ),
        child: _buildFilterContent(context),
      ),
    );
  }

  Widget _buildFilterContent(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<Invoices_ArchiveController>(
        init: Invoices_ArchiveController(),
        builder: ((controller) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
                  SizedBox(height: 0.02 * height),
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
                  SizedBox(height: 0.02 * height),
                  //من تاريخ الى تاريخ
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                      (controller.SelectFromDays2 == null ?
                                      controller.SelectFromDays2=controller.dateFromDays.toString().split(" ")[0]
                                          : controller.SelectFromDays2.toString())
                                          .split(" ")[0],style:
                                    ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                    SizedBox(width:  0.3 * width,
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.selectDateFromDays(context);
                                        },
                                        color: AppColors.MainColor,
                                        child: ThemeHelper().buildText(context,'StringFromDate', Colors.white,'M'),
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
                                child: Column(
                                  children: [
                                    Text(
                                      controller.SelectToDays2 == null ?
                                      controller.SelectToDays2=controller.dateTimeToDays.toString().split(" ")[0]
                                          : controller.SelectToDays2.toString()
                                          .split(" ")[0],style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                    SizedBox(width:  0.3 * width,
                                      child: MaterialButton(
                                        onPressed: () {

                                          controller.selectDateToDays(context);
                                        },
                                        color: AppColors.MainColor,
                                        child: ThemeHelper().buildText(context,'StringToDate', Colors.white,'M'),
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
                  SizedBox(height: 0.02 * height),
                  //من تاريخ الى تاريخ
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                                      (controller.SelectFromDATEI == null ? ''
                                          : controller.SelectFromDATEI.toString())
                                          .split(" ")[0],style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                    SizedBox(width:  0.3 * width,
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.selectDateFromDATEI(context);
                                        },
                                        color: AppColors.MainColor,
                                        child: ThemeHelper().buildText(context,'StringFrom_Insert_Date', Colors.white,'M'),
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
                                child: Column(
                                  children: [
                                    Text(
                                      (controller.SelectToDATEI == null ? ''
                                          : controller.SelectToDATEI.toString())
                                          .split(" ")[0],style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                    SizedBox(width:  0.3 * width,
                                      child: MaterialButton(
                                        onPressed: () {
                                          controller.selectDateToDATEI(context);
                                        },
                                        color: AppColors.MainColor,
                                        child: ThemeHelper().buildText(context,'StringTo_Amount', Colors.white,'M'),
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
                  SizedBox(height: 0.02 * height),
                  Padding(
                    padding: EdgeInsets.all(0.002 * width),
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
                                      borderRadius: BorderRadius.circular( 0.02 * height)),
                                  child:  DropdownSYS_CURBuilder()
                              ),
                            ),
                            SizedBox(height:0.02 * height),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(left: 0.02 * height),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular( 0.02 * height)),
                                  child:   DropdownPAY_KINBuilder()
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height:0.02 * height),
                      ],
                    ),
                  ),
                  SizedBox(height:0.02 * height),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton.icon(
                          icon: Icon(Icons.refresh, color: Colors.red[800]),
                          label: Text('StringReset'.tr,
                              style: TextStyle(color: Colors.red[800])),
                          style: OutlinedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            side: BorderSide(color: Colors.red[800]!),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          onPressed: _resetFilters,
                        ),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check, color: Colors.white),
                          label: Text('StringSEARCH'.tr,
                              style: TextStyle(color: Colors.white)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red[800],
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            elevation: 3,
                          ),
                          onPressed: () => _applyFilters(context),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ))
    );
  }

  Future<void> _resetFilters() async {
    controller.clear();
    controller.update();
  }

  Future<void> _applyFilters(BuildContext context) async {
    controller.update();
    Navigator.pop(context);
    // تطبيق الفلاتر هنا
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
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
              controller.SelectDataFromBIID = value.toString();
              controller.value=false;
            },
          );
        });
  }
  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_ToBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
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
              //if(controller.SelectDataF_SIID!=null  || controller.SelectDataT_SIID!=null){
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
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.SCID.toString(),
              child: Text(
                "${item.SCNA_D.toString()}",
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
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
        future: GET_PAY_KIN(1,'REP',1,''),
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
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.PKID.toString(),
              child: Text(
                "${item.PKNA_D.toString()}",
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
}