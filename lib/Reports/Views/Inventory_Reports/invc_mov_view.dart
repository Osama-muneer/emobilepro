import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/mat_gro.dart';
import '../../../Setting/models/sto_inf.dart';
import '../../../Setting/models/sto_mov_k.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/report_db.dart';
import '../../../database/setting_db.dart';
import '../../controllers/invc_mov_rep_controller.dart';

class Invc_Mov_View extends StatefulWidget {
  @override
  State<Invc_Mov_View> createState() => _Invc_Mov_ViewState();
}
class _Invc_Mov_ViewState extends State<Invc_Mov_View> {
  @override

  final controller=Get.put(Invc_Mov_RepController());

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA_INF(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringFromBrach'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringBIIDlableText'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringFromBrach', Colors.grey,'S'),
            value: controller.SelectDataFromBIID,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              
              onTap: (){
                controller.SelectDataFromBINA=item.BINA_D.toString();
              },
              child: Text(
                item.BINA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'StringBrach'.tr;
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataFromBIID = value.toString();
              controller.value=false;
              controller.SelectDataF_SIID = null;
              controller.SelectDataT_SIID = null;
              controller.SelectDataFromMGNO = null;
              controller.SelectDataToMGNO = null;
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
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringToBrach'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringBIID_TlableText'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
            value: controller.SelectDataToBIID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: (){
                controller.SelectDataToBINA=item.BINA_D.toString();
              },
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (value) {
              if (value == null) {
                return 'StringBrach'.tr;
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataToBIID = value.toString();
              controller.SelectDataF_SIID = null;
              controller.SelectDataT_SIID = null;
              controller.SelectDataFromMGNO = null;
              controller.SelectDataToMGNO = null;
            },
          );
        });
  }

  FutureBuilder<List<Sto_Inf_Local>> DropdownFrom_Sto_InfBuilder() {
    return FutureBuilder<List<Sto_Inf_Local>>(
        future: FROM_STO_INF_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringFromBrach'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringF_SIID'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringStoch', Colors.grey,'S'),
            value: controller.SelectDataF_SIID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.SIID.toString(),
              child: Text(
                item.SINA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'StringStoch'.tr;
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataF_SIID = value.toString();
              controller.SelectDataFromMGNO = null;
              controller.SelectDataToMGNO = null;
              controller.update();
            },
          );
        });
  }

  FutureBuilder<List<Sto_Inf_Local>> DropdownTo_Sto_InfBuilder() {
    return FutureBuilder<List<Sto_Inf_Local>>(
        future:  FROM_STO_INF_REP(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringToBrach'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringT_SIID'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringStoch', Colors.grey,'S'),
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            value: controller.SelectDataT_SIID,
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
          
              value: item.SIID.toString(),
              child: Text(
                item.SINA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return 'StringStoch'.tr;
              }
              return null;
            },
            onChanged: (value) {
              //Do something when changing the item if you want.
              controller.SelectDataT_SIID = value.toString();
              controller.SelectDataFromMGNO = null;
              controller.SelectDataToMGNO = null;
              controller.update();
            },
          );
        });
  }

  FutureBuilder<List<Mat_Gro_Local>> DropdownMat_Gro_From() {
    return FutureBuilder<List<Mat_Gro_Local>>(
        future:  GET_MAT_GRO(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Gro_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringMgno'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringFromMgno'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChiceMGNO', Colors.grey,'S'),
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            dropdownStyleData: const DropdownStyleData(
                maxHeight: 300,
                width: 200
            ),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: () {
                controller.SelectDataFromMGNO = item.MGNO.toString();
                controller.update();
              },
              value: item.MGNO.toString(),
              child: Text(
                item.MGNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            value: controller.SelectDataFromMGNO,
            onChanged: (value) {
              print('value');
              controller.SelectDataFromMGNO = value.toString();
              // controller.SelectDataFromMINO = null;
              // controller.SelectDataToMINO = null;
              controller.update();
              //controller.SelectDataMINO = value as String;
            },
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'StringSearch_for_MGNO'.tr,
                      hintStyle: ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
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

  FutureBuilder<List<Mat_Gro_Local>> DropdownMat_Gro_To() {
    return FutureBuilder<List<Mat_Gro_Local>>(
        future: GET_MAT_GRO(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Gro_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringMgno'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringToMgno'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChiceMGNO', Colors.grey,'S'),
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            dropdownStyleData: const DropdownStyleData(
                maxHeight: 300,
                width: 200
            ),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: () {
                controller.SelectDataToMGNO = item.MGNO.toString();
              },
              value: item.MGNO.toString(),
              child: Text(
                item.MGNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            value: controller.SelectDataToMGNO,
            onChanged: (value) {
              print('value');
              controller.SelectDataToMGNO = value.toString();
              controller.update();
            },
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
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 8,
                      ),
                      hintText: 'StringSearch_for_MGNO'.tr,
                      hintStyle: ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
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

  FutureBuilder<List<Sto_Mov_K_Local>> DropdownBIL_MOV_K() {
    return FutureBuilder<List<Sto_Mov_K_Local>>(
        future:  GET_STO_MOV_K(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sto_Mov_K_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringFromBrach'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringType'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringType', Colors.grey,'S'),
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.SMKID.toString(),
              child: Text(
                item.SMKNA_D.toString(),
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
              controller.SelectDataSMKID = value.toString();
              controller.value=false;
            },
          );
        });
  }


  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MainColor,
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.cleaning_services),
                  onPressed: () {
                    controller.clearData();
                    controller.update();
                  },
                ),
    
              ],
            )
          ],
          title: Text(controller.TypeScreen=='Inv_Mov_Rep'?'StringInvc_Mov_Rep'.tr:controller.TypeScreen=='Mat_Mov_Rep'?'StringMat_Mov_Rep'.tr:
              controller.TypeScreen=='Tra_Mov_Rep'?'StringTra_Mov_Rep'.tr:controller.TypeScreen=='Incoming_Store_Rep'?'StringReportWarehouseMovement'.tr:'StringInv_Mov_Rep'.tr,
              style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
          ),
          centerTitle: true,
        ),
        body: GetBuilder<Invc_Mov_RepController>(
          init: Invc_Mov_RepController(),
          builder: ((value)=>
              Padding(
                padding: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width),
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      //من فرع الى فرع
                      controller.TypeScreen=='Incoming_Store_Rep'?
                      Column(
                        children: [
                          SizedBox(height: 0.02 * height),
                          DropdownBIL_MOV_K(),
                        ],
                      )
                          :Container(),
                      Column(
                        children: [
                          SizedBox(height: 0.015 * height),
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(left: 0.015 * width),
                                  child: DropdownBra_InfBuilder(),
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding:EdgeInsets.only(right: 0.015 * width),
                                  child: DropdownBra_Inf_ToBuilder(),
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
                          SizedBox(height: 0.015 * height),
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
                                                .split(" ")[0],
                                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                        SizedBox(
                                          width: 0.3 * width,
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
                                            controller.SelectToDays == null ?
                                            controller.SelectToDays=controller.dateTimeToDays.toString().split(" ")[0]
                                                : controller.SelectToDays.toString()
                                                .split(" ")[0],
                                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                        Container(
                                          width: 0.3 * width,
                                          child: MaterialButton(
                                            onPressed: () {
                                              controller.selectDateToDays(context);
                                            },
                                            color: AppColors.MainColor,
                                            child:ThemeHelper().buildText(context,'StringToDate', Colors.white,'M'),
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
                          Text(controller.TypeScreen=='Inv_Mov_Rep'?'StringINV_Rep_CH'.tr:
                          controller.TypeScreen=='Tra_Mov_Rep'?'StringTRA_Rep_CH'.tr: controller.TypeScreen=='Incoming_Store_Rep'?'StringINV_Rep_CH'.tr:
                          'StringRep_CH'.tr,
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'L')),
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
                                if(controller.SelectDataF_SIID == '')
                                 {
                              controller.SelectDataF_SIID =   null;
                            }
                                if(controller.SelectDataT_SIID == '')
                                 {
                                  controller.SelectDataT_SIID =   null;
                                }
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
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0.015 * width),
                                    child: DropdownFrom_Sto_InfBuilder(),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0.015 * width),
                                    child: DropdownTo_Sto_InfBuilder(),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 0.015 * height),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0.015 * width),
                                    child: DropdownMat_Gro_From(),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0.015 * width),
                                    child: DropdownMat_Gro_To(),
                                  ),
                                ),
                              ],
                            ),
                             SizedBox(height: 0.015 * height),
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(left: 0.015 * width),
                                    child: TextField(
                                      style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                      controller: controller.FromSMMNOController,
                                      textAlign: TextAlign.center,
                                      keyboardType: TextInputType.number,
                                      decoration: ThemeHelper().InputDecorationDropDown('StringSMMNO'.tr),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 0.015 * width),
                                    child: TextField(
                                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                      keyboardType: TextInputType.number,
                                      controller: controller.ToSMMNOController,
                                      textAlign: TextAlign.center,
                                      decoration: ThemeHelper().InputDecorationDropDown('StringTo_Amount'.tr),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                      ) : Container(),
                      controller.TypeScreen=='Incoming_Store_Rep'?
                      Container():
                          //تحديد النوع
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:  EdgeInsets.only(right: 0.002 * width),
                            child:ThemeHelper().buildText(context,'StringTypeRep', Colors.black,'L'),
                          ),
                          Checkbox(
                            value: controller.value1,
                            onChanged: (value) {
                              if(controller.value==true  ){
                                controller.value=false;
                                controller.value1 = value!;
                                controller.update();
                              }
                              else{
                                controller.value1 = value!;
                                controller.update();
                              }
                              controller.update();
                            
                            },
                            activeColor: AppColors.MainColor,
                          ),
                        ],
                      ),
                      controller.TypeScreen=='Inv_Mov_Rep'?
                      controller.value1? Padding(
                        padding: EdgeInsets.only(left: 0.04 * width, right: 0.04 * width),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringAll', Colors.black,'M'),
                                Checkbox(
                                  value: controller.valueAll,
                                  onChanged: (value) {
                                    if(controller.valuePlus==true ||controller.valueEquil==true||controller.valueMinus==true  )
                                    {
                                      controller.valuePlus = false;
                                      controller.valueEquil = false;
                                      controller.valueMinus = false;
                                      controller.valueAll = value!;
                                      controller.SetTypeValue='All';
                                      controller.update();
                                    }
                                    else{

                                      controller.valueAll = value!;
                                      controller.SetTypeValue='All';
                                      controller.update();
                                    }
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringSUMPLUS', Colors.black,'M'),
                                Checkbox(
                                  value: controller.valuePlus,
                                  onChanged: (value) {
                                    if(controller.valueAll==true ||controller.valueEquil==true||controller.valueMinus==true  )
                                    {
                                      controller.valueAll = false;
                                      controller.valueEquil = false;
                                      controller.valueMinus = false;
                                      controller.valuePlus = value!;
                                      controller.SetTypeValue='Plus';
                                      controller.update();
                                    }
                                    else{

                                      controller.valuePlus = value!;
                                      controller.SetTypeValue='Plus';
                                      controller.update();
                                    }
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringEquil', Colors.black,'M'),
                                Checkbox(
                                  value: controller.valueEquil,
                                  onChanged: (value) {
                                    if(controller.valueAll==true ||controller.valuePlus==true||controller.valueMinus==true  )
                                    {
                                      controller.valueAll = false;
                                      controller.valuePlus = false;
                                      controller.valueMinus = false;
                                      controller.valueEquil = value!;
                                      controller.SetTypeValue='Equil';
                                      controller.update();
                                    }
                                    else{

                                      controller.valueEquil = value!;
                                      controller.SetTypeValue='Equil';
                                      controller.update();
                                    }
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringSUMMINES', Colors.black,'M'),
                                Checkbox(
                                  value: controller.valueMinus,
                                  onChanged: (value) {
                                    if(controller.valueAll==true ||controller.valueEquil==true||controller.valuePlus==true  )
                                    {
                                      controller.valueAll = false;
                                      controller.valueEquil = false;
                                      controller.valuePlus = false;

                                      controller.valueMinus = value!;
                                      controller.SetTypeValue='Minus';
                                      controller.update();
                                    }
                                    else{

                                      controller.valueMinus = value!;
                                      controller.SetTypeValue='Minus';
                                      controller.update();
                                    }
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ):Container():
                      controller.value1? Padding(
                        padding: EdgeInsets.only(left: 0.04 * width, right: 0.04 * width),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringAll', Colors.black,'M'),
                                Checkbox(
                                  value: controller.valueAll,
                                  onChanged: (value) {
                                    if(controller.valuePlus==true ||controller.valueEquil==true||controller.valueMinus==true  )
                                    {
                                      controller.valuePlus = false;
                                      controller.valueEquil = false;
                                      controller.valueMinus = false;
                                      controller.valueAll = value!;
                                      controller.SetTypeValue='All';
                                      controller.update();
                                    }
                                    else{

                                      controller.valueAll = value!;
                                      controller.SetTypeValue='All';
                                      controller.update();
                                    }
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringHasQua', Colors.black,'M'),
                                Checkbox(
                                  value: controller.valuePlus,
                                  onChanged: (value) {
                                    if(controller.valueAll==true ||controller.valueEquil==true||controller.valueMinus==true  )
                                    {
                                      controller.valueAll = false;
                                      controller.valueEquil = false;
                                      controller.valueMinus = false;
                                      controller.valuePlus = value!;
                                      controller.SetTypeValue='Plus';
                                      controller.update();
                                    }
                                    else{

                                      controller.valuePlus = value!;
                                      controller.SetTypeValue='Plus';
                                      controller.update();
                                    }
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ThemeHelper().buildText(context,'StringHasNotQua', Colors.black,'M'),
                                Checkbox(
                                  value: controller.valueEquil,
                                  onChanged: (value) {
                                    if(controller.valueAll==true ||controller.valuePlus==true||controller.valueMinus==true  )
                                    {
                                      controller.valueAll = false;
                                      controller.valuePlus = false;
                                      controller.valueMinus = false;
                                      controller.valueEquil = value!;
                                      controller.SetTypeValue='Equil';
                                      controller.update();
                                    }
                                    else{

                                      controller.valueEquil = value!;
                                      controller.SetTypeValue='Equil';
                                      controller.update();
                                    }
                                    controller.update();
                                  },
                                  activeColor: AppColors.MainColor,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ) :Container(),
                      SizedBox(height: 0.002*height,),
                      Obx(() => controller.isloading.value == true
                            ? ThemeHelper().circularProgress()
                            : Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: MaterialButton(
                              onPressed: ()  {
                                controller.value=false;
                                controller.update();
                                controller.isloading.value=true;
                                if(controller.TypeScreen=='Inv_Mov_Rep'){
                                  controller.GET_SYS_DOC_D(17);
                                  controller.FetchGet_Inv_Mov_RepPdfData(17);
                                  Timer(const Duration(seconds: 3), () async {
                                    if(STO_MOV_D_List.isEmpty){
                                      Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                                          backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
                                          colorText:Colors.white,
                                          isDismissible: true,
                                          dismissDirection: DismissDirection.horizontal,
                                          forwardAnimationCurve: Curves.easeOutBack);
                                      controller.isloading.value=false;
                                    }else {
                                      final pdfFile = await Pdf.InventoryReport_Pdf(
                                        controller.SelectFromDays.toString().substring(0, 10),
                                        controller.SelectToDays.toString().substring(0, 10),
                                        controller.SelectDataFromBIID,
                                        controller.SelectDataToBIID,
                                        controller.SONA,
                                        controller.SONE,
                                        controller.SORN,
                                        controller.SOLN,
                                        controller.SDDSA,
                                        controller.SMDED,
                                        'StringInvc_Mov_Rep',
                                        controller.SUM_SMDNO,
                                        controller.countMINO,
                                        controller.Minus,
                                        controller.plus,
                                        controller.SUM_SMDDF,
                                        controller.Equil,
                                        controller.P_PR_REP,
                                        LoginController().SUNA,
                                      );
                                      PdfPakage.openFile(pdfFile);
                                      controller.isloading.value=false;
                                    }
                                  });
                                }
                            
                                else if (controller.TypeScreen=='Mat_Mov_Rep'){
                                  controller.GET_SYS_DOC_D(17);
                                  controller.FetchGet_Mat_Mov_RepPdfData();
                                  Timer(const Duration(seconds: 5), () async {
                                    if(STO_MOV_D_List.isEmpty){
                                      Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                                          backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
                                          colorText:Colors.white,
                                          isDismissible: true,
                                          dismissDirection: DismissDirection.horizontal,
                                          forwardAnimationCurve: Curves.easeOutBack);
                                      controller.isloading.value=false;
                                    }else {
                                      final pdfFile = await Pdf.MAT_MOVReport_Pdf(
                                        controller.SelectFromDays.toString().substring(0,10),
                                        controller.SelectToDays.toString().substring(0,10),
                                        controller.SelectDataFromBIID,
                                        controller.SelectDataToBIID,
                                        controller.SONA,
                                        controller.SONE,
                                        controller.SORN,
                                        controller.SOLN,
                                        controller.SDDSA,
                                        controller.SMDED,
                                        'Mat_Mov_Rep',
                                        controller.SUM_SMDNO,
                                        controller.countMINO,
                                        controller.Minus,
                                        controller.plus,
                                        controller.SUM_SMDDF,
                                        controller.Equil,
                                        LoginController().SUNA,
                                      );
                                      PdfPakage.openFile(pdfFile);
                                      controller.isloading.value=false;
                                    }
                                  });
                                }
                                else if(controller.TypeScreen=='Incoming_Store_Rep'){
                                  if(controller.SelectDataSMKID==null){
                                    Get.snackbar('StringMestitle'.tr, 'StringChooseTheType'.tr,
                                        backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                        colorText:Colors.white,
                                        isDismissible: true,
                                        dismissDirection: DismissDirection.horizontal,
                                        forwardAnimationCurve: Curves.easeOutBack);
                                    controller.isloading.value=false;
                                  }
                                  else{
                                    controller.GET_SYS_DOC_D(int.parse(controller.SelectDataSMKID.toString()));
                                    controller.FetchGet_Inv_Mov_RepPdfData(int.parse(controller.SelectDataSMKID.toString()));
                                    Timer(const Duration(seconds: 3), () async {
                                      if(STO_MOV_D_List.isEmpty){
                                        Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                                            backgroundColor: Colors.red, icon: Icon(Icons.error,color:Colors.white),
                                            colorText:Colors.white,
                                            isDismissible: true,
                                            dismissDirection: DismissDirection.horizontal,
                                            forwardAnimationCurve: Curves.easeOutBack);
                                        controller.isloading.value=false;
                                      }
                                      else {
                                        final pdfFile = await Pdf.InventoryReport_Pdf(
                                          controller.SelectFromDays.toString().substring(0,10),
                                          controller.SelectToDays.toString().substring(0,10),
                                          controller.SelectDataFromBIID,
                                          controller.SelectDataToBIID,
                                          controller.SONA,
                                          controller.SONE,
                                          controller.SORN,
                                          controller.SOLN,
                                          controller.SDDSA,
                                          controller.SMDED,
                                          controller.SelectDataSMKID=='1'?'Item_In':
                                          controller.SelectDataSMKID=='3'?'Item_Out':
                                          controller.SelectDataSMKID=='13'?'Transfer':'Transfer_Request',
                                          controller.SUM_SMDNO,
                                          controller.countMINO,
                                          controller.Minus,
                                          controller.plus,
                                          controller.SUM_SMDDF,
                                          controller.Equil,
                                          controller.P_PR_REP,
                                          LoginController().SUNA,
                                        );
                                        PdfPakage.openFile(pdfFile);
                                        controller.isloading.value=false;
                                      }
                                    });
                                  }
                            
                                }
                              },
                              child: Container(
                                height: 0.05 * height,
                                width: 2 * width,
                                alignment: Alignment.center,
                                child:  ThemeHelper().buildText(context,'StringPrint', Colors.white,'L'),
                            
                                decoration: BoxDecoration(
                                    color: AppColors.MainColor,
                                    borderRadius:
                                    BorderRadius.circular(0.02 * height)),
                              )),
                        ),
                      ),
                            
                    ],
                  ),
                ),
              )),
        ));
  }
}
