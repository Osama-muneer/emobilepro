import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/services.dart';
import '../../../PrintFile/share_mode.dart';
import '../../../Reports/Views/Vouchers_Archive/show_data_archive.dart';
import '../../../Reports/controllers/accounts_archive_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/acc_acc.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import 'accounts_archive_pdf.dart';

class Show_Acc_Mov extends StatefulWidget {
  @override
  State<Show_Acc_Mov> createState() => _Show_Acc_MovState();
}

class _Show_Acc_MovState extends State<Show_Acc_Mov> {
  final Accounts_ArchiveController controller = Get.find();


  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar:
      AppBar(
        backgroundColor: AppColors.MainColor,
        title: Text('StringAccountsArchive'.tr,
          style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 3),
            child: IconButton(icon: const Icon(Icons.picture_as_pdf),
                onPressed: (){
                  controller.GET_ACC_MOV_REP_P();
                  Timer(const Duration(seconds: 2), () async{
                    Accounts_Archive_Pdf(
                      mode: ShareMode.view,GetBINAF: controller.SelectDataFromBIID.toString(),
                      GetBINAT:   controller.SelectDataToBIID.toString(),
                      GetBMMDAF:   (controller.SelectFromDays2 == null ?
                      controller.SelectFromDays2=controller.dateFromDays.toString().split(" ")[0]
                          : controller.SelectFromDays2.toString())
                          .split(" ")[0],
                      GetBMMDAT:    controller.SelectToDays2 == null ?
                      controller.SelectToDays2=controller.dateTimeToDays.toString().split(" ")[0]
                          : controller.SelectToDays2.toString().split(" ")[0],
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


  final List<Map> GET_CON_3 = [
    {"id": '1', "name": 'StringBIID'.tr},
    {"id": '2', "name": 'StringType'.tr},
    {"id": '3', "name": 'StringManualNO'.tr},
    {"id": '4', "name": 'StringSMDED2'.tr},
    {"id": '5', "name": 'StringSCIDlableText'.tr},
    {"id": '6', "name":"${'StringAmount'.tr}"},
  ].obs;

  GetBuilder<Accounts_ArchiveController> DropdownTYPE_TBuilder() {
    return GetBuilder<Accounts_ArchiveController>(
        init: Accounts_ArchiveController(),
        builder: ((controller) => DropdownButtonFormField2(
          decoration:  ThemeHelper().InputDecorationDropDown("StringOrderBy".tr),
          isExpanded: true,
          value: controller.TYPE_T,
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
          items: GET_CON_3.map((item) => DropdownMenuItem<String>(
            value: item['id'],
            child: Text(
              item['name'],
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            ),
          )).toList().obs,
          onChanged: (value) {
            controller.TYPE_T = value.toString();
            controller.update();
          },
        )));
  }

  final List<Map> TYP_ORD_L = [
    {"id": '1', "name": 'StringASC_DE1'.tr},
    {"id": '2', "name": 'StringASC_DE2'.tr},
  ].obs;
  GetBuilder<Accounts_ArchiveController> DropdownTYPE_ORDBuilder() {
    return GetBuilder<Accounts_ArchiveController>(
        init: Accounts_ArchiveController(),
        builder: ((controller) => DropdownButtonFormField2(
          decoration:  ThemeHelper().InputDecorationDropDown("StringOrderBy".tr),
          isExpanded: true,
          value: controller.TYPE_ORD2,
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
          items: TYP_ORD_L.map((item) => DropdownMenuItem<String>(
            value: item['id'],
            child: Text(
              item['name'],
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            ),
          )).toList().obs,
          onChanged: (value) {
            controller.TYPE_ORD2 = value.toString();
            controller.update();
          },
        )));
  }

  Widget _buildFilterContent(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<Accounts_ArchiveController>(
        init: Accounts_ArchiveController(),
        builder: ((controller) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: <Widget>[
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
                      SizedBox(height: 0.02 * height),
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
                                          .split(" ")[0],style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
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
                                child:  Column(
                                  children: [
                                    Text(
                                      controller.SelectToDays2 == null ?
                                      controller.SelectToDays2=controller.dateTimeToDays.toString().split(" ")[0]
                                          : controller.SelectToDays2.toString().split(" ")[0],
                                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                    Container(
                                      width: 0.3 * width,
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
                                child: DropdownTYPE_TBuilder(),
                            ),
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(right: 0.02 * height),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(0.02 * width)),
                                child: DropdownTYPE_ORDBuilder(),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 0.02 * height),
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
                          controller.update();
                        },
                        activeColor: AppColors.MainColor,
                      ),
                    ],
                  ),
                  if(controller.value)
                    Padding(
                      padding:  EdgeInsets.all(0.002 * width),
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
                          Container(
                              margin: EdgeInsets.only(left: 0.02 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.02 * height)),
                              child:  DropdownACC_ACCBuilder()
                          ),
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

  FutureBuilder<List<Acc_Acc_Local>> DropdownACC_ACCBuilder() {
    return FutureBuilder<List<Acc_Acc_Local>>(
        future: Query_Acc_Acc_P(LoginController().BIID.toString()),
        builder: (BuildContext context, AsyncSnapshot<List<Acc_Acc_Local>> snapshot) {
          double height = MediaQuery.of(context).size.height;
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringAANO',
            );
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringAANO'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringAANO', Colors.grey,'S'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              onTap: (){
                controller.AANA= item.AANA_D.toString();
                controller.SelectDataAANO= item.AANO.toString();
              },
              value: "${item.AANO.toString() + " +++ " + item.AANA_D.toString()}",
              child: Text(
                item.AANA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            value: controller.SelectDataAANA,
            onChanged: (value) {
              setState(() {
                controller.SelectDataAANA = value.toString();
                controller.SelectDataAANO = value.toString().split(" +++ ")[0];
                controller.update();
              });
            },
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
            ),
            dropdownSearchData: DropdownSearchData(
                searchController: controller.TextEditingSercheController,
                searchInnerWidget: Padding(
                  padding: const EdgeInsets.only(top: 8, bottom: 4, right: 8, left: 8),
                  child: TextFormField(
                    controller: controller.TextEditingSercheController,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      suffixIcon: IconButton(icon: const Icon(Icons.clear, size: 20),
                        onPressed: (){
                          controller.TextEditingSercheController.clear();
                          controller.update();
                        },),
                      hintText: 'StringSearch_for_AANO'.tr,
                      hintStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (item, searchValue) {
                  return (item.value.toString().toLowerCase().contains(searchValue));
                },
                searchInnerWidgetHeight: 50),

            //This to clear the search value when you close the menu
            onMenuStateChange: (isOpen) {
              if (!isOpen) {
                controller.TextEditingSercheController.clear();
              }
            },
          );
        });
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

