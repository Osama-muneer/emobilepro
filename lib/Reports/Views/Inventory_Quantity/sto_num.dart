import 'package:dropdown_button2/dropdown_button2.dart';
import '../../../Reports/controllers/sto_num_controller.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/mat_gro.dart';
import '../../../Setting/models/mat_inf.dart';
import '../../../Setting/models/sto_inf.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/setting_db.dart';
import '../../../database/sto_num_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Sto_Num_View extends StatefulWidget {
  @override
  State<Sto_Num_View> createState() => _Sto_Num_ViewState();
}

class _Sto_Num_ViewState extends State<Sto_Num_View> {
  final Sto_NumController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<Sto_NumController>(
        init: Sto_NumController(),
        builder: ((controller) {
          return Scaffold(
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
              title: Text('StringInventoryQuantities'.tr,
                  style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),),
              centerTitle: true,
            ),
            body: SingleChildScrollView(
              child: Form(
                key: controller.abcKey,
                child: Container(
                  padding: EdgeInsets.only(left: 0.03 * width, right: 0.03 * width),
                  child: Column(
                    children: [
                      SizedBox(height: 0.015 * height),
                      DropdownBRA_INF(),
                      SizedBox(height: 0.015 * height),
                      DropdownSto_InfBuilder(),
                      SizedBox(height: 0.015 * height),
                      DropdownMAT_GRO(),
                      SizedBox(height: 0.015 * height),
                      DropdownMAT_INF(),
                      SizedBox(height: 0.015 * height),
                      DropdownMAT_INF_TO(),
                      SizedBox(height: 0.015 * height),
                      DropdownTYPE_TBuilder(),
                      SizedBox(height: 0.015 * height),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemeHelper().buildText(context,'StringNot_Quantities', Colors.black,'M'),
                          Checkbox(
                            value: controller.NOT_Quantities,
                            onChanged: (value) {
                              controller.NOT_Quantities = value!;
                              controller.update();
                            },
                            activeColor: AppColors.MainColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.001 * height),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          ThemeHelper().buildText(context,'StringSTO_V_N', Colors.black,'M'),
                          Checkbox(
                            value: controller.STO_V_N,
                            onChanged: (value) {
                              controller.STO_V_N = value!;
                              controller.update();
                            },
                            activeColor: AppColors.MainColor,
                          ),
                        ],
                      ),
                      SizedBox(height: 0.011 * height),
                      Obx(
                        () => controller.isloading.value == true
                            ? ThemeHelper().circularProgress()
                            : Container(
                                decoration:
                                    ThemeHelper().buttonBoxDecoration(context),
                                child: MaterialButton(
                                    onPressed: () {
                                      controller.Search();
                                    },
                                    child: Container(
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                          color: AppColors.MainColor,
                                          borderRadius: BorderRadius.circular(
                                              0.02 * height)),
                                      child: ThemeHelper().buildText(context,'StringSEARCH', Colors.white,'L'),
                                      ),
                                    )),
                              ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }));
  }

  final List<Map> GET_CON_3 = [
    {"id": '1', "name": 'StringMgno'.tr},
    {"id": '2', "name": 'StringMINO'.tr},
    {"id": '3', "name": 'StringSIID'.tr},
    {"id": '4', "name": 'StringSMDED'.tr},
    {"id": '5', "name": 'StringSNNO'.tr},
    {"id": '6', "name":"${'StringMgno'.tr}-${'StringMINO'.tr}"},
  ].obs;

  GetBuilder<Sto_NumController> DropdownTYPE_TBuilder() {
    return GetBuilder<Sto_NumController>(
        init: Sto_NumController(),
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

  GetBuilder<Sto_NumController> DropdownSto_InfBuilder() {
    return GetBuilder<Sto_NumController>(
        init: Sto_NumController(),
        builder: ((controller) => FutureBuilder<List<Sto_Inf_Local>>(
            future: Get_STO_INF(1,controller.SelectDataBIID.toString(),''),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringStoch',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringSIIDlableText'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringStoch', Colors.grey,'S'),
                value: controller.SelectDataSIID,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SIID.toString(),
                  onTap: (){
                    controller.SelectDataSINA = item.SINA.toString();
                  },
                  child: Text(item.SINA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),)
                ).toList().obs,
                validator: (value) {
                  if (value == null) {
                    return 'StringStoch'.tr;
                  }
                  return null;
                },
                onChanged: (value) {
                  setState(() {
                    //Do something when changing the item if you want.
                    controller.SelectDataSIID = value.toString();
                    controller.SelectDataMGNO = null;
                    controller.SelectDataMGNA = null;
                    controller.SelectDataMGNO2 = null;
                    controller.SelectDataMINA = null;
                    controller.SelectDataMINA_TO = null;
                    controller.SelectDataMINO_TO = null;
                    controller.SelectDataMINO = null;
                    controller.update();
                  });
                },
              );
            })));
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBRA_INF() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future: GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: '',
            );
          }
          return GetBuilder<Sto_NumController>(
              init: Sto_NumController(),
              builder: ((value) => DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringBIID'.tr),
                    isExpanded: true,
                    hint: ThemeHelper().buildText(context,'StringBrach', Colors.grey,'S'),
                    value: controller.SelectDataBIID,
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    items: snapshot.data!
                        .map((item) => DropdownMenuItem<String>(
                              onTap: () {
                                setState(() {
                                  controller.SelectBINA = item.BINA_D.toString();
                                });
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
                        return 'اختار الفرع';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      //Do something when changing the item if you want.
                      if (controller.SelectDataSIID != null) {
                        controller.SelectDataSIID = null;
                      }
                          controller.SelectDataBIID = value.toString();
                          if (controller.SelectDataSIID != null) {
                            controller.SelectDataSIID = null;
                          } else {
                            controller.SelectDataSIID = null;
                          }
                            controller.update();
                    },
                  )));
        });
  }

  GetBuilder<Sto_NumController> DropdownMAT_GRO() {
    return GetBuilder<Sto_NumController>(
        init: Sto_NumController(),
        builder: ((controller) => FutureBuilder<List<Mat_Gro_Local>>(
            future: GET_MAT_GRO(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Mat_Gro_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringMgno',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringMgno'.tr),
                isDense: true,
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringMgno', Colors.grey,'S'),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                          onTap: () {
                            controller.SelectDataMGNO = item.MGNO.toString();
                            controller.SelectDataMGNO2 = item.MGNO.toString();
                            controller.SelectDataMGNA = item.MGNA_D.toString();
                            controller.SelectDataMINO = null;
                            controller.SelectDataMINA = null;
                            controller.SelectDataMINA_TO = null;
                            controller.SelectDataMINO_TO = null;
                            controller.update();
                          },
                          value: "${item.MGNO.toString() + " +++ " + item.MGNA_D.toString()}",
                          child: Text(
                            item.MGNA_D.toString(),
                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                          ),
                        ))
                    .toList()
                    .obs,
                value: controller.SelectDataMGNA,
                onChanged: (value) {
             setState(() {
            controller.SelectDataMINO = null;
            controller.SelectDataMINA = null;
            controller.SelectDataMINA_TO = null;
            controller.SelectDataMGNA = value.toString();
            controller.SelectDataMGNO = value.toString().split(" +++ ")[0];
            controller.SelectDataMINO = null;
            controller.SelectDataMINA = null;
            controller.SelectDataMINO_TO = null;
            controller.update();
             print('SelectDataMGNO');
             print(controller.SelectDataMGNO);
             print(controller.SelectDataMINA);
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
                          .contains(searchValue.toLowerCase()));
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

  GetBuilder<Sto_NumController> DropdownMAT_INF() {
    return GetBuilder<Sto_NumController>(
        init: Sto_NumController(),
        builder: ((controller) => FutureBuilder<List<Mat_Inf_Local>>(
            future: Get_Mat_Inf(controller.SelectDataMGNO.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Mat_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringFromItem',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringFromItem'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringFromItem', Colors.grey,'S'),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                          onTap: () {
                            controller.SelectDataMGNO2 = item.MGNO.toString();
                            controller.SelectDataMINO = item.MINO.toString();
                            controller.update();
                           // controller.SelectDataMINA = item.MINA_D.toString();
                          },
                          value: "${item.MINO.toString() + " +++ " + item.MINA_D.toString()}",
                          child: Text(
                            item.MINA_D.toString(),
                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                          ),
                        ))
                    .toList()
                    .obs,
                value: controller.SelectDataMINA,
                onChanged: (value) {
                  controller.SelectDataMINA = value.toString();
                  controller.SelectDataMINO = value.toString().split(" +++ ")[0];
                  controller.update();
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
            })));
  }

  GetBuilder<Sto_NumController> DropdownMAT_INF_TO() {
    return GetBuilder<Sto_NumController>(
        init: Sto_NumController(),
        builder: ((controller) => FutureBuilder<List<Mat_Inf_Local>>(
            future: Get_Mat_Inf(controller.SelectDataMGNO.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Mat_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringToItem',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringToItem'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringToItem', Colors.grey,'S'),
                dropdownStyleData: const DropdownStyleData(
                  maxHeight: 400,
                ),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                          onTap: () {
                            controller.SelectDataMGNO2 = item.MGNO.toString();
                            controller.SelectDataMINO_TO = item.MINO.toString();
                            controller.update();
                           // controller.SelectDataMINA = item.MINA_D.toString();
                          },
                          value: "${item.MINO.toString() + " +++ " + item.MINA_D.toString()}",
                          child: Text(
                            item.MINA_D.toString(),
                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                          ),
                        ))
                    .toList().obs,
                value: controller.SelectDataMINA_TO,
                onChanged: (value) {
                  controller.SelectDataMINA_TO = value.toString();
                //  controller.SelectDataMINO_TO = value.toString().split(" +++ ")[0];
                  controller.update();
                  print(value);
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
            })));
  }

}
