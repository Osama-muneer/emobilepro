import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Reports/controllers/Cus_Bal_Rep_Controller.dart';
import '../../../Setting/models/acc_acc.dart';
import '../../../Setting/models/acc_cas.dart';
import '../../../Setting/models/acc_cos.dart';
import '../../../Setting/models/acc_mov_k.dart';
import '../../../Setting/models/bil_are.dart';
import '../../../Setting/models/bil_cus.dart';
import '../../../Setting/models/bil_cus_t.dart';
import '../../../Setting/models/bil_dis.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/cou_wrd.dart';
import '../../../Setting/models/list_value.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Setting/models/sys_usr.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/report_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

class Cus_Bal_Rep_View extends StatefulWidget {
  @override
  State<Cus_Bal_Rep_View> createState() => _Cus_Bal_RepState();
}

class _Cus_Bal_RepState extends State<Cus_Bal_Rep_View> {
  final Cus_Bal_Rep_Controller controller = Get.find();

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringBIID_FlableText'.tr),
            isExpanded: true,
            hint:  ThemeHelper().buildText(context,'StringFromBrach', Colors.grey,'S'),
            value: controller.SelectDataFromBIID,
            style: const TextStyle(fontFamily: 'Hacen', color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            onChanged: (value) {
              controller.SelectDataFromBIID = value.toString();
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
            decoration: ThemeHelper().InputDecorationDropDown('StringBIID_TlableText'.tr),
            isExpanded: true,
            hint:  ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
            value: controller.SelectDataToBIID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            onChanged: (value) {
              controller.SelectDataToBIID = value.toString();
            },
          );
        });
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownSYS_CUR_FBuilder() {
    return  GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringSCID_F'.tr,);
          }
          return DropdownButtonFormField2(
            decoration:ThemeHelper().InputDecorationDropDown(controller.TYPE_REP==4?'StringSCIDlableText'.tr:'StringSCID_F'.tr),
            isExpanded: true,
            hint: Text(
              controller.TYPE_REP==4?'StringSCIDlableText'.tr: 'StringSCID_F'.tr,
              style: ThemeHelper().buildTextStyle(context, Colors.grey,'M'),
            ),
            value: controller.SelectDataSCID_F,
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              onTap: (){
                controller.SelectDataSCNA_F=item.SCNA_D.toString();
              },
              value: item.SCID.toString(),
              child: Text(
                "${item.SCNA_D.toString()} ",
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            validator: (v) {
              if (v == null) {
                return 'StringSCID_F'.tr;
              };
                 return null;
            },
            onChanged: (value) {
              controller.SelectDataSCID_F = value.toString();
            },
          );
        })));
  }
  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CUR_TBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringSCID_T'.tr,);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringSCID_T'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringSCID_T', Colors.grey,'S'),
            value: controller.SelectDataSCID_T,
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              onTap: (){
                controller.SelectDataSCNA_T=item.SCNA_D.toString();
              },
              value: item.SCID.toString(),
              child: Text(
                "${item.SCNA_D.toString()} ",
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
              controller.SelectDataSCID_T = value.toString();
            },
          );
        });
  }
  FutureBuilder<List<Bil_Cus_Local>> DropdownBIL_CUS_FBuilder() {
    return FutureBuilder<List<Bil_Cus_Local>>(
        future: GET_BIL_CUS(),
        builder: (BuildContext context, AsyncSnapshot<List<Bil_Cus_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringBCID_F',
            );
          }
          return DropdownButtonFormField2(
            decoration:ThemeHelper().InputDecorationDropDown('StringBCID_F'.tr),
            isDense: true,
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringBCID_F', Colors.grey,'S'),
            iconStyleData: IconStyleData(
              icon:  const Icon(
                Icons.arrow_drop_down,
                color: Colors.black45,
              )
            ),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              onTap: () {
                 controller.SelectDataAANO_F = item.AANO.toString();
                 controller.SelectDataBCNA_F = item.BCNA_D.toString();
               },
              value: "${item.BCID.toString() + " +++ " + item.BCNA_D.toString()}",
              child: Text(
                item.BCNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            value: controller.SelectDataBCID_F,
            onChanged: (value) {
              controller.SelectDataBCID_F = value.toString();
              controller.update();
              print('SelectDataBCID_F');
              print(controller.SelectDataBCID_F);
              //  });
            },
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
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
                      hintText: 'StringSearch_for_BCID'.tr,
                      hintStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (DropdownMenuItem item,searchValue) {
                  // print(controller.TextEditingSercheController.text);
                  return (item.value.toString().toLowerCase().contains(searchValue.toLowerCase()));
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
  FutureBuilder<List<Bil_Cus_Local>> DropdownBIL_CUS_TBuilder() {
    return FutureBuilder<List<Bil_Cus_Local>>(
        future: GET_BIL_CUS(),
        builder: (BuildContext context, AsyncSnapshot<List<Bil_Cus_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringBCID_T',
            );
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringBCID_T'.tr),
            isDense: true,
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringBCID_T', Colors.grey,'S'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              onTap: () {
                controller.BCNAController.text = item.BCNA.toString();
                controller.SelectDataAANO_T = item.AANO.toString();
                controller.GUIDC = item.GUID.toString();
                controller.SelectDataBCNA_T = item.BCNA_D.toString();
               },
              value: "${item.BCID.toString() + " +++ " + item.BCNA_D.toString()}",
              child: Text(
                item.BCNA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            value: controller.SelectDataBCID_T,
            onChanged: (value) {
              controller.SelectDataBCID_T = value.toString();
              controller.update();
              print('SelectDataBCID_T');
              print(controller.SelectDataBCID_T);
            },
            dropdownStyleData: const DropdownStyleData(
              maxHeight: 300,
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
                      hintText: 'StringSearch_for_BCID'.tr,
                      hintStyle:  ThemeHelper().buildTextStyle(context, Colors.grey,'S'),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
                searchMatchFn: (DropdownMenuItem item,searchValue) {
                  // print(controller.TextEditingSercheController.text);
                  return (item.value.toString().toLowerCase().contains(searchValue.toLowerCase()));
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
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBIL_CUS_TYPE_FBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Cus_T_Local>>(
            future: GET_BIL_CUS_T(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Cus_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringType_F',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringType_F'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringType_F', Colors.grey,'S'),
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataBCTNA_F=item.BCTNA_D.toString();
                  },
                  value: item.BCTID.toString(),
                  child: Text(
                    item.BCTNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                ))
                    .toList()
                    .obs,
                value: controller.SelectDataBCTID_F,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataBCTID_F = value as String;
                  });
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 300,
                ),
              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBIL_CUS_TYP_TEBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Cus_T_Local>>(
            future: GET_BIL_CUS_T(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Cus_T_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringType_T',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringType_T'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringType_T', Colors.grey,'S'),
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataBCTNA_T=item.BCTNA_D.toString();
                  },
                  value: item.BCTID.toString(),
                  child: Text(
                    item.BCTNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataBCTID_T,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataBCTID_T = value as String;
                  });
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 300,
                ),
              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBMST__FBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<List_Value>>(
            future: GET_LIST_VALUE('ST'),
            builder: (BuildContext context,
                AsyncSnapshot<List<List_Value>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringST_F',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringST_F'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringST_F', Colors.grey,'S'),
                value: controller.SelectBIST_F,
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectBISTD_F=item.LVNA_D.toString();
                  },
                  value: item.LVID.toString(),
                  child: Text(
                    item.LVNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  // Do something when changing the item if you want.
                  controller.SelectBIST_F=value.toString();
                  controller.update();
                },
              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBMST__TBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<List_Value>>(
            future: GET_LIST_VALUE('ST'),
            builder: (BuildContext context,
                AsyncSnapshot<List<List_Value>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringST_T',
                );
              }
              return DropdownButtonFormField2(
                decoration:  ThemeHelper().InputDecorationDropDown('StringST_T'.tr),
                isExpanded: true,
                hint:ThemeHelper().buildText(context,'StringST_T', Colors.grey,'S'),
                value: controller.SelectBIST_T,
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectBISTD_T=item.LVNA_D.toString();
                  },
                  value: item.LVID.toString(),
                  child: Text(
                    item.LVNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  // Do something when changing the item if you want.
                  controller.SelectBIST_T=value.toString();
                  controller.update();
                },
              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownCou_Wrd_FBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Cou_Wrd_Local>>(
            future: GET_COU_WRD(),
            builder: (BuildContext context, AsyncSnapshot<List<Cou_Wrd_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringCWID_F',);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringCWID_F'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCWID_F', Colors.grey,'S'),
                value: controller.SelectDataCWID2_F,
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataCWNA_F=item.CWNA_D.toString();
                  },
                  value: "${item.CWID.toString() + " +++ " + item.CWNA_D.toString()}",
                  // value: item.CWID.toString(),
                  child: Text(
                    item.CWNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataCWID2_F = value as String;
                    controller.SelectDataCWID_F = value.toString().split(" +++ ")[0];
                    // controller.SelectDataCTID = null;
                    // controller.SelectDataCTID2 = null;
                    // controller.SelectDataBAID2 = null;
                    // controller.SelectDataBAID = null;
                    print(controller.SelectDataCWID2_F);
                    print('controller.SelectDataCWID2_F');
                    controller.update();
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 50,
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
                        hintText: 'StringSearch_for_CWID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
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
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownCou_Wrd_TBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Cou_Wrd_Local>>(
            future: GET_COU_WRD(),
            builder: (BuildContext context, AsyncSnapshot<List<Cou_Wrd_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus,GETSTRING: 'StringCWID_T',);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringCWID_T'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCWID_T', Colors.grey,'S'),
                value: controller.SelectDataCWID2_T,
                style: const TextStyle(
                    fontFamily: 'Hacen',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataCWNA_T=item.CWNA_D.toString();
                  },
                  value: "${item.CWID.toString() + " +++ " + item.CWNA_D.toString()}",
                  // value: item.CWID.toString(),
                  child: Text(
                    item.CWNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataCWID2_T = value as String;
                    controller.SelectDataCWID_T = value.toString().split(" +++ ")[0];
                    // controller.SelectDataCTID = null;
                    // controller.SelectDataCTID2 = null;
                    // controller.SelectDataBAID2 = null;
                    // controller.SelectDataBAID = null;
                    print(controller.SelectDataCWID2_T);
                    print('controller.SelectDataCWID2_T');
                    controller.update();
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 50,
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
                        hintText: 'StringSearch_for_CWID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
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
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBIL_ARE_FBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Are_Local>>(
            future: GET_BIL_ARE_REP(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Are_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBAID_F',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringBAID_F'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringBAID_F', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataBANA_F=item.BANA_D.toString();
                  },
                  value: "${item.BAID.toString() + " +++ " + item.BANA_D.toString()}",
                  //  value: item.BAID.toString(),
                  child: Text(
                    item.BANA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                ))
                    .toList()
                    .obs,
                value: controller.SelectDataBAID2_F,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataBAID2_F = value as String;
                    controller.SelectDataBAID_F = value.toString().split(" +++ ")[0];
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 60,
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
                        hintText: 'StringSearch_for_BAID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
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
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },
              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBIL_ARE_TBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Are_Local>>(
            future: GET_BIL_ARE_REP(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Are_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBAID_T',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringBAID_T'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 200,
                ),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringBAID_T', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataBANA_T=item.BANA_D.toString();
                  },
                  value: "${item.BAID.toString() + " +++ " + item.BANA_D.toString()}",
                  //  value: item.BAID.toString(),
                  child: Text(
                    item.BANA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                ))
                    .toList()
                    .obs,
                value: controller.SelectDataBAID2_T,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataBAID2_T = value as String;
                    controller.SelectDataBAID_T = value.toString().split(" +++ ")[0];
                  });
                },
                dropdownSearchData: DropdownSearchData(
                  searchInnerWidgetHeight: 60,
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
                        hintText: 'StringSearch_for_BAID'.tr,
                        hintStyle: const TextStyle(fontSize: 12),
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
                ),
                //This to clear the search value when you close the menu
                onMenuStateChange: (isOpen) {
                  if (!isOpen) {
                    controller.TextEditingSercheController.clear();
                  }
                },

              );
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownACC_ACC_FBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Acc_Local>>(
            future: GET_ACC_ACC(controller.TYPE_REP.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Acc_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAANO_F',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringAANO_F'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_F', Colors.grey,'S'),
                value: controller.SelectDataAANO2_F,
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataAANO_F = item.AANO.toString();
                    controller.SelectDataBCNA_F = item.AANA_D.toString();
                  },
                  value: item.AANA_D.toString(),
                  child: Text(
                    item.AANA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (v){
                  controller.SelectDataAANO2_F=v.toString();
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
                          suffixIcon: IconButton(icon: const Icon(
                            Icons.clear,
                            size: 20,
                          ),
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
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownACC_ACC_TBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Acc_Local>>(
            future: GET_ACC_ACC(controller.TYPE_REP.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Acc_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringAANO_T',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringAANO_T'.tr),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringAANO_T', Colors.grey,'S'),
                value:  controller.SelectDataAANO2_T,
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataAANO_T = item.AANO.toString();
                    controller.SelectDataBCNA_T = item.AANA_D.toString();
                  },
                  value: item.AANA_D.toString(),
                  child: Text(
                    item.AANA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  setState(() {
                    controller.SelectDataAANO2_T=value.toString();
                    controller.update();
                  });
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
                          suffixIcon: IconButton(icon: const Icon(
                            Icons.clear,
                            size: 20,
                          ),
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
            })));
  }
  FutureBuilder<List<Acc_Mov_K_Local>> DropdownFrom_ACC_MOV_KBuilder() {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Acc_Mov_K_Local>>(
        future: GET_ACC_MOV_K_REP(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Mov_K_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringType_F',
            );
          }
          return Padding(padding: EdgeInsets.only(left: 0.015 * width),
              child:DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType_F'.tr}"),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringType_F', Colors.grey,'S'),
                value: controller.AMKID_F,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 300,
                ),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  value: item.AMKID.toString(),
                  child: Text(
                    item.AMKNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),)).toList().obs,
                onChanged: (value) {
                  controller.AMKID_F = value.toString();
                  controller.update();
                },
              ));
        });
  }
  FutureBuilder<List<Acc_Mov_K_Local>> DropdownTo_ACC_MOV_KBuilder() {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Acc_Mov_K_Local>>(
        future: GET_ACC_MOV_K_REP(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Acc_Mov_K_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringType_T',
            );
          }
          return Padding(padding: EdgeInsets.only(right: 0.015 * width),
              child:DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringType_T'.tr}"),
                isExpanded: true,
                hint:ThemeHelper().buildText(context,'StringType_T', Colors.grey,'S'),
                value: controller.AMKID_T,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 300,
                ),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  value: item.AMKID.toString(),
                  child: Text(
                    item.AMKNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),)).toList().obs,
                onChanged: (value) {
                  controller.AMKID_T = value.toString();
                  controller.update();
                },
              ));
        });
  }
  FutureBuilder<List<Sys_Usr_Local>> DropdownTo_SYS_USRBuilder() {
    double width= MediaQuery.of(context).size.width;
    return FutureBuilder<List<Sys_Usr_Local>>(
        future: GET_SYS_USR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Usr_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringUserName',
            );
          }
          return Padding(padding: EdgeInsets.only(right: 0.015 * width),
              child:DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown(" ${'StringUserName'.tr}"),
                isExpanded: true,
                hint:ThemeHelper().buildText(context,'StringUserName', Colors.grey,'S'),
                value: controller.SUID_V,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 300,
                ),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SUID.toString(),
                  child: Text(
                    item.SUNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),)).toList().obs,
                onChanged: (value) {
                  controller.SUID_V = value.toString();
                  controller.update();
                },
              ));
        });
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownACC_CASBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Cas_Local>>(
            future: GET_ACC_CAS_REP(controller.SelectDataFromBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Cas_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringCashier',
                );
              }
              return DropdownButtonFormField2(
                decoration:  ThemeHelper().InputDecorationDropDown('StringCashier'.tr),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCashier', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.SelectDataACID_D=item.ACNA_D.toString();
                  },
                  value: item.ACID.toString(),
                  child: Text(
                    item.ACNA_D.toString(),
                    style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.SelectDataACID,
                onChanged: (value) {
                  controller.SelectDataACID = value as String;
                  controller.update();
                },
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 250,
                ),
              );
            })));
  }
  DropdownST_Builder_F() {
    return  DropdownButtonFormField2(
      decoration: ThemeHelper().InputDecorationDropDown('StringState'.tr),
      isExpanded: true,
      hint: ThemeHelper().buildText(context,'StringST_F', Colors.grey,'S'),
      value: controller.ST_F,
      style: const TextStyle(
          fontFamily: 'Hacen',
          color: Colors.black,
          fontWeight: FontWeight.bold),
      items: JosnStatusApproved.map((item) => DropdownMenuItem<String>(
        value: item['id'],
        child: Text(
          item['name'],
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
        ),
      )).toList().obs,
      onChanged: (value) {
        controller.ST_F = value.toString();
        controller.update();
      },
    );
  }
  DropdownST_Builder_T() {
    return  DropdownButtonFormField2(
      decoration: ThemeHelper().InputDecorationDropDown('StringState'.tr),
      isExpanded: true,
      hint: ThemeHelper().buildText(context,'StringST_T', Colors.grey,'S'),
      value: controller.ST_T,
      style: const TextStyle(
          fontFamily: 'Hacen',
          color: Colors.black,
          fontWeight: FontWeight.bold),
      items: JosnStatusApproved.map((item) => DropdownMenuItem<String>(
        value: item['id'],
        child: Text(
          item['name'],
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
        ),
      )).toList().obs,
      onChanged: (value) {
        controller.ST_T = value.toString();
        controller.update();
      },
    );
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBIL_DIS_FBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Dis_Local>>(
            future: GET_BIL_DIS(controller.SelectDataFromBIID.toString()),
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
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.BDID_F = item.BDID.toString();
                    controller.update();
                  },
                  value: item.BDNA.toString(),
                  child: Text(
                    item.BDNA.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.BDID2_F,
                onChanged: (value) {
                  controller.BDID2_F=value.toString();
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
            })));
  }
  GetBuilder<Cus_Bal_Rep_Controller> DropdownBIL_DIS_TBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Dis_Local>>(
            future: GET_BIL_DIS(controller.SelectDataFromBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Dis_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: 'StringCollector'.tr,);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringCollector'.tr),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCollector', Colors.grey,'S'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.BDID_T = item.BDID.toString();
                    controller.update();
                  },
                  value: item.BDNA.toString(),
                  child: Text(
                    item.BDNA.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                value: controller.BDID2_T,
                onChanged: (value) {
                  controller.BDID2_T=value.toString();
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
            })));
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
                item.ACNA_D.toString(),
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
  final List<Map> TYP_ORD = [
    {"id": '1', "name": 'StringAccount_NO'.tr},
    {"id": '2', "name": 'StringSCIDlableText'.tr},
    {"id": '3', "name": 'StringBAL_ACC'.tr},
  ].obs;
  GetBuilder<Cus_Bal_Rep_Controller> DropdownTYPE_TBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => DropdownButtonFormField2(
          decoration:  ThemeHelper().InputDecorationDropDown("StringOrderBy".tr),
          isExpanded: true,
          value: controller.TYPE_ORD,
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
          items: TYP_ORD.map((item) => DropdownMenuItem<String>(
            value: item['id'],
            child: Text(
              item['name'],
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            ),
          )).toList().obs,
          onChanged: (value) {
            controller.TYPE_ORD = value.toString();
            controller.update();
          },
        )));
  }
  final List<Map> TYP_ORD_L = [
    {"id": '1', "name": 'StringASC_DE1'.tr},
    {"id": '2', "name": 'StringASC_DE2'.tr},
  ].obs;
  GetBuilder<Cus_Bal_Rep_Controller> DropdownTYPE_ORDBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
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
  final List<Map> TYP_GRO_BY = [
    {"id": '1', "name": 'StringSCIDlableText'.tr},
    {"id": '2', "name": 'StringAANO'.tr},
  ].obs;
  GetBuilder<Cus_Bal_Rep_Controller> DropdownTYP_GRO_BYBuilder() {
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((controller) => DropdownButtonFormField2(
          decoration:  ThemeHelper().InputDecorationDropDown("StringGRO_BY".tr),
          isExpanded: true,
          value: controller.GRO_BY,
          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
          items: TYP_GRO_BY.map((item) => DropdownMenuItem<String>(
            value: item['id'],
            child: Text(
              item['name'],
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            ),
          )).toList().obs,
          onChanged: (value) {
            controller.GRO_BY = value.toString();
            controller.update();
          },
        )));
  }

  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<Cus_Bal_Rep_Controller>(
        init: Cus_Bal_Rep_Controller(),
        builder: ((value)=> Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.MainColor,
          iconTheme: IconThemeData(color: Colors.white),
          actions: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.cleaning_services,color: Colors.white),
                  onPressed: () {
                    controller.Clear_P();
                    controller.update();
                  },
                ),
              ],
            )
          ],
          title: Text(controller.TYPE_REP==1?'StringCus_Bal_Rep'.tr:controller.TYPE_REP==2?'StringSuppliers_Balances_Report'.tr:
          controller.TYPE_REP==4?'StringDaily_Treasury_Report'.tr:'StringAccounts_Balances_Report'.tr,
              style: ThemeHelper().buildTextStyle(context, AppColors.textColor,'L')),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width),
            child: Column(
              children: <Widget>[
            //    من فرع الى فرع
                Column(
                  children: [
                    SizedBox(height:  0.01 * height),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownBra_InfBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownBra_Inf_ToBuilder()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:  0.01 * height),
                    controller.TYPE_REP==4?
                    Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(  0.01 * height)),
                        child: DropdownACC_COSBuilder())
                        : Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(  0.01 * height)),
                        child: DropdownACC_ACC_FBuilder()),
                    SizedBox(height:  0.01 * height),
                    //من تاريخ الى تاريخ
                    controller.TYPE_REP==4?
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin:
                                  EdgeInsets.only(left: 0.01 * height),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          0.01 * width)),
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
                                  margin: EdgeInsets.only(right: 0.01 * height),
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
                    ) :
                    Container(
                        //margin: EdgeInsets.only(left:  0.01 * height,right:  0.01 * height),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(  0.01 * height)),
                        child: DropdownACC_ACC_TBuilder()),
                    SizedBox(height:  0.01 * height),
                    controller.TYPE_REP==4?
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('StringShowLast_Balance'.tr, style: ThemeHelper().buildTextStyle(context, AppColors.black,'M')),
                        Checkbox(
                          value: controller.Show_Last_Balance,
                          onChanged: (value) {
                            controller.Show_Last_Balance = value!;
                            controller.update();
                          },
                          activeColor: AppColors.MainColor,
                        ),
                      ],
                    ) :
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownSYS_CUR_FBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownSYS_CUR_TBuilder()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:  0.01 * height),
                    controller.TYPE_REP==4?Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownFrom_ACC_MOV_KBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownTo_ACC_MOV_KBuilder()
                          ),
                        ),
                      ],
                    ):
                    controller.TYPE_REP!=3?Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownBIL_CUS_TYPE_FBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownBIL_CUS_TYP_TEBuilder()
                          ),
                        ),
                      ],
                    ):
                    Container(),
                    controller.TYPE_REP!=3?SizedBox(height: 0.01 * height):SizedBox(height: 0,),
                    controller.TYPE_REP==4?
                    Container() :
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownBMST__FBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownBMST__TBuilder()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.01 * height),
                    controller.TYPE_REP==4?Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(  0.01 * height)),
                        child: DropdownACC_CASBuilder()):
                     controller.TYPE_REP==3 ?
                    Container() : Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownCou_Wrd_FBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height,),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownCou_Wrd_TBuilder()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.01 * height),
                    controller.TYPE_REP==4 || controller.TYPE_REP==3 ?
                    Container() :
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownBIL_ARE_FBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownBIL_ARE_TBuilder()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.01 * height),
                    controller.TYPE_REP==4 ?
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownST_Builder_F()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular( 0.01 * height)),
                              child: DropdownST_Builder_T()
                          ),
                        ),
                      ],
                    ) :
                    Container(),
                    controller.TYPE_REP==4?SizedBox(height:0.01 * height):Container(),
                    controller.TYPE_REP==4?Row(
                      children: [
                        Expanded(
                          child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownSYS_CUR_FBuilder()
                          ),
                        ),
                      ],
                    )
                        :Container(),
                    controller.TYPE_REP==4?
                    Container() :
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                             // margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownTYP_GRO_BYBuilder()
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height:0.01 * height),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(left:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownTYPE_TBuilder()
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(right:  0.01 * height),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(  0.01 * height)),
                              child: DropdownTYPE_ORDBuilder()
                          ),
                        ),
                      ],
                    ),
                    controller.TYPE_REP==4?
                        Container()
                        : Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text('String_Not_Bal'.tr, style: ThemeHelper().buildTextStyle(context, AppColors.black,'M')),
                            Checkbox(
                              value: controller.NOT_BAL,
                              onChanged: (value) {
                                controller.NOT_BAL = value!;
                                controller.update();
                              },
                              activeColor: AppColors.MainColor,
                            ),
                                                  ],
                                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text('StringSH_DA'.tr, style: ThemeHelper().buildTextStyle(context, AppColors.black,'M')),
                            Checkbox(
                              value: controller.SH_DA,
                              onChanged: (value) {
                                controller.SH_DA = value!;
                                controller.update();
                              },
                              activeColor: AppColors.MainColor,
                            ),
                                                  ],
                                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text('StringV_TEL'.tr, style: ThemeHelper().buildTextStyle(context, AppColors.black,'M')),
                            Checkbox(
                              value: controller.V_TEL,
                              onChanged: (value) {
                                controller.V_TEL = value!;
                                controller.update();
                              },
                              activeColor: AppColors.MainColor,
                            ),
                                                  ],
                                                ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                            Text('StringV_INV_NO'.tr, style: ThemeHelper().buildTextStyle(context, AppColors.black,'M')),
                            Checkbox(
                              value: controller.V_INV_NO,
                              onChanged: (value) {
                                controller.V_INV_NO = value!;
                                controller.update();
                              },
                              activeColor: AppColors.MainColor,
                            ),
                                                  ],
                                                ),
                          ],
                        ),
                  ],
                ),
                SizedBox(height: 0.10 * height,),
              ],
            )
          ),
        ),
          floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: MaterialButton(
            onPressed: ()  async {
              controller.TYPE_REP==4 ? controller.UPQR=1 : controller.UPQR=controller.UPQR;
              if(controller.UPQR==1 ) {
                EasyLoading.instance
                  ..displayDuration = const Duration(milliseconds: 2000)
                  ..indicatorType = EasyLoadingIndicatorType.fadingCircle
                  ..loadingStyle = EasyLoadingStyle.custom
                  ..indicatorSize = 50.0
                  ..radius = 10.0
                  ..progressColor = Colors.white
                  ..backgroundColor = Colors.green
                  ..indicatorColor = Colors.white
                  ..textColor = Colors.white
                  ..maskColor = Colors.blue.withOpacity(0.5)
                  ..userInteractions = true
                  ..dismissOnTap = false;
                EasyLoading.show();
                controller.TYPE_REP==4?
               await controller.GET_ACC_MOV_D_P(controller.SelectDataFromBIID.toString(),
                    controller.SelectDataToBIID.toString(),
                    controller.SelectFromDays.toString(),
                    controller.SelectToDays.toString(),
                    controller.SelectDataSCID_F.toString(),
                    controller.AMKID_F.toString(),
                    controller.AMKID_T.toString(),
                    controller.SelectDataACNO.toString(),
                    controller.SelectDataACID.toString(),
                    controller.ST_F.toString(),
                    controller.ST_T.toString()) :
                await controller.GET_BIL_ACC_D_P(
                    controller.SelectDataFromBIID.toString(),
                    controller.SelectDataToBIID.toString(),
                    controller.SelectDataSCID_F.toString(),
                    controller.SelectDataSCID_T.toString(),
                    controller.SelectDataAANO_F.toString(),
                    controller.SelectDataAANO_T.toString(),
                    controller.SelectDataBCTID_F.toString(),
                    controller.SelectDataBCTID_T.toString(),
                    controller.SelectBIST_F.toString(),
                    controller.SelectBIST_T.toString(),
                    controller.SelectDataCWID_F.toString(),
                    controller.SelectDataCWID_T.toString(),
                    controller.SelectDataBAID_F.toString(),
                    controller.SelectDataBAID_T.toString());
                // Timer(const Duration(seconds: 5), () async {
                //   if (controller.BAL_ACC_C.isEmpty) {
                //     Get.snackbar('StringNo_Data_Rep'.tr, 'StringChk_No_Data'.tr,
                //         backgroundColor: Colors.red,
                //         icon: const Icon(Icons.error, color: Colors.white),
                //         colorText: Colors.white,
                //         isDismissible: true,
                //         dismissDirection: DismissDirection.horizontal,
                //         forwardAnimationCurve: Curves.easeOutBack);
                //     controller.isloading.value = false;
                //     EasyLoading.dismiss();
                //   }
                //   else {
                //     final pdfFile = await Pdf.Customers_Balances_Pdf(
                //         controller.SelectDataFromBINA.toString(),
                //         controller.SelectDataToBINA.toString(),
                //         controller.SelectDataSCNA_F.toString(),
                //         controller.SelectDataSCNA_T.toString(),
                //         controller.SelectDataBCNA_F.toString(),
                //         controller.SelectDataBCNA_T.toString()=='null'?
                //         controller.SelectDataBCNA_F.toString():
                //         controller.SelectDataBCNA_T.toString(),
                //         controller.SelectDataBCTNA_F.toString(),
                //         controller.SelectDataBCTNA_T.toString(),
                //         controller.SelectBISTD_F.toString(),
                //         controller.SelectBISTD_T.toString(),
                //         controller.SelectDataCWNA_F.toString(),
                //         controller.SelectDataCWNA_T.toString(),
                //         controller.SelectDataBANA_F.toString(),
                //         controller.SelectDataBANA_T.toString(),
                //         LoginController().BINA.toString(),
                //         controller.SONA.toString(),
                //         controller.SONE.toString(),
                //         controller.SORN.toString(),
                //         controller.SOLN.toString(),
                //         controller.TYPE_REP==1?'Cus_Bal': controller.TYPE_REP==2?'Bal_Bal':'Acc_Bal',
                //         LoginController().SUNA,
                //         controller.SDDDA.toString(),
                //         controller.SDDSA.toString(),
                //         controller.SUM_BACBMD,
                //         controller.SUM_BACBDA,
                //         controller.SUM_BACBA,
                //         controller.BAL_ACC_C);
                //     PdfPakage.openFile(pdfFile!);
                //     controller.isloading.value = false;
                //     EasyLoading.dismiss();
                //   }
                // });
              }else{
                Get.snackbar('StringBal_Rep_UPPR'.tr, 'String_CHK_Bal_Rep_UPPR'.tr,
                    backgroundColor: Colors.red, icon: const Icon(Icons.error,color:Colors.white),
                    colorText:Colors.white,
                    isDismissible: true,
                    dismissDirection: DismissDirection.horizontal,
                    forwardAnimationCurve: Curves.easeOutBack);
              }
            },
            child: Container(
              height: 0.05 * height,
              width: 2 * width,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: AppColors.MainColor,
                  borderRadius: BorderRadius.circular(0.03 * width)),
              child: Text(
                  'StringPrint'.tr,
                  style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
              ),
            ),
            ),)));
  }

}
