import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Reports/controllers/Inv_Rep_Controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/bil_mov_k.dart';
import '../../../Setting/models/bil_poi.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/mat_gro.dart';
import '../../../Setting/models/mat_inf.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/report_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Show_Inv_Rep extends StatefulWidget {
  @override
  State<Show_Inv_Rep> createState() => _Show_Inv_RepState();
}

class _Show_Inv_RepState extends State<Show_Inv_Rep> {
  final Inv_Rep_Controller controller = Get.find();

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA_INF(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringFromBrach'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIID_FlableText'.tr}"),
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

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_To() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA_INF(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringToBrach'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBIID_TlableText'.tr}"),
            isExpanded: true,
            hint:  ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
            value: controller.SelectDataToBIID,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: (){
                controller.SelectDataToBINA=item.BINA_D.toString();
              },
              value: item.BIID.toString(),
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
              controller.SelectDataToBIID = value.toString();
            },
          );
        });
  }

  FutureBuilder<List<Bil_Mov_K_Local>> DropdownBIL_MOV_K() {
    return FutureBuilder<List<Bil_Mov_K_Local>>(
        future:  GET_BIL_MOV_K(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bil_Mov_K_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringType'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringType', Colors.grey,'S'),
            value: snapshot.data!.any((item) =>
            item.BMKID.toString() == controller.SelectDataBMKID)
                ? controller.SelectDataBMKID : null,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.BMKID.toString(),
              child: Text(
                item.BMKNA_D.toString(),
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
              controller.SelectDataBMKID = value.toString();
              controller.value=false;
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
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringFromMgno'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringFromMgno'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChiceMGNO', Colors.grey,'S'),
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
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            value: controller.SelectDataFromMGNO,
            onChanged: (value) {
              print('value');
              controller.SelectDataFromMGNO = value.toString();
              controller.SelectDataFromMINO = null;
              controller.SelectDataToMINO = null;
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

  FutureBuilder<List<Mat_Gro_Local>> DropdownMat_Gro_To() {
    return FutureBuilder<List<Mat_Gro_Local>>(
        future: GET_MAT_GRO(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Gro_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringToMgno'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringToMgno'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChiceMGNO', Colors.grey,'S'),
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
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            value: controller.SelectDataToMGNO,
            onChanged: (value) {
              print('value');
              controller.SelectDataToMGNO = value.toString();
              controller.SelectDataFromMINO = null;
              controller.SelectDataToMINO = null;
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

  FutureBuilder<List<Mat_Inf_Local>> DropdownMAT_INF_From() {
    return FutureBuilder<List<Mat_Inf_Local>>(
        future:  Get_Mat_Inf_REP(controller.SelectDataFromMGNO.toString(),controller.SelectDataToMGNO.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringFromItem'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringFromItem'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringMINO', Colors.grey,'S'),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
              width: 200
            ),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: () {
                controller.SelectDataFromMINO = item.MINO.toString();
              },
              value: item.MINA_D.toString(),
              child: Text(
                item.MINA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            value: controller.SelectDataFromMINO,
            onChanged: (value) {
              print('value');
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
                      hintText: 'StringSearch_for_MINO'.tr,
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

  FutureBuilder<List<Mat_Inf_Local>> DropdownMAT_INF_To() {
    return FutureBuilder<List<Mat_Inf_Local>>(
        future: Get_Mat_Inf_REP(controller.SelectDataFromMGNO.toString(),controller.SelectDataToMGNO.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Mat_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringToItem'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringToItem'.tr}"),
            isExpanded: true,
            hint:  ThemeHelper().buildText(context,'StringMINO', Colors.grey,'S'),
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
              width: 200
            ),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              onTap: () {
                controller.SelectDataToMINO = item.MINO.toString();
              },
              value: item.MINA_D.toString(),
              child: Text(
                item.MINA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            value: controller.SelectDataToMINO,
            onChanged: (value) {
              print('value');
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
                      hintText: 'StringSearch_for_MINO'.tr,
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

  FutureBuilder<List<Bil_Poi_Local>> DropdownBil_Poi_From() {
    return FutureBuilder<List<Bil_Poi_Local>>(
        future: GET_BIL_POI(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bil_Poi_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringBPID_FlableText'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBPID_FlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringBPID_FlableText', Colors.grey,'S'),
            value: controller.SelectDataFromBPID,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
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

  FutureBuilder<List<Bil_Poi_Local>> DropdownBil_Poi_To() {
    return FutureBuilder<List<Bil_Poi_Local>>(
        future: GET_BIL_POI(controller.SelectDataFromBIID.toString(),controller.SelectDataToBIID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bil_Poi_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING:  'StringBPID_TlableText'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringBPID_TlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringBPID_TlableText', Colors.grey,'S'),
            value: controller.SelectDataToBPID,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.BPID.toString(),
              child: Text(
                item.BPNA_D.toString(),
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
              controller.SelectDataToBPID = value.toString();
              controller.update();
            },
          );
        });
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CUR() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringSCIDlableText'.tr,);
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
                "${item.SCNA_D.toString()} ",
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

  FutureBuilder<List<Pay_Kin_Local>> DropdownPAY_KIN() {
    return FutureBuilder<List<Pay_Kin_Local>>(
        future: GET_PAY_KIN('1'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringPKIDlableText'.tr,);
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
              controller.PKID = value.toString();
            },
          );
        });
  }

  DropdownST_Builder() {
    return  DropdownButtonFormField2(
      decoration: ThemeHelper().InputDecorationDropDown(" ${'StringState'.tr}"),
      isExpanded: true,
      hint: ThemeHelper().buildText(context,'StringState', Colors.grey,'S'),
      value: controller.SelectDataST,
      style: const TextStyle(
          fontFamily: 'Hacen',
          color: Colors.black,
          fontWeight: FontWeight.bold),
      items: josnStatus.map((item) => DropdownMenuItem<String>(
        onTap: (){
        },
        value: item['id'],
        child: Text(
          item['name'],
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
        ),
      )).toList().obs,
      onChanged: (value) {
        controller.SelectDataST = value.toString();
        controller.update();
      },
    );
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.grey[200],
        appBar: AppBar(
          automaticallyImplyLeading:  STMID=='EORD'?false:true,
          backgroundColor: AppColors.MainColor,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.cleaning_services,color: Colors.white),
                  onPressed: () {
                    controller.clearData();
                    controller.update();
                  },
                ),
              ],
            )
          ],
          title: Text( STMID=='EORD'?'StringInv_Mov_Rep'.tr:
          controller.BMKID==3?'StringTotal_SalesReports'.tr:controller.BMKID==1?'StringTotal_PurchasesReports'.tr:
          controller.BMKID==101?'StringTotalItemReport'.tr:controller.BMKID==102?'StringDetailedItemReport'.tr:
          'StringInv_Mov_Rep'.tr, style: 
          ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: GetBuilder<Inv_Rep_Controller>(
          init: Inv_Rep_Controller(),
          builder: ((value)=>
              Padding(
                padding: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width,top: 7),
                child: Form(
                  child: ListView(
                    children: <Widget>[
                      //من فرع الى فرع
                      if(controller.BMKID==101 || controller.BMKID==102)
                      if(STMID!='COU') Container(
                          margin: EdgeInsets.only(left: 0.01 * height,right: 0.01 * height),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular( 0.02 * height)),
                          child:  DropdownBIL_MOV_K(),
                      ),
                      SizedBox(height: 0.01 * height,),
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(  0.02 * height)),
                                child: DropdownBra_Inf()
                            ),
                          ),
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular( 0.02 * height)),
                                child: DropdownBra_Inf_To()
                            ),
                          ),
                        ],
                      ),
                      //من تاريخ الى تاريخ
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 0.01 * height,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(
                                            0.02 * width)),
                                    child: Column(
                                      children: [
                                        Text((controller.SelectFromDays == null ? controller.SelectFromDays =
                                        controller.dateFromDays.toString().split(" ")[0] :
                                        controller.SelectFromDays.toString()).split(" ")[0],
                                          style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
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
                                    )),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(color: Colors.white,
                                        borderRadius: BorderRadius.circular(0.002* height)),
                                    child: Column(
                                      children: [
                                        Text(controller.SelectToDays == null
                                            ? controller.SelectToDays = controller.dateTimeToDays.toString().split(" ")[0]
                                            : controller.SelectToDays.toString().split(" ")[0],
                                          style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                        SizedBox(
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
                                    )),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 0.01 * height,),
                      controller.BMKID==11?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:0.01 * height),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(  0.02 * height)),
                                    child: DropdownBil_Poi_From()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * height)),
                                    child: DropdownBil_Poi_To()
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height:0.01 * height),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(  0.02 * height)),
                                    child: DropdownSYS_CUR()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * height)),
                                    child: DropdownPAY_KIN()
                                ),
                              ),
                            ],
                          ),
                        ],
                      ):
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:0.01 * height),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(  0.02 * height)),
                                    child: DropdownSYS_CUR()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * height)),
                                    child: DropdownPAY_KIN()
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height:0.02 * height),
                      controller.BMKID==101 || controller.BMKID==102?
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height:0.01 * height),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(  0.02 * height)),
                                    child: DropdownMat_Gro_From()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * height)),
                                    child: DropdownMat_Gro_To()
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 0.01 * height,),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(  0.02 * height)),
                                    child: DropdownMAT_INF_From()
                                ),
                              ),
                              Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(left:  0.01 * height,right: 0.01 * height),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular( 0.02 * height)),
                                    child: DropdownMAT_INF_To()
                                ),
                              ),
                            ],
                          ),
                        ],
                      ):
                      Container(),
                      SizedBox(height: 0.01 * height,),
                      Container(
                          margin: EdgeInsets.only(left: 0.01 * height,right: 0.01 * height),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular( 0.02 * height)),
                          child:  DropdownST_Builder(),
                      ),
                      SizedBox(height: 0.01 * height,),
                      Obx(() => controller.isloading.value == true
                            ? ThemeHelper().circularProgress()
                            : Container(
                          decoration: ThemeHelper().buttonBoxDecoration(context),
                          child: MaterialButton(
                              onPressed: ()  {
                                controller.BMKID!=101 && controller.BMKID!=102 ?
                                  controller.Fetch_GET_BIF_REP_PdfData():
                                  controller.GET_TotalDetailedItem_REP_P();
                                controller.BMKID!=101 && controller.BMKID!=102 ?
                                  Timer(const Duration(seconds: 5), () async {
                                    if(BIF_MOV_M_List.isEmpty || BIF_MOV_M_REP.isEmpty || BIF_MOV_M_REP2.isEmpty){
                                      Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                                          backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                          colorText:Colors.white,
                                          isDismissible: true,
                                          dismissDirection: DismissDirection.horizontal,
                                          forwardAnimationCurve: Curves.easeOutBack);
                                        controller.isloading.value=false;
                                    }else {
                                      final pdfFile = await Pdf.Total_Amount_of_Point_Pdf(
                                        controller.BMKID.toString(),
                                        controller.SelectFromDays.toString().substring(0, 10),
                                        controller.SelectToDays.toString().substring(0, 10),
                                        controller.SelectDataFromBIID.toString(),
                                        controller.SelectDataToBIID.toString(),
                                        LoginController().SUNA,
                                        controller.SONA
                                      );
                                      PdfPakage.openFile(pdfFile);
                                      controller.isloading.value=false;
                                    }
                                  }):
                                  Timer(const Duration(seconds: 5), () async {
                                  if(controller.SelectDataBMKID==null ){
                                    Get.snackbar('StringMestitle'.tr, 'StringChooseTheType'.tr,
                                        backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                        colorText:Colors.white,
                                        isDismissible: true,
                                        dismissDirection: DismissDirection.horizontal,
                                        forwardAnimationCurve: Curves.easeOutBack);
                                    controller.isloading.value=false;
                                  }
                                  else if(Bil_Mov_D.isEmpty ){
                                    Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                                        backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                                        colorText:Colors.white,
                                        isDismissible: true,
                                        dismissDirection: DismissDirection.horizontal,
                                        forwardAnimationCurve: Curves.easeOutBack);
                                    controller.isloading.value=false;
                                  }
                                  else {
                                    final pdfFile =  await Pdf.TotalDetailedItemReport_Pdf(
                                        controller.BMKID.toString(),
                                        controller.SelectDataBMKID.toString(),
                                        controller.SelectDataFromBINA.toString(),
                                        controller.SelectDataToBINA.toString(),
                                        controller.SDDSA, controller.SONA,
                                        controller.SONE,
                                        controller.SORN,
                                        controller.SOLN,
                                        LoginController().SUNA,
                                        controller.SelectFromDays.toString().substring(0,10),
                                        controller.SelectToDays.toString().substring(0,10),
                                        controller.SUMBMDNO,
                                        controller.SUMBMDMT);
                                    PdfPakage.openFile(pdfFile);
                                    controller.isloading.value=false;
                                  }
                                });
                              },
                              child: Container(
                                height: 0.05 * height,
                                width: 2 * width,
                                alignment: Alignment.center,
                                child: Text('StringPrint'.tr,
                                  style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
                                ),
                                decoration: BoxDecoration(
                                    color: AppColors.MainColor,
                                    borderRadius:
                                    BorderRadius.circular(0.01 * height)),
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
