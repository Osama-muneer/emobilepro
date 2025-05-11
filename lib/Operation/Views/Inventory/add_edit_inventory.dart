import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as UI;
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Setting/models/acc_acc.dart';
import '../../../Setting/models/acc_cos.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/sto_inf.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/inventory_db.dart';
import '../../../database/setting_db.dart';
import '../../Controllers/inventory_controller.dart';
import 'datagrid_inventory.dart';

class add_edit_inventory extends StatefulWidget {
  @override
  State<add_edit_inventory> createState() => _add_edit_inventoryState();
}

class _add_edit_inventoryState extends State<add_edit_inventory> {
  final InventoryController controller = Get.find();
  UI.TextDirection direction = UI.TextDirection.rtl;
  String _scanBarcode = 'Unknown';
  TextEditingController SelectDataMINA = TextEditingController();
  late search.SearchBar searchBar;
  void onSubmitted(String value) {
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  searchBarDemoHomeState() {
    searchBar = search.SearchBar(
        onChanged: (value) {
          controller.SER_MINA = value;
          setState(() {
            controller.CheckSearech = 1;
            DataGridPageInventory();
          });
        },
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        hintText: 'StringSer_MINA'.tr,
        onCleared: () {
          setState(() {
            controller.SER_MINA = '';
            DataGridPageInventory();
          });
        },
        onClosed: () {
          controller.SER_MINA = '';
          DataGridPageInventory();
          controller.CheckSearech = 1;
        });
  }

  void displayAddItems() {
    setState(() {
      controller.ClearSto_Mov_D_Data();
      controller.displayAddItemsWindo();
    });
  }

  Future<bool> onWillPop() async {
    final shouldPop;
    if ((controller.edit == true || controller.CheckBack == 0)) {
      if(controller.edit == true){
        controller.SMKID==17 || controller.SMKID==13 || controller.SMKID==131 || controller.SMKID==11 ?
        controller.SelectDataAANA==null:controller.SelectDataAANA=controller.SelectDataAANA;
        controller.SMKID==17 || controller.SMKID==13 || controller.SMKID==131 || controller.SMKID==11 ?
        controller.SelectDataAANA==null:controller.SelectDataAANO=controller.SelectDataAANO;
        UpdateSTO_MOV_M(
            Get.arguments, controller.SelectDataBIID.toString(), controller.SelectDataSIID.toString(),controller.SelectDataSIID_T.toString(),controller.SMMST,controller.SelectDataAANO.toString(),
            controller.SelectDataAANO.toString(),controller.SMMAM!,controller.SMKID==17?controller.SCID.toString():controller.SelectDataSCID.toString()
            ,controller.SCEX!,controller.roundDouble(controller.SMMAM!  * controller.SCEX!, 3),controller.SMMINController.text,LoginController().SUID, DateFormat('dd-MM-yyyy HH:m').format(DateTime.now()),
            LoginController().DeviceName,controller.SMKID==17 ? controller.P_COS_SEQ=='1' ? controller.SelectDataACNO.toString() : '' : controller.SelectDataACNO.toString());
        updateSYST(Get.arguments,controller.SMMST);
      }
      if (controller.CheckSearech == 1) {
        controller.CheckSearech = 0;
        controller.SER_MINA = '';
        DataGridPageInventory();
        controller.update();
        return true;
      }
      else {
        Navigator.of(context).pop(false);
        controller.GETSTO_MOV_M_P('DateNow');
        shouldPop = await Get.toNamed('/Inventory');
      }

    } else {
      if (controller.CheckSearech == 1) {
        controller.CheckSearech = 0;
        controller.SER_MINA = '';
        DataGridPageInventory();
        controller.update();
        return true;
      } else {
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
            bool isValid = controller.delete_STO_MOV_M(null, 1);
            if (isValid) {
              Get.offAndToNamed('/Inventory');
            }
          },
        );
      }
    }

