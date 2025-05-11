import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Reports/controllers/accounts_archive_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/acc_acc.dart';
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
import 'package:get/get.dart';
import 'show_acc_mov.dart';

class Accounts_Archive_View extends StatefulWidget {
  @override
  State<Accounts_Archive_View> createState() => _Accounts_Archive_ViewState();
}
class _Accounts_Archive_ViewState extends State<Accounts_Archive_View> {
  final Accounts_ArchiveController controller = Get.find();

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
          title: Text('StringAccountsArchive'.tr,style:
          ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width),
          child: GetBuilder<Accounts_ArchiveController>(
            init: Accounts_ArchiveController(),
            builder: ((value)=>
                Column(
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
                    Obx(
                          () => controller.isloading.value == true
                          ? ThemeHelper().circularProgress()
                          : Container(
                        decoration: ThemeHelper().buttonBoxDecoration(context),
                        child: MaterialButton(
                            onPressed: ()  {
                              Get.to(() => Show_Acc_Mov());
                            },
                            child: Container(
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: AppColors.MainColor,
                                  borderRadius:
                                  BorderRadius.circular(0.02 * height)),
                              child: ThemeHelper().buildText(context,'StringSEARCH', Colors.white,'L'),
                            )),
                      ),
                    ),
                  ],
                )),
          ),
        ));
  }
}
