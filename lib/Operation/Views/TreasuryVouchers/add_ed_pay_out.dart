import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Operation/Controllers/Pay_Out_Controller.dart';
import '../../../Operation/Views/TreasuryVouchers/datagrid_vouchers.dart';
import '../../../Setting/Views/Customers/add_ed_customer.dart';
import '../../../Setting/models/acc_ban.dart';
import '../../../Setting/models/acc_cas.dart';
import '../../../Setting/models/acc_cos.dart';
import '../../../Setting/models/acc_mov_k.dart';
import '../../../Setting/models/bil_cre_c.dart';
import '../../../Setting/models/bil_dis.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class Add_Ed_Pay_Out extends StatefulWidget {
  const Add_Ed_Pay_Out({Key? key}) : super(key: key);
  @override
  State<Add_Ed_Pay_Out> createState() => _Add_Ed_Pay_OutState();
}

class _Add_Ed_Pay_OutState extends State<Add_Ed_Pay_Out> {
  final Pay_Out_Controller controller = Get.find();
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
  Future<void> selectDateFromDays(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate:  controller.dateTimeDays,
        firstDate: DateTime(2022,5),
        lastDate: DateTime(2050),
        builder: (context, child) {
      return   Theme(
        data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4A5BF6),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
        ),
        child: child!,
      );
    },
    );


    if (picked != null ) {
      setState(() {
        DateTime dateTimeDays = DateTime.now();
        final difference = dateTimeDays.difference(picked).inDays;
        if(difference>=0 ){
          controller.dateTimeDays = picked;
          controller.SelectDays =  DateFormat('dd-MM-yyyy HH:m').format(controller.dateTimeDays).toString().split(" ")[0];
        }
        else{
          Fluttertoast.showToast(
              msg: "StringCompareDate".tr,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
      });
    }
  }

  Future<bool> onWillPop() async {
    final shouldPop;
    if(Get.arguments==11){
      Navigator.of(context).pop(false);
      return true;
    }else{
    if((controller.edit == true || controller.CheckBack == 0)){
      if(controller.edit == true ){
        controller.CheckBack == 0 ? null : controller.Save_ACC_MOV_M_P(controller.edit,context);
      }
      Navigator.of(context).pop(false);
      controller.ClearACC_Mov_M_Data();
      controller.GET_ACC_MOV_M_P('DateNow',controller.AMKID!);
      shouldPop = await Get.toNamed('/View_Pay_Out');
    }
    else{
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
          bool isValid = controller.DELETE_ACC_MOV(controller.AMMID.toString(), 2);
          controller.ClearACC_Mov_M_Data();
          if (isValid) {
            Get.offAndToNamed('/View_Pay_Out');
          }
        },
      );
    }
    return shouldPop ?? false;
  }
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop ,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: AppColors.MainColor,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.group_add,color: Colors.white),
                  onPressed: () async {
                    if(controller.UPINCUS==1){
                      Get.to(() => Add_Ed_Customer(),arguments: 1);
                   //   Get.toNamed('/Add_Ed_Customer',arguments: 1);
                    }else{
                      Get.snackbar('StringUPIN'.tr, 'String_CHK_UPIN'.tr,
                          backgroundColor: Colors.red,
                          icon: Icon(Icons.error,color:Colors.white),
                          colorText:Colors.white,
                          isDismissible: true,
                          dismissDirection: DismissDirection.horizontal,
                          forwardAnimationCurve: Curves.easeOutBack);
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.save,color: Colors.white),
                  onPressed: () async {
                    // controller.GET_AMMNO_P();
                    if (controller.AMKID != 15  && controller.SHOW_BDID == '2'
                        && controller.SelectDataBDID == null ) {
                      Get.defaultDialog(
                        title: 'StringMestitle'.tr,
                        middleText: 'StringErr_BDID'.tr,
                        backgroundColor: Colors.white,
                        radius: 40,
                        textCancel: 'StringNo'.tr,
                        cancelTextColor: Colors.red,
                        textConfirm: 'StringYes'.tr,
                        confirmTextColor: Colors.white,
                        onConfirm: () async {
                          Navigator.of(context).pop(false);
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
                              controller.editMode(context);
                            },
                            // barrierDismissible: false,
                          );
                        },
                      );
                    }
                    else {
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
                          controller.editMode(context);
                          //      controller. get_BIF_MOV_M('DateNow');
                        },
                        // barrierDismissible: false,
                      );
                    }
                  },
                ),
              ],
            )
          ],
          title: Text('${controller.titleScreen} ${controller.AMKID==1 ? 'StringReceipt'.tr : controller.AMKID==2 ?
                       'StringPayment'.tr : controller.AMKID==3? 'StringCollectionsVoucher'.tr:
          'StringJournalVouchers'.tr }',style:
          ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: Form(
          key: controller.formKey,
          child: GetBuilder<Pay_Out_Controller>(
            init: Pay_Out_Controller(),
            builder: ((value)=> Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: 0.02 * width, right: 0.02 * width),
                  child: Column(
                    children: [
                      SizedBox(height: 0.01 * height),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width / 1.5,
                              child:  DropdownBra_InfBuilder()),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 4.4,
                            child: IgnorePointer(
                                ignoring: controller.Date_of_Insert_Voucher == '1'? true:
                                controller.Date_of_Insert_Voucher == '4' && controller.Allow_to_Inserted_Date_of_Voucher!=1?true
                                    :false,
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      selectDateFromDays(context);
                                    });
                                  },
                                  child: Text(
                                    (controller.SelectDays ?? (controller.SelectDays=DateFormat('dd-MM-yyyy').format(DateTime.now()).toString().split(" ")[0])),
                                    style:   ThemeHelper().buildTextStyle(context, Colors.black,'M')
                                  ),
                                )),
                          ),
                        ],
                      ),
                      SizedBox(height: 0.01 * height),
                      if(controller.AMKID!=15)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: Row(children: [
                              Checkbox(
                                value: controller.ValueAMMCC,
                                onChanged: (value) {
                                  if(controller.ValueAMMCC==true  ){
                                    controller.ValueAMMCC=false;
                                    controller.ValueAMMCC = value!;
                                    controller.update();
                                  }
                                  else{
                                    controller.ValueAMMCC = value!;
                                    controller.update();
                                  }
                                  controller.update();
                                },
                                activeColor: AppColors.MainColor,
                              ),
                              ThemeHelper().buildText(context,'StrinChangeCur', Colors.black,'L'),
                            ],),
                          ),
                          controller.ValueAMMCC?
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: TextField(
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                              controller: controller.AMMAM1Controller,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              onChanged: (v){
                                controller.AMMEQController.text=controller.roundDouble((double.parse(controller.AMMAM1Controller.text)*
                                    double.parse(controller.SCEXController.text)),0).toString();
                                controller.update();
                              },
                              decoration:  InputDecoration(
                                  
                                  labelText:" ${'StringAmount'.tr}  ( ${'StringTotalequivalent'.tr} ${double.parse(controller.AMMEQController.text)} )",
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(0.015*height),
                                      borderSide: BorderSide(color: Colors.grey.shade500)),
                                  labelStyle: TextStyle(color: Colors.grey),
                                  border: OutlineInputBorder(
                                      borderRadius:
                                      BorderRadius.all(Radius.circular(0.015*height)))),
                            ),
                          ) :Container(),
                        ],
                      ),
                      SizedBox(height: 0.01 * height),
                      controller.AMKID!=15?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: DropdownSYS_CURBuilder(),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: DropdownPAY_KINBuilder(),),
                        ],
                      ):
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: DropdownACC_MOV_KBuilder(),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: DropdownSYS_CURBuilder(),),
                        ],
                      ),
                      if(controller.AMKID!=15)
                      controller.PKID==1 ?
                      Column(
                        children: [
                          SizedBox(height: 0.01 * height),
                          DropdownACC_CASBuilder(),
                        ],
                      ):
                      controller.PKID == 9 || controller.PKID == 2 ?
                      Column(
                        children: [
                          SizedBox(height: 0.01 * height),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.15,
                                child: DropdownACC_BANBuilder(),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.15,
                                  child: TextFormField(
                                    controller: controller.AMMCNController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                                        labelText: controller.PKID == 9 ?  'StringTransferNo'.tr :
                                        'StringCheckNo'.tr,
                                        labelStyle: ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                0.15 * height),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade500)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0.015 * height)))),
                                  )),
                            ],
                          ),
                        ],
                      ):
                      Column(
                        children: [
                          SizedBox(height: 0.01 * height),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 2.15,
                                child:   DropdownBIL_CRE_CBuilder(),
                              ),
                              SizedBox(
                                  width: MediaQuery.of(context).size.width / 2.15,
                                  child:  TextFormField(
                                    controller: controller.AMMCNController,
                                    keyboardType: TextInputType.number,
                                    decoration: InputDecoration(
                                        contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                                        labelText: 'StringTransferNo'.tr,
                                        labelStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(
                                                0.15 * height),
                                            borderSide: BorderSide(
                                                color: Colors.grey.shade500)),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(0.015 * height)))),
                                  )
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.01 * height),
                      controller.AMKID!=15?
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: TextFormField(
                              style:  ThemeHelper().buildTextStyle(context, Colors.black,'L'),
                              controller: controller.AMMREController,
                              decoration: ThemeHelper().InputDecorationDropDown('StringReference'.tr),
                            ),
                          ),
                       SizedBox(
                            width: MediaQuery.of(context).size.width / 2.15,
                            child: DropdownBIL_DISBuilder()
                          ),
                        ],
                      )
                      :Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                      Expanded(
                      child: TextFormField(
                        style:  ThemeHelper().buildTextStyle(context, Colors.black,'L'),
                        controller: controller.AMMREController,
                        decoration: ThemeHelper().InputDecorationDropDown('StringReference'.tr),
                      ),
                    ),
                    ],
                   ),
                      SizedBox(height: 0.01 * height),
                      controller.P_COSM!='1' || (controller.P_COS_SEQ!='1' && controller.P_COS1!='1' &&  controller.P_COS1!='2')
                          ? Container() :  DropdownACC_COSBuilder(),
                      SizedBox(height: 0.01 * height),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                              controller: controller.AMMINController,
                              decoration: InputDecoration(

                                suffixIcon: IconButton(icon: Icon(Icons.error_outline),onPressed: (){
                                  if(controller.GET_AMMIN.isNotEmpty){
                                    buildShowDialogGET_AMMIN(context);
                                  }
                                }),
                                  labelText: 'StringDetails'.tr,
                                  labelStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                                  focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          0.15 * height),
                                      borderSide: BorderSide(
                                          color: Colors.grey.shade500)),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(0.015 * height)))),
                            ),
                          ),
                          IconButton(
                              icon: Icon(
                                Icons.add_circle,color: AppColors.MainColor, size: 0.05 * height,
                              ),
                              onPressed: () {
                                controller.GET_SYS_CUR_DAT_P(controller.SelectDataSCID.toString());
                                setState(() {
                                  if (controller.SelectDataBIID == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringBrach'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else if (controller.SelectDataSCID == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringChi_currency'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else if (controller.ValueAMMCC &&
                                      (double.parse(controller.AMMAM1Controller.text.isEmpty?'0.0':controller.AMMAM1Controller.text) <= 0.0
                                      || controller.AMMAM1Controller.text.isEmpty || controller.AMMAM1Controller.isNull)) {
                                    Fluttertoast.showToast(
                                        msg: 'StringvalidateAMDMD'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else if
                                  (controller.edit == false && controller.SCEXController.text.isEmpty ||
                                      (controller.SCHRController.text.isNotEmpty && double.parse(controller.SCEXController.text)>
                                       double.parse(controller.SCHRController.text)) ||
                                      (controller.SCLRController.text.isNotEmpty && double.parse(controller.SCEXController.text)<
                                          double.parse(controller.SCLRController.text))) {
                                    Fluttertoast.showToast(
                                        msg: 'StringError_SCEX'.tr,
                                        toastLength: Toast.LENGTH_LONG,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.redAccent);
                                  }
                                  else {
                                    controller.ClearACC_MOV_D();
                                    controller.ValueAMMCC?
                                    controller.AMMEQController.text=controller.roundDouble((double.parse(controller.AMMAM1Controller.text)*
                                        double.parse(controller.SCEXController.text)),0).toString():
                                    null;
                                    displayAddItems();
                                  }
                                });
                                // buildAlert(context).show();
                              }),
                        ],
                      ),
                      SizedBox(height: 0.01 * height),
                    ],
                  ),
                ),
                Expanded(
                  child: DataGridPageVouchers(),
                ),
              ],
            )),
          ),
        ),
        bottomNavigationBar:  GetBuilder<Pay_Out_Controller>(
          init: Pay_Out_Controller(),
            builder: ((value) => Container(
           // decoration: BoxDecoration(border: Border.all(color: Colors.black)),
            child:controller.AMKID==15 ?
            Container(
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomColumn(context,
                      title: "${'StringAMDMD'.tr}",
                      value: "${controller.AMMAMController.text.isEmpty?controller.AMMAMController.text='0':
                      controller.formatter.format(double.parse(controller.AMMAMController.text))}",
                      value2: "${controller.formatter.format(controller.SUMAMDEQ_MD)}"),
                  _buildBottomColumn(context,
                      title: "${'StringAMDDA'.tr}",
                      value: "${controller.SUMAMDAController.text.isEmpty?controller.SUMAMDAController.text='0':
                      controller.formatter.format(double.parse(controller.SUMAMDAController.text))}",
                      value2: "${controller.formatter.format(controller.SUMAMDEQ_DA)}"),
                  _buildBottomColumn(context,
                      title: "${'StringDefernt'.tr}",
                      value: "${controller.SUMAMDAController.text.isEmpty?
                      '0': controller.formatter.format(double.parse(
                          controller.AMMAMController.text)-double.parse(
                          controller.SUMAMDAController.text))}",
                      value2: "${controller.formatter.format(controller.Difference_AMDEQ_MD_DA)}"),
                 ],
              ),
            )
            :
            Container(
              color: Colors.grey[100],
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildBottomColumn(context,
                      title: "${controller.AMKID==2 || controller.AMKID==15 ? 'StringAMDMD'.tr:'StringAMDDA'.tr}",
                      value: "${controller.AMMAMController.text.isEmpty?controller.AMMAMController.text='0':
                      controller.formatter.format(double.parse(controller.AMMAMController.text))}"),
                  _buildBottomColumn(context,
                      title: "${'StringTotalequivalent'.tr}",
                      value: "${controller.AMDEQController.text.isEmpty?controller.AMDEQController.text='0':
                      controller.formatter.format(double.parse(controller.AMDEQController.text))}"),
                ],
              ),
            )
          )),
        ),
      ),
    );
  }

  Widget _buildBottomColumn(BuildContext context,{required String title, required String value,
     String? value2}) {
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
        controller.AMKID==15 ? Text(
          value2.toString(),
          style: ThemeHelper().buildTextStyle(context, Colors.red, 'M'),
        ):Container(),
      ],
    );
  }


  displayAddItems() {
    setState(() {
      controller.GETSUMAMDEQ();
      controller.GET_AMDIN_P();
      controller.update();
      controller.displayAddItemsWindo();
    });
  }

  GetBuilder<Pay_Out_Controller> DropdownBra_InfBuilder() {
    return GetBuilder<Pay_Out_Controller>(
        init: Pay_Out_Controller(),
        builder: ((value) => FutureBuilder<List<Bra_Inf_Local>>(
            future: GET_BRA(1),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringBrach',);
              }
              return IgnorePointer(
                ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown('StringBIIDlableText'.tr),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringBrach', Colors.grey,'S'),
                  value: controller.SelectDataBIID,
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    value: item.BIID.toString(),
                    child: Text(
                      "${item.BIID.toString()} - ${item.BINA_D.toString()}",
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList().obs,
                  validator: (v) {
                    if (v == null) {
                      return 'StringBrach'.tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    // Do something when changing the item if you want.
                    controller.SelectDataBIID = value.toString();
                    controller.SelectDataACID = null;
                    controller.SelectDataABID = null;
                    controller.SelectDataBCCID = null;
                    controller.update();
                  },
                ),
              );
            })));
  }

  FutureBuilder<List<Bil_Dis_Local>> DropdownBIL_DISBuilder() {
    return  FutureBuilder<List<Bil_Dis_Local>>(
            future: GET_BIL_DIS(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Dis_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringCollector'.tr,
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringCollector'.tr),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCollector', Colors.grey,'S'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataBDID = item.BDID.toString();
                    controller.update();
                  },
                  value: item.BDNA.toString(),
                  child: Text(
                    "${item.BDID.toString()} - ${item.BDNA.toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataBDID2,
                onChanged: (value) {
                  controller.SelectDataBDID2=value.toString();
                  controller.update();
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 250,
                ),
                dropdownSearchData: DropdownSearchData(
                    searchController: controller.TextEditingSercheController,
                    searchInnerWidget: Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        bottom: 4,
                        right: 8,
                        left: 8,
                      ),
                      child: TextFormField(
                        controller: controller.TextEditingSercheController,
                        decoration: InputDecoration(
                          isDense: true,
                          suffixIcon: IconButton(icon: const Icon(
                            Icons.clear,
                            size: 20,
                          ),
                            onPressed: (){
                              controller.TextEditingSercheController.clear();
                              controller.update();
                            },),
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 8,
                          ),
                          hintText: 'StringSearch_for_BDID'.tr,
                          hintStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    searchMatchFn: (item, searchValue) {
                      return (item.value
                          .toString()
                          .toLowerCase()
                          .contains(searchValue));
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

  FutureBuilder<List<Acc_Cos_Local>> DropdownACC_COSBuilder() {
    return FutureBuilder<List<Acc_Cos_Local>>(
        future: GET_ACC_COS(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringBrach',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringCostCenters'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_ACNO', Colors.grey,'S'),
            value: controller.SelectDataACNO,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.ACNO.toString(),
              child: Text(
                "${item.ACNO.toString()} - ${item.ACNA_D.toString()}",
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            validator: (v) {
              if (v == null) {
                return 'StringCHI_ACNO'.tr;
              }
              ;
              return null;
            },
            onChanged: (value) {
              controller.SelectDataACNO = value.toString();
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
            return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringChi_currency'.tr,);
          }
          return IgnorePointer(
            ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCIDlableText'.tr}  ${'Stringexchangerate'.tr} ${controller.SCEXController.text}" ),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
              iconStyleData: IconStyleData(
                icon:controller.SelectDataSCID==null ||  controller.edit == true || controller.CheckBack == 1?
                const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ): IconButton(icon: Icon(Icons.error_outline), iconSize:21,
                    onPressed: (){
                      controller.GET_SYS_CUR_DAT_P(controller.SelectDataSCID.toString());
                  buildShowSYS_CUR(context);
                  },
                    padding: EdgeInsets.only(bottom: 12, right: 25)
                  //  padding: EdgeInsets.only(bottom: 12,right: 25)
                ),
              ),
              value: controller.SelectDataSCID,
              style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                value: item.SCID.toString(),
                onTap: () {
                  controller.loading(true);
                  controller.SCEXController.text = item.SCEX.toString();
                  controller.SCHRController.text = item.SCHR.toString();
                  controller.SCLRController.text = item.SCLR.toString();
                  controller.SCSY = item.SCSY!;
                  controller.SCSFL = item.SCSFL!;
                  controller.loading(false);
                  controller.AMMEQController.text=controller.roundDouble((double.parse(controller.AMMAM1Controller.text)*
                      double.parse(controller.SCEXController.text)),0).toString();
                  controller.update();
                },
                child: Text(
                  "${item.SCID.toString()} - ${item.SCNA_D.toString()}",
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              ))
                  .toList()
                  .obs,
              validator: (v) {
                if (v == null) {
                  return 'StringvalidateSCID'.tr;
                }
                return null;
              },
              onChanged: (value) {
                controller.AMMEQController.text=(double.parse(controller.AMMAM1Controller.text.toString())*
                    double.parse(controller.SCEXController.text.toString())).toString();
                controller.SelectDataSCID = value.toString();
              },
            ),
          );
        });
  }

  FutureBuilder<List<Acc_Mov_K_Local>> DropdownACC_MOV_KBuilder() {
    return FutureBuilder<List<Acc_Mov_K_Local>>(
        future: GET_ACC_MOV_K_TYPE(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Mov_K_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringType'.tr,);
          }
          return IgnorePointer(
            ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType'.tr}"),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringType', Colors.grey,'S'),
              iconStyleData: IconStyleData(
               icon:  const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.black45,
                ),
              ),
              value: controller.AMKID_TYPE,
              style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.AMKID.toString(),
                child: Text(
                  "${item.AMKID.toString()} - ${item.AMKNA_D.toString()}",
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              )).toList().obs,
              validator: (v) {
                if (v == null) {
                  return 'StringType'.tr;
                }
                return null;
              },
              dropdownStyleData: const DropdownStyleData(
                maxHeight: 300,
              ),
              onChanged: (value) {
                controller.AMKID_TYPE = value.toString();
              },
            ),
          );
        });
  }

  GetBuilder<Pay_Out_Controller> DropdownACC_BANBuilder() {
    return GetBuilder<Pay_Out_Controller>(
        init: Pay_Out_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Ban_Local>>(
            future: GET_ACC_BAN(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Ban_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringBank'.tr),
                isExpanded: true,
                hint:ThemeHelper().buildText(context,'StringvalidateABID', Colors.grey,'S'),
                value: controller.SelectDataABID,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  value: item.ABID.toString(),
                  child: Text(
                    "${item.ABID.toString()} - ${item.ABNA_D.toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  controller.SelectDataABID = value.toString();
                  controller.update();
                },
              );
            })));
  }

  FutureBuilder<List<Pay_Kin_Local>> DropdownPAY_KINBuilder() {
    return FutureBuilder<List<Pay_Kin_Local>>(
        future: GET_PAY_KIN(1,'AC',2,''),
        builder: (BuildContext context,
            AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringChi_PAY'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringPKIDlableText'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_PAY', Colors.grey,'S'),
            value: controller.PKID.toString(),
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.PKID.toString(),
              onTap: () {
                  controller.PKID=item.PKID!;
                  controller.GETDefaultDescription_Voucher();
                  controller.update();
              },
              child: Text(
                "${item.PKID.toString()} - ${item.PKNA_D.toString()}",
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            validator: (v) {
              if (v == null) {
                return 'StringBrach'.tr;
              }
              ;
              return null;
            },
            onChanged: (value) {
              controller.SelectDataPKID = value.toString();
              controller.PKID = int.parse(value.toString());
              controller.GETDefaultDescription_Voucher();
                controller.update();
            },
          );
        });
  }

  GetBuilder<Pay_Out_Controller> DropdownACC_CASBuilder() {
    return GetBuilder<Pay_Out_Controller>(
        init: Pay_Out_Controller(),
        builder: ((value) => FutureBuilder<List<Acc_Cas_Local>>(
            future: GET_ACC_CAS(controller.SelectDataBIID.toString(),controller.SelectDataSCID.toString(),'AC',
                controller.AMKID==3?1:controller.AMKID!),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Cas_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringCashier',);
              }
              return  DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringACIDlableText'.tr),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCashier', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.ACID.toString(),
                  child: Text(
                    "${item.ACID.toString()} - ${item.ACNA_D
                        .toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataACID,
                onChanged: (value) {
                  controller.SelectDataACID = value ;
                  controller.update();
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 250,
                ),
              );
            })));
  }

  GetBuilder<Pay_Out_Controller> DropdownBIL_CRE_CBuilder() {
    return GetBuilder<Pay_Out_Controller>(
        init: Pay_Out_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Cre_C_Local>>(
            future: GET_BIL_CRE_C(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Cre_C_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringBilCrec',);
              }
              return  DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringCreditCard'.tr),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCreditCard', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.BCCID.toString(),
                  child: Text(
                    "${item.BCCID.toString()} - ${item.BCCNA_D.toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataBCCID,
                onChanged: (value) {
                  controller.SelectDataBCCID = value as String;
                  controller.update();
                },
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.BCCIDController.clear();
                  }
                },
              );
            })));
  }

  Future<dynamic> buildShowDialogGET_AMMIN(BuildContext context) {
    return Get.defaultDialog(
      title: "StringDetails".tr,
      content:Container(
        width: 210,
        height: 180,
        child: ListView.separated(
          shrinkWrap: true,
          itemCount: controller.GET_AMMIN.length,
          itemBuilder: (context,index){
            return GestureDetector(
              child: Text(controller.GET_AMMIN[index].AMMIN.toString()),
              onTap: (){
                controller.AMMINController.text=controller.GET_AMMIN[index].AMMIN.toString();
                controller.update();
                Get.back();
              },
            );
          },
          separatorBuilder: (context,index){
            return const Divider(
              color: Colors.blue,
            );
          },),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }

  Future<dynamic> buildShowSYS_CUR(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StringAdditional_Data".tr,
      content: Padding(
        padding: EdgeInsets.only(right: 0.02*width, left: 0.02*width),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(context,"Stringexchangerate", Colors.black,'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: controller.SelectDataSCID=='1' ?true:false,
                    textAlign:TextAlign.center,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        errorText: controller.errorText.value),
                    controller: controller.SCEXController,
                    // onChanged: (v) {
                    //   controller.validateDefault_SNNO(v);
                    // },
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(context,'StrinSCHR', Colors.black,'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign:TextAlign.center,
                    controller: controller.SCHRController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8)),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ThemeHelper().buildText(context,'StrinSCLR', Colors.black,'M'),
                Expanded(
                  child: TextFormField(
                    readOnly: true,
                    textAlign:TextAlign.center,
                    controller: controller.SCLRController,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 13, horizontal: 8)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }

}