    return shouldPop ?? false;
  }

  @override
  void initState() {
    // TODO: implement initState
    searchBarDemoHomeState();
    super.initState();
  }

  static const MaterialColor buttonTextColor = MaterialColor(
    0xFFEF5350,
    <int, Color>{
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
      initialDate: controller.dateTimeDays,
      firstDate: DateTime(2022, 5),
      lastDate: DateTime(2050),
      builder: (context, child) {
        return   Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
          ),
          child: child!,
        );
      },);
    setState(() {
      if (picked != null) {
        final difference = controller.dateTimeDays2.difference(picked).inHours;
        final difference2 = controller.dateTimeDays2.difference(picked).inDays;
        print('difference2');
        controller.update();
        print(difference2);
        print(difference);
        if (difference >= 0 && difference2 < 20) {
          controller.dateTimeDays = picked;
          controller.SelectDays = DateFormat('dd-MM-yyyy HH:m').format(controller.dateTimeDays).toString().split(" ")[0];
          controller.SMMRD = DateFormat('dd-MM-yyyy').format(controller.dateTimeDays).toString().split(" ")[0];
          controller.update();
        } else {
          Fluttertoast.showToast(
              msg: "StringCHK_SMMDO".tr,
              textColor: Colors.white,
              backgroundColor: Colors.redAccent);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: GetBuilder<InventoryController>(
          init: InventoryController(),
          builder: ((controller) =>
              Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: searchBar.build(context),
            body: Column(children: [
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
                            child: DropdownBra_InfBuilder()),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4.4,
                          child: IgnorePointer(
                            ignoring: controller.Date_of_Insert == '1' ? true
                                : controller.Date_of_Insert == '4' && controller.Allow_to_Inserted_Date != 1
                                ? true : false,
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  selectDateFromDays(context);
                                });
                              },
                              child: Text((controller.SelectDays ?? (controller.SelectDays = controller.selectedDatesercher.toString().split(" ")[0])),
                                  style:   ThemeHelper().buildTextStyle(context, Colors.black,'M')
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    controller.SMKID==131?
                    SizedBox(height: 0.01 * height):
                    Container(),
                    controller.SMKID==131?
                    DropdownBra_Inf_TBuilder():
                    Container(),
                    SizedBox(height: 0.01 * height),
                    controller.SMKID==17?
                    DropdownSto_InfBuilder():
                    controller.SMKID==11 ? DropdownSto_Inf_TBuilder(controller.SMKID) : Container(),
                    SizedBox(height: 0.01 * height),
                    controller.SMKID==3 || controller.SMKID==1 || controller.SMKID==13 || controller.SMKID==0 || controller.SMKID==131?
                    Column(
                      children: [
                        controller.SMKID==13 || controller.SMKID==131?
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                                width: MediaQuery.of(context).size.width * 0.47,
                                child: DropdownSto_Inf_FBuilder()),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.47,
                                child: DropdownSto_Inf_TBuilder(controller.SMKID)),
                          ],
                        ):
                        Column(children: [
                          DropdownACC_ACCBuilder(),
                          SizedBox(height: 0.01 * height),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.47,
                                  child: DropdownSto_InfBuilder()),
                              Container(
                                  width: MediaQuery.of(context).size.width * 0.47,
                                  child: DropdownSYS_CURBuilder()),
                            ],
                          ),
                          SizedBox(height: 0.01 * height),
                          controller.SMKID==0? Container():
                          TextFormField(
                            style: TextStyle(fontWeight: FontWeight.bold,fontSize:  12),
                            controller: controller.SMMREController,
                            decoration: ThemeHelper().InputDecorationDropDown('StringBMMNO'.tr),
                          ),
                        ],),
                        SizedBox(height: 0.01 * height),
                        controller.SMKID==0 ? Container() :
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width * 0.47,
                              child: TextField(
                                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                controller: controller.SMMCNController,
                                decoration: ThemeHelper().InputDecorationDropDown('StringSMMCN'.tr),
                              ),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.47,
                              child: TextField(
                                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                controller: controller.SMMDRController,
                                decoration: ThemeHelper().InputDecorationDropDown('StringSMMDR'.tr),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(height: 0.01 * height),
                      ],
                    ): Container(),
                    Column(children: [
                      ((controller.P_COSM!='1') || (controller.P_COS_SEQ=='2' && controller.P_COSS=='5' ))
                          ? Container() :  DropdownACC_COSBuilder(),
                      Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                              controller: controller.SMMINController,
                              decoration: ThemeHelper().InputDecorationDropDown('StringDetails'.tr),
                            ),
                          ),
                          StteingController().Type_Inventory=='1' &&  controller.SMKID==17 ?
                          IconButton(onPressed: (){
                            if (controller.SelectDataSIID == null) {
                              Fluttertoast.showToast(
                                  msg: 'StringStoch'.tr,
                                  textColor: Colors.white,
                                  backgroundColor: Colors.red);
                            } else {
                              if(controller.CheckBack==0 && controller.edit==false){
                                setState(() {
                                  controller.GET_DownLoad_Sto_Mov_D();
                                  controller.DataGrid();
                                  controller.update();
                                });
                              }
                            }
                          },
                              icon: Icon(Icons.download_outlined,size: 30,)):
                          IconButton(
                              icon: Icon(
                                Icons.add_circle,color: AppColors.MainColor, size: 0.05 * height,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (controller.SMKID==17 && controller.SelectDataSIID == null) {
                                                    Fluttertoast.showToast(
                                                        msg: 'StringStoch'.tr,
                                                        textColor: Colors.white,
                                                        backgroundColor: Colors.red);
                                                  }
                                  else if (controller.SMKID==13 && controller.SelectDataSIID_F == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringF_SIID_ERR'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else if (controller.SMKID==13  && controller.SelectDataSIID_T == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringT_SIID_ERR'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else if (controller.SelectDataAANO== null && (controller.SMKID==0 || controller.SMKID==3 || controller.SMKID==1)  ) {Fluttertoast.showToast(
                                        msg: 'StringvalidateAANO'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red); }
                                  else if (controller.SMKID==13 && controller.SelectDataSCID == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringChi_currency'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else   if (controller.SMKID==131 && controller.SelectDataBIID_T == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringERR_BIID_T'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else if ((controller.SMKID==11  || controller.SMKID==131) && controller.SelectDataSIID_F == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringF_SIID_ERR'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }
                                  else if ((controller.SMKID==11  || controller.SMKID==131) && controller.SelectDataSIID_T == null) {
                                    Fluttertoast.showToast(
                                        msg: 'StringT_SIID_ERR'.tr,
                                        textColor: Colors.white,
                                        backgroundColor: Colors.red);
                                  }  else {
                                    controller.fetchAutoCompleteData();
                                    controller.TextButton_T = 'StringAdd'.tr;
                                    displayAddItems();
                                  }
                                });
                                // buildAlert(context).show();
                              }),
                        ],
                      )
                    ],),
                    SizedBox(height: 0.01 * height),
                  ],
                ),
              ),
              Expanded(
                child: DataGridPageInventory(),
              ),
            ]),
            bottomNavigationBar: GetBuilder<InventoryController>(
                init: InventoryController(),
                builder: ((value) =>Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text("${ 'StrinCount_SMDFN'.tr}  ${controller.CountController.text}",
                          style: ThemeHelper().buildTextStyle(context, AppColors.black,'M')),
                      Text("${controller.SMKID==17 || controller.SMKID==11 ? 'StrinCount_RECODE'.tr:'StrinBCMAM'.tr}  ${controller.SMKID==17 || controller.SMKID==11?controller.CountRecodeController.text:controller.formatter.format(controller.SMMAMTOT).toString()}",
                          style: ThemeHelper().buildTextStyle(context, AppColors.MainColor,'M')),
                    ],
                  ),
                ))),
          ))),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.MainColor,
      iconTheme: IconThemeData(
          color: Colors.white
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              searchBar.getSearchAction(context),
              IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {
                  // if(controller.SYED.toString() < controller._selectedDate.toString())
                  controller.SMMST = 2;
                  Get.defaultDialog(
                    title: 'StringMestitle'.tr,
                    middleText: '${'StringMessave'.tr}${controller.SMMNO}',
                    backgroundColor: Colors.white,
                    radius: 40,
                    textCancel: 'StringNo'.tr,
                    cancelTextColor: Colors.red,
                    textConfirm: 'StringYes'.tr,
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Navigator.of(context).pop(false);
                      controller.editMode();
                    },
                    // barrierDismissible: false,
                  );
                },
              ),
              PopupMenuButton(
                enableFeedback: true,
                padding: EdgeInsets.all(0.0),
                initialValue: 0,
                elevation: 0.0,
                icon: Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        setState(() {
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            // titleStyle: TextStyle(),
                            middleText: 'StringCHK_Cal'.tr,
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringNo'.tr,
                            cancelTextColor: Colors.red,
                            textConfirm: 'StringYes'.tr,
                            confirmTextColor: Colors.white,
                            // cancel: Text(StringNo,style: TextStyle(color: Colors.blueAccent),),
                            // confirm: Text('StringYes'.tr,style: TextStyle(color: Colors.red),),
                            // onCancel: (){
                            //   Navigator.of(context).pop(false);
                            // },
                            onConfirm: () {
                              Navigator.of(context).pop(false);
                              bool isValid =
                              controller.delete_STO_MOV_M(null, 1);
                              if (isValid) {
                                Get.offAndToNamed('/Inventory');
                              }
                            },
                            // barrierDismissible: false,
                          );
                        });
                      },
                      leading: const Icon(Icons.delete, color: Colors.black),
                      title:  Text(
                        'StringDeleteAppBar'.tr,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          controller.SMMST = 3;
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            middleText:
                            '${'StringMessave'.tr}${controller.SMMNO}',
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringNo'.tr,
                            cancelTextColor: Colors.red,
                            textConfirm: 'StringYes'.tr,
                            confirmTextColor: Colors.white,
                            onConfirm: () {
                              Navigator.of(context).pop(false);
                              controller.editMode();
                            },
                            // barrierDismissible: false,
                          );
                        });
                      },
                      leading: const Icon(
                        Icons.save_outlined,
                        color: Colors.black,
                      ),
                      title: InkWell(
                        child:  Text(
                          'StringSaveAppBar'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        onTap: () {
                          setState(() {
                            controller.SMMST = 3;
                            Get.defaultDialog(
                              title: 'StringMestitle'.tr,
                              middleText:
                              '${'StringMessave'.tr}${controller.SMMNO}',
                              backgroundColor: Colors.white,
                              radius: 40,
                              textCancel: 'StringNo'.tr,
                              cancelTextColor: Colors.red,
                              textConfirm: 'StringYes'.tr,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Navigator.of(context).pop(false);
                                controller.editMode();
                              },
                              // barrierDismissible: false,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
      title: Text(
          '${controller.titleScreen} ${controller.SMKID==17?'StringInventory'.tr:controller.SMKID==1?'StringItem_In_Voucher'.tr:controller.SMKID==3?'StringItem_Out_Voucher'.tr:
          controller.SMKID==11 ? 'StringTransfer_Store_Request'.tr: controller.SMKID==131? 'StringTransfer_Store_Branches'.tr:
          controller.SMKID==0?'StringIncoming_Store'.tr:'StringInventoryTransferVoucher'.tr}',
          style: ThemeHelper().buildTextStyle(context, AppColors.textColor,'M')
      ),
      elevation: 0.5,
    );
  }

  FutureBuilder<List<Sto_Inf_Local>> DropdownSto_InfBuilder() {
    return FutureBuilder<List<Sto_Inf_Local>>(
        future: GETSTO_INF(controller.SelectDataBIID.toString()),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return IgnorePointer(
            ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown('StringSIIDlableText'.tr),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringStoch', Colors.grey,'S'),
              value: controller.SelectDataSIID,
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.SIID.toString(),
                child: Text(
                  "${item.SIID.toString()} - ${item.SINA_D
                      .toString()}",
                  style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
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
                setState(() {
                  //Do something when changing the item if you want.
                  controller.SelectDataSIID = value.toString();
                  controller.fetchAutoCompleteData();
                });
              },
            ),
          );
        });
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder() {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future: GET_BRA(1),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return IgnorePointer(
            ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
            child: DropdownButtonFormField2(
              decoration: ThemeHelper().InputDecorationDropDown(controller.SMKID==131?'StringFromBrach'.tr:'StringBIIDlableText'.tr),
              isExpanded: true,
              hint: ThemeHelper().buildText(context,'StringBrach', Colors.grey,'S'),
              value: controller.SelectDataBIID,
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              items: snapshot.data!
                  .map((item) => DropdownMenuItem<String>(
                value: item.BIID.toString(),
                child: Text("${item.BIID.toString()} - ${item
                    .BINA_D.toString()}",
                  style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                ),
              ))
                  .toList()
                  .obs,
              validator: (v) {
                if (v == null) {
                  return 'StringBrach'.tr;
                };
                return null;
              },
              onChanged: (value) {
                //Do something when changing the item if you want.
                if (controller.SelectDataSIID != null) {
                  controller.SelectDataSIID = null;
                }
                Timer(const Duration(milliseconds: 10), () {
                  setState(() {
                    controller.SelectDataBIID = value.toString();
                    if (controller.SelectDataSIID != null) {
                      controller.SelectDataSIID = null;
                      GETSTO_INF(controller.SelectDataBIID.toString());
                    } else {
                      controller.SelectDataSIID = null;
                      GETSTO_INF(controller.SelectDataBIID.toString());
                    }
                  });
                });
                controller.SelectDataBIID = value.toString();
                controller.SelectDataSIID_F = null;
                controller.SelectDataSIID_T = null;
                controller.GET_STO_INF_P();
                controller.update();
              },
            ),
          );
        });
  }

  GetBuilder<InventoryController> DropdownBra_Inf_TBuilder() {
    return GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: ((value) => FutureBuilder<List<Bra_Inf_Local>>(
            future: GET_BRA_T(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return IgnorePointer(
                ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown('StringToBrach'.tr),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
                  value: controller.SelectDataBIID_T,
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    value: item.BIID.toString(),
                    child: Text("${item.BIID.toString()} - ${item
                        .BINA_D.toString()}",
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'StringToBrach'.tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      controller.SelectDataBIID_T = value.toString();
                    });
                  },
                ),
              );
            })));
  }

  GetBuilder<InventoryController> DropdownSto_Inf_FBuilder() {
    return GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: ((value) =>FutureBuilder<List<Sto_Inf_Local>>(
            future: FROM_STO_INF(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return IgnorePointer(
                ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown('StringF_SIID'.tr),
                  hint: ThemeHelper().buildText(context,'StringF_SIID', Colors.grey,'S'),
                  value: controller.SelectDataSIID_F,
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.SINA_F=item.SINA_D.toString();
                    },
                    value: item.SIID.toString(),
                    child: Text(
                      "${item.SIID.toString()} - ${item.SINA_D
                          .toString()}",
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'StringF_SIID'.tr;
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      // controller.SelectDataSIID = value.toString();
                      controller.SelectDataSIID_F = value.toString();
                      controller.SelectDataSIID_T = null;
                      controller.fetchAutoCompleteData();
                    });
                  },
                ),
              );
            })));
  }

  GetBuilder<InventoryController> DropdownSto_Inf_TBuilder(SMKID) {
    return GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: ((value) => FutureBuilder<List<Sto_Inf_Local>>(
            future: SMKID==11? FROM_STO_INF(controller.SelectDataBIID.toString()):
                   SMKID==131 ? FROM_STO_INF(controller.SelectDataBIID_T.toString()):
                   TO_STO_INF(controller.SelectDataBIID.toString(),controller.SelectDataSIID_F.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return IgnorePointer(
                ignoring: controller.edit == true ? true : controller.CheckBack == 1 ? true : false,
                child: DropdownButtonFormField2(
                  decoration: ThemeHelper().InputDecorationDropDown('StringT_SIID'.tr),
                  isExpanded: true,
                  hint: ThemeHelper().buildText(context,'StringT_SIID', Colors.grey,'S'),
                  value: controller.SelectDataSIID_T,
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                    onTap: (){
                      controller.SelectDataAANO=item.AANO.toString();
                      controller.SINA_T=item.SINA_D.toString();
                      controller.GETAANA_P(item.AANO.toString());
                    },
                    value: item.SIID.toString(),
                    child: Text(
                      "${item.SIID.toString()} - ${item.SINA_D
                          .toString()}",
                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                    ),
                  )).toList(),
                  validator: (value) {
                    if (value == null) {
                      return 'StringT_SIID'.tr;
                    }
                    return null;
                  },

                  onChanged: (value) {
                    setState(() {
                      //Do something when changing the item if you want.
                      controller.SelectDataSIID_T = value.toString();
                      print(value.toString().split(" +++ ")[0]);
                      print('value.toString().split(" +++ ")[0]');
                      controller.fetchAutoCompleteData();
                    });
                  },
                ),
              );
            })));
  }

  GetBuilder<InventoryController> DropdownACC_COSBuilder() {
    return GetBuilder<InventoryController>(
        init: InventoryController(),
        builder: ((value) =>FutureBuilder<List<Acc_Cos_Local>>(
            future: GET_ACC_COS(),
            builder: (BuildContext context,
                AsyncSnapshot<List<Acc_Cos_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringACNOlableText'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringCHI_ACNO', Colors.grey,'S'),
                value: controller.SelectDataACNO,
                style:ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.ACNO.toString(),
                  child: Text(
                    item.ACNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) {
                  //Do something when changing the item if you want.
                  controller.SelectDataACNO = value.toString();
                },
              );
            })));
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
                controller.GET_AKID_P();
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
                controller.GET_AKID_P();
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

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CURBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(
              josnStatus: josnStatus,
              GETSTRING: 'StringChi_currency'.tr,
            );
          }
          return IgnorePointer(
              ignoring: controller.edit == true
                  ? true
                  : controller.CheckBack == 1
                  ? true
                  : false,
              child: DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown("${'StringSCIDlableText'.tr}  ${'Stringexchangerate'.tr} ${controller.SCEX}"),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
                value: controller.SelectDataSCID,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.SCID.toString(),
                  onTap: () {
                    controller.SCEX= item.SCEX;
                    controller.SCSY = item.SCSY!;
                    controller.SCSFL = item.SCSFL!;
                    controller.update();
                  },
                  child: Text(
                    item.SCNA_D.toString(),
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                validator: (v) {
                  if (v == null) {
                    return 'StringChi_currency'.tr;
                  };
                  return null;
                },
                onChanged: (value) {
                  controller.SelectDataSCID = value.toString();
                  controller.update();
                },
              ));
        });
  }

}
