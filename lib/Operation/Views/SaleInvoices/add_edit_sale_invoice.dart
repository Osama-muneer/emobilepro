import 'dart:async';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/app_extension.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../TreasuryVouchers/add_ed_pay_out.dart';
import 'datagrid_sale_invoice.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

class Add_Edit_Sale_Invoice extends StatefulWidget {
  const Add_Edit_Sale_Invoice({Key? key}) : super(key: key);
  @override
  State<Add_Edit_Sale_Invoice> createState() => _Add_Edit_Sale_InvoiceState();
}

class _Add_Edit_Sale_InvoiceState extends State<Add_Edit_Sale_Invoice> {
  final Sale_Invoices_Controller controller = Get.find();
  late search.SearchBar searchBar;

  void onSubmitted(String value) {
    //ScaffoldMessenger.of(context).showSnackBar(snackBar);
    setState(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  searchBarDemoHomeState() {
    searchBar = search.SearchBar(
        onChanged: (value) {
          controller.SER_MINA = value;
          setState(() {
            DataGridPageInvoice();
            controller.CheckSearech = 1;
            controller.update();
          });
          controller.update();
        },
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        hintText: 'StringSer_MINA'.tr,
        onCleared: () {
          setState(() {
            controller.SER_MINA = '';
            DataGridPageInvoice();
            controller.update();
          });
          controller.update();
        },
        onClosed: () {
          controller.SER_MINA = '';
          DataGridPageInvoice();
          controller.CheckSearech = 1;
          controller.update();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    searchBarDemoHomeState();
    super.initState();
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      backgroundColor: AppColors.MainColor,
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              searchBar.getSearchAction(context),
              IconButton(
                icon: const Icon(Icons.save, color: Colors.white),
                onPressed: () async {
                  controller.BMMST = 2;
                  //    final difference = controller.DateDays_last.difference(SyncController().DateDays).inDays;
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
                      if (controller.Must_Specify_Location_Invoice == '1' &&
                          (controller.distanceInMeters >
                              double.parse(controller
                                      .Allow_Issuance_Invoice_Distance_Meters
                                  .toString()))) {
                        Get.defaultDialog(
                          title: 'StringMestitle'.tr,
                          middleText:
                              'StringLocation_of_Account_Application'.tr,
                          backgroundColor: Colors.white,
                          radius: 40,
                          textCancel: 'StringNo'.tr,
                          cancelTextColor: Colors.red,
                          textConfirm: 'StringYes'.tr,
                          confirmTextColor: Colors.white,
                          onConfirm: () async {
                            Navigator.of(context).pop(false);
                            if (controller.SelectDataBCID != null &&
                                controller.PKID_C == 1 &&
                                (controller.PKID == 3 ||
                                    controller.PKID == 2)) {
                              Get.defaultDialog(
                                title: 'StringMestitle'.tr,
                                middleText: 'StringCHK_PKID_C'.tr,
                                backgroundColor: Colors.white,
                                radius: 40,
                                textCancel: 'StringOK'.tr,
                                cancelTextColor: Colors.blueAccent,
                                barrierDismissible: false,
                              );
                            } else if (controller.SelectDataBCID != null &&
                                controller.PKID_C == 3 &&
                                controller.PKID == 1) {
                              Get.defaultDialog(
                                title: 'StringMestitle'.tr,
                                middleText: 'StringCHK_PKID_C'.tr,
                                backgroundColor: Colors.white,
                                radius: 40,
                                textCancel: 'StringOK'.tr,
                                cancelTextColor: Colors.blueAccent,
                                barrierDismissible: false,
                              );
                            } else if (controller.SelectDataBCID != null &&
                                controller.PKID_C == 2 &&
                                controller.PKID == 1) {
                              Get.defaultDialog(
                                title: 'StringMestitle'.tr,
                                middleText: 'StringCHK_PKID_C'.tr,
                                backgroundColor: Colors.white,
                                radius: 40,
                                textCancel: 'StringOK'.tr,
                                cancelTextColor: Colors.blueAccent,
                                barrierDismissible: false,
                              );
                            } else {
                              if (((controller.BMKID == 11 || controller.BMKID == 12) &&
                                          controller.SHOW_BDID == '3') &&
                                      controller.SelectDataBDID == null ||
                                  ((controller.BMKID != 11 && controller.BMKID != 12) &&
                                          controller.SHOW_BDID == '2') &&
                                      controller.SelectDataBDID == null) {
                                Get.defaultDialog(
                                  title: 'StringMestitle'.tr,
                                  middleText: 'StringErr_BDID'.tr,
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  textCancel: 'StringNo'.tr,
                                  cancelTextColor: Colors.red,
                                  textConfirm: 'StringYes'.tr,
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    Navigator.of(context).pop(false);
                                    if (StteingController().isSwitchSend_SMS == true &&
                                        controller.BMKID != 1 && controller.BMKID != 2 &&
                                        controller.BCMOController.text.isNotEmpty) {
                                      Get.defaultDialog(
                                          title: 'StringMestitle'.tr,
                                          middleText: 'StringSend_SMS'.tr,
                                          backgroundColor: Colors.white,
                                          radius: 40,
                                          textCancel: 'StringNo'.tr,
                                          cancelTextColor: Colors.red,
                                          textConfirm: 'StringYes'.tr,
                                          confirmTextColor: Colors.white,
                                          onConfirm: () {
                                            Navigator.of(context).pop(false);
                                            controller.SEND_SMS = true;
                                            controller.update();
                                            controller.editMode();
                                          },
                                          onCancel: () {
                                            Navigator.of(context).pop(false);
                                            controller.SEND_SMS = false;
                                            controller.update();
                                            controller.editMode();
                                          });
                                    } else {
                                      controller.editMode();
                                    }
                                  },
                                );
                              } else {
                                if (StteingController().isSwitchSend_SMS ==
                                        true &&
                                    controller.BMKID != 1 && controller.BMKID != 2 &&
                                    controller.BCMOController.text.isNotEmpty) {
                                  Get.defaultDialog(
                                      title: 'StringMestitle'.tr,
                                      middleText: 'StringSend_SMS'.tr,
                                      backgroundColor: Colors.white,
                                      radius: 40,
                                      textCancel: 'StringNo'.tr,
                                      cancelTextColor: Colors.red,
                                      textConfirm: 'StringYes'.tr,
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        Navigator.of(context).pop(false);
                                        controller.SEND_SMS = true;
                                        controller.update();
                                        controller.editMode();
                                      },
                                      onCancel: () {
                                        Navigator.of(context).pop(false);
                                        controller.SEND_SMS = false;
                                        controller.update();
                                        controller.editMode();
                                      });
                                } else {
                                  controller.editMode();
                                }
                              }
                            }
                          },
                          onCancel: () async {
                            Navigator.of(context).pop(false);
                            controller.determinePosition();
                          },
                          barrierDismissible: false,
                        );
                      } else {
                        Navigator.of(context).pop(false);
                        if (controller.SelectDataBCID != null &&
                            controller.PKID_C == 1 &&
                            (controller.PKID == 3 || controller.PKID == 2)) {
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            middleText: 'StringCHK_PKID_C'.tr,
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringOK'.tr,
                            cancelTextColor: Colors.blueAccent,
                            barrierDismissible: false,
                          );
                        } else if (controller.SelectDataBCID != null &&
                            controller.PKID_C == 3 &&
                            controller.PKID == 1) {
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            middleText: 'StringCHK_PKID_C'.tr,
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringOK'.tr,
                            cancelTextColor: Colors.blueAccent,
                            barrierDismissible: false,
                          );
                        } else if (controller.SelectDataBCID != null &&
                            controller.PKID_C == 2 &&
                            controller.PKID == 1) {
                          Get.defaultDialog(
                            title: 'StringMestitle'.tr,
                            middleText: 'StringCHK_PKID_C'.tr,
                            backgroundColor: Colors.white,
                            radius: 40,
                            textCancel: 'StringOK'.tr,
                            cancelTextColor: Colors.blueAccent,
                            barrierDismissible: false,
                          );
                        } else {
                          if (((controller.BMKID == 11 ||
                                          controller.BMKID == 12) &&
                                      controller.SHOW_BDID == '3') &&
                                  controller.SelectDataBDID == null ||
                              ((controller.BMKID != 11 &&
                                          controller.BMKID != 12) &&
                                      controller.SHOW_BDID == '2') &&
                                  controller.SelectDataBDID == null) {
                            Get.defaultDialog(
                              title: 'StringMestitle'.tr,
                              middleText: 'StringErr_BDID'.tr,
                              backgroundColor: Colors.white,
                              radius: 40,
                              textCancel: 'StringNo'.tr,
                              cancelTextColor: Colors.red,
                              textConfirm: 'StringYes'.tr,
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Navigator.of(context).pop(false);
                                if (StteingController().isSwitchSend_SMS ==
                                        true &&
                                    controller.BMKID != 1 &&  controller.BMKID != 2 &&
                                    controller.BCMOController.text.isNotEmpty) {
                                  Get.defaultDialog(
                                      title: 'StringMestitle'.tr,
                                      middleText: 'StringSend_SMS'.tr,
                                      backgroundColor: Colors.white,
                                      radius: 40,
                                      textCancel: 'StringNo'.tr,
                                      cancelTextColor: Colors.red,
                                      textConfirm: 'StringYes'.tr,
                                      confirmTextColor: Colors.white,
                                      onConfirm: () {
                                        Navigator.of(context).pop(false);
                                        controller.SEND_SMS = true;
                                        controller.update();
                                        controller.editMode();
                                      },
                                      onCancel: () {
                                        Navigator.of(context).pop(false);
                                        controller.SEND_SMS = false;
                                        controller.update();
                                        controller.editMode();
                                      });
                                } else {
                                  controller.editMode();
                                }
                              },
                            );
                          } else {
                            if (StteingController().isSwitchSend_SMS == true &&
                                controller.BMKID != 1 &&  controller.BMKID != 2 &&
                                controller.BCMOController.text.isNotEmpty) {
                              Get.defaultDialog(
                                  title: 'StringMestitle'.tr,
                                  middleText: 'StringSend_SMS'.tr,
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  textCancel: 'StringNo'.tr,
                                  cancelTextColor: Colors.red,
                                  textConfirm: 'StringYes'.tr,
                                  confirmTextColor: Colors.white,
                                  onConfirm: () {
                                    Navigator.of(context).pop(false);
                                    controller.SEND_SMS = true;
                                    controller.update();
                                    controller.editMode();
                                  },
                                  onCancel: () {
                                    Navigator.of(context).pop(false);
                                    controller.SEND_SMS = false;
                                    controller.update();
                                    controller.editMode();
                                  });
                            } else {
                              controller.editMode();
                            }
                          }
                        }
                      }
                    },
                    // barrierDismissible: false,
                  );
                },
              ),
              PopupMenuButton(
                color: Colors.white,
                enableFeedback: true,
                initialValue: 0,
                elevation: 0.0,
                icon: const Icon(Icons.more_vert),
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          controller.BMMST = 4;
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
                              if (controller.SelectDataBCID != null &&
                                  controller.PKID_C == 1 &&
                                  (controller.PKID == 3 ||
                                      controller.PKID == 2)) {
                                Get.defaultDialog(
                                  title: 'StringMestitle'.tr,
                                  middleText: 'StringCHK_PKID_C'.tr,
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  textCancel: 'StringOK'.tr,
                                  cancelTextColor: Colors.blueAccent,
                                  barrierDismissible: false,
                                );
                              } else if (controller.SelectDataBCID != null &&
                                  controller.PKID_C == 3 &&
                                  controller.PKID == 1) {
                                Get.defaultDialog(
                                  title: 'StringMestitle'.tr,
                                  middleText: 'StringCHK_PKID_C'.tr,
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  textCancel: 'StringOK'.tr,
                                  cancelTextColor: Colors.blueAccent,
                                  barrierDismissible: false,
                                );
                              } else if (controller.SelectDataBCID != null &&
                                  controller.PKID_C == 2 &&
                                  controller.PKID == 1) {
                                Get.defaultDialog(
                                  title: 'StringMestitle'.tr,
                                  middleText: 'StringCHK_PKID_C'.tr,
                                  backgroundColor: Colors.white,
                                  radius: 40,
                                  textCancel: 'StringOK'.tr,
                                  cancelTextColor: Colors.blueAccent,
                                  barrierDismissible: false,
                                );
                              } else {
                                if (((controller.BMKID == 11 ||
                                            controller.BMKID == 12) &&
                                        controller.SHOW_BDID == '3') ||
                                    ((controller.BMKID != 11 ||
                                                controller.BMKID != 12) &&
                                            controller.SHOW_BDID == '2') &&
                                        controller.SelectDataBDID == null) {
                                  Get.defaultDialog(
                                    title: 'StringMestitle'.tr,
                                    middleText: 'StringErr_BDID'.tr,
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
                                  );
                                } else {
                                  controller.editMode();
                                }
                              }
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
                        child: ThemeHelper().buildText(
                            context, 'StringSaveAppBar', Colors.black, 'M'),
                        onTap: () {
                          Navigator.pop(context);
                          setState(() {
                            controller.BMMST = 4;
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
                                if ((controller.BMKID != 11 ||
                                        controller.BMKID != 12) &&
                                    controller.PKID_C == 1 &&
                                    (controller.PKID != 3 ||
                                        controller.PKID != 2)) {
                                  Get.defaultDialog(
                                    title: 'StringMestitle'.tr,
                                    middleText: 'StringCHK_PKID_C'.tr,
                                    backgroundColor: Colors.white,
                                    radius: 40,
                                    textCancel: 'StringOK'.tr,
                                    cancelTextColor: Colors.blueAccent,
                                    barrierDismissible: false,
                                  );
                                } else if ((controller.BMKID != 11 ||
                                        controller.BMKID != 12) &&
                                    controller.PKID_C == 3 &&
                                    controller.PKID != 1) {
                                  Get.defaultDialog(
                                    title: 'StringMestitle'.tr,
                                    middleText: 'StringCHK_PKID_C'.tr,
                                    backgroundColor: Colors.white,
                                    radius: 40,
                                    textCancel: 'StringOK'.tr,
                                    cancelTextColor: Colors.blueAccent,
                                    barrierDismissible: false,
                                  );
                                } else if ((controller.BMKID != 11 ||
                                        controller.BMKID != 12) &&
                                    controller.PKID_C == 8 &&
                                    controller.PKID != 8) {
                                  Get.defaultDialog(
                                    title: 'StringMestitle'.tr,
                                    middleText: 'StringCHK_PKID_C'.tr,
                                    backgroundColor: Colors.white,
                                    radius: 40,
                                    textCancel: 'StringOK'.tr,
                                    cancelTextColor: Colors.blueAccent,
                                    barrierDismissible: false,
                                  );
                                } else if ((controller.BMKID != 11 ||
                                        controller.BMKID != 12) &&
                                    controller.PKID_C == 9 &&
                                    controller.PKID != 9) {
                                  Get.defaultDialog(
                                    title: 'StringMestitle'.tr,
                                    middleText: 'StringCHK_PKID_C'.tr,
                                    backgroundColor: Colors.white,
                                    radius: 40,
                                    textCancel: 'StringOK'.tr,
                                    cancelTextColor: Colors.blueAccent,
                                    barrierDismissible: false,
                                  );
                                } else {
                                  if (((controller.BMKID == 11 ||
                                              controller.BMKID == 12) &&
                                          controller.SHOW_BDID == '3') ||
                                      ((controller.BMKID != 11 ||
                                                  controller.BMKID != 12) &&
                                              controller.SHOW_BDID == '2') &&
                                          controller.SelectDataBDID == null) {
                                    Get.defaultDialog(
                                      title: 'StringMestitle'.tr,
                                      middleText: 'StringErr_BDID'.tr,
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
                                    );
                                  } else {
                                    controller.editMode();
                                  }
                                }
                              },
                              // barrierDismissible: false,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      onTap: () {
                        Navigator.pop(context);
                        controller.buildShowTotal(context);
                      },
                      leading: const Icon(
                        Icons.save_outlined,
                        color: Colors.black,
                      ),
                      title: InkWell(
                        child: ThemeHelper().buildText(
                            context, 'StringTotal', Colors.black, 'M'),
                        onTap: () {
                          Navigator.pop(context);
                          controller.buildShowTotal(context);
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
      title: Text('${controller.titleScreen}',
          style: ThemeHelper().buildTextStyle(context, AppColors.textColor, 'L')),
    );
  }

  Future<bool> onWillPop() async {
    final shouldPop;
    if ((controller.edit == true || controller.CheckBack == 0)) {
      if (controller.edit == true) {
        UpdateBIL_MOV_M_SUM(
            controller.BMKID == 11 || controller.BMKID == 12
                ? 'BIF_MOV_M' : 'BIL_MOV_M',
            controller.BMKID!,
            controller.BMMID!,
            controller.roundDouble(
                double.parse(controller.BMMAMController.text) +
                    double.parse(controller.SUMBMDTXTController.text),
                controller.SCSFL),
            controller.SUMBMDTXT!,
            int.parse(controller.CountRecodeController.text),
            controller
                .roundDouble(
                    (double.parse(controller.BMMAMController.text) +
                            double.parse(controller.SUMBMDTXTController.text)) *
                        double.parse(controller.SCEXController.text),
                    2)
                .toString(),
            controller.SUMBMMDIF!,
            controller.SelectDataBMMDN == '1'
                ? controller.SUMBMMDI!
                : controller.BMMDIController.text.isNotEmpty
                    ? double.parse(controller.BMMDIController.text) : 0,
            controller.BMMDIRController.text.isNotEmpty
                ? double.parse(controller.BMMDIRController.text)
                : 0,
            double.parse(controller.BMMAMTOTController.text),
            controller.SUMBMDTXT1!,
            controller.SUMBMDTXT2!,
            controller.SUMBMDTXT3!,
            controller.BMMAM_TX,
            controller.BMMDI_TX,
            controller.TCAM);
      }
      if (controller.CheckSearech == 1) {
        controller.CheckSearech = 0;
        controller.SER_MINA = '';
        DataGridPageInvoice();
        controller.update();
        return true;
      } else {
        Navigator.of(context).pop(false);
        controller.GET_BIL_MOV_M_P('DateNow');
        LoginController().SET_N_P('TIMER_POST', 0);
        LoginController().SET_P('Return_Type', '1');
        shouldPop = await Get.toNamed('/Sale_Invoices');
      }
    } else {
      if (controller.CheckSearech == 1) {
        controller.CheckSearech = 0;
        controller.SER_MINA = '';
        DataGridPageInvoice();
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
            bool isValid = controller.delete_BIL_MOV(null, 1);
            if (isValid) {
              LoginController().SET_P('Return_Type', '1');
              Get.offAndToNamed('/Sale_Invoices');
              controller.loading(false);
              LoginController().SET_N_P('TIMER_POST', 0);
              controller.update();
            }
          },
        );
      }
    }

    return shouldPop ?? false;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
        onWillPop: onWillPop,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: searchBar.build(context),
          body: LayoutBuilder(builder: (context, constraints) {
            double screenHeight = constraints.maxHeight;
            double firstSectionHeight = height > 900
                ? screenHeight / 2.5
                : height > 500
                    ? screenHeight / 2.35
                    : screenHeight / 1.5;
            return GetBuilder<Sale_Invoices_Controller>(
              init: Sale_Invoices_Controller(),
              builder: ((value) => Padding(
                    padding: EdgeInsets.only(left: 0.02 * width, right: 0.02 * width),
                    child: Column(
                      children: [
                        controller.SHOW_GRO == true
                            ? _buildColumnGRO(context,screenHeight,height,width)
                            : controller.SHOW_ITEM == true
                                ? DefaultTabController(
                                    length: 2,
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: <Widget>[
                                        TabBar(
                                            indicatorColor: Colors.red,
                                            tabs: [
                                              Tab(
                                                child: ThemeHelper().buildText(
                                                    context,
                                                    'StringMain',
                                                    Colors.red,
                                                    'L'),
                                              ),
                                              Tab(
                                                child: ThemeHelper().buildText(
                                                    context,
                                                    'StringAdditional_Data',
                                                    Colors.red,
                                                    'L'),
                                              ),
                                            ]),
                                        Container(
                                          height:  firstSectionHeight,
                                          child: TabBarView(children: [
                                            SingleChildScrollView(
                                              child: _buildFirstColumn(context, height),
                                            ),
                                            SingleChildScrollView(
                                              child: _buildLASTColumn(context, height),
                                            ),
                                          ]),
                                        ),
                                      ],
                                    ),
                                  )
                                : Expanded(
                                  child: SingleChildScrollView(
                                    child: Column(
                                        children: [
                                          _buildFirstColumn(context, height),
                                          _buildLASTColumn(context, height),
                                        ],
                                      ),
                                  ),
                                ),
                        controller.SHOW_ITEM == true
                            ? Expanded(child: DataGridPageInvoice())
                            : Container(),
                      ],
                    ),
                  )),
            );
          }),
          bottomNavigationBar: GetBuilder<Sale_Invoices_Controller>(
              init: Sale_Invoices_Controller(),
              builder: ((value) => SafeArea(
                child: Container(
                      color: Colors.grey[100],
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _buildBottomColumn(context,
                              title: "${'StrinCount_SMDFN'.tr}",
                              value: "${controller.BMMAMController.text.isEmpty ? controller.BMMAMController.text = '0' : controller.formatter.format(double.parse(controller.BMMAMController.text))}"),
                          _buildBottomColumn(context,
                              title: "${'StringSUMBMMDI2'.tr}",
                              value: "${controller.BMMDIController.text.isEmpty ? controller.BMMDIController.text = '0' : controller.formatter.format(double.parse(controller.BMMDIController.text))}"),
                          if(controller.SVVL_TAX != '2')
                            _buildBottomColumn(context,
                              title: "${'StringSUM_BMMTX_ORD'.tr}",
                              value: "${controller.SUMBMDTXTController.text.isEmpty ? controller.SUMBMDTXTController.text = '0' : controller.formatter.format(double.parse(controller.SUMBMDTXTController.text))}"),
                          _buildBottomColumn(context,
                              title: "${'StringNet_Amount'.tr}",
                              value: "${controller.BMMAMTOTController.text.isEmpty ? controller.BMMAMTOTController.text = '0' : controller.formatter.format(double.parse(controller.BMMAMTOTController.text))}"),
                          _buildBottomColumn(context,
                              title: "${'StrinCount_RECODE'.tr}",
                              value: "${controller.CountRecodeController.text.isEmpty ? controller.CountRecodeController.text = '0' : controller.CountRecodeController.text}"),
                        ],
                      ),
                    ),
              ))),
          floatingActionButton: GetBuilder<Sale_Invoices_Controller>(
              init: Sale_Invoices_Controller(),
              builder: ((value) =>
              LoginController().Return_Type == '2'
                  ? Container()
                  : SpeedDial(
                icon: Icons.menu,
                activeIcon: Icons.close,
                backgroundColor: Colors.red,
                children: [
                  SpeedDialChild(
                    label: 'اظهار الاصناف', // اسم بجانب الأيقونة
                    child: Icon(Icons.receipt),
                    onTap: () async {
                      controller.ADD_T = 2;
                      await controller.fetchAutoCompleteData(2, '2');
                      controller.update();
                      AddItems();
                      controller.update();
                    },
                  ),
                  SpeedDialChild(
                    label: controller.SHOW_ITEM == true ? 'إخفاء الجدول' : 'عرض الجدول',
                    child: Icon(controller.SHOW_ITEM == true
                        ? Icons.arrow_downward
                        : Icons.arrow_upward),
                    onTap: () {
                      controller.SHOW_ITEM = !controller.SHOW_ITEM;
                      controller.update();
                    },
                  ),
                  SpeedDialChild(
                    label: 'إضافة سند قبض',
                    child: Icon(Icons.add_box_outlined),
                    onTap: () {
                      if (controller.UPIN_VOU == 1) {
                        Get.to(() => Add_Ed_Pay_Out(), arguments: 11);
                      } else {
                        Get.snackbar('StringUPIN'.tr, 'String_CHK_UPIN'.tr,
                            backgroundColor: Colors.red,
                            icon: Icon(Icons.error, color: Colors.white),
                            colorText: Colors.white,
                            isDismissible: true,
                            dismissDirection: DismissDirection.horizontal,
                            forwardAnimationCurve: Curves.easeOutBack);
                      }
                      controller.update();
                    },
                  ),
                ],
              ))
          ),
          floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
        ));
  }

  InputDecoration buildInputDecoration(String labelText,height,{bool isFocused=false}) {
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
      labelText: labelText,
      labelStyle: ThemeHelper().buildTextStyle(context,  isFocused ? Colors.red : Colors.grey, 'S'),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(0.15 * height),
        borderSide: BorderSide(color: Colors.red),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(0.015 * height)),
      ),
    );
  }

  /// حقل نصي للقراءة فقط
  Widget _buildReadOnlyTextField(BuildContext context,TextEditingController controller2,String labelText, height) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.bold),
      controller: controller2,
      textAlign: TextAlign.center,
      readOnly: true,
      // focusNode:focusNode,
      decoration: buildInputDecoration(labelText,height),
      onTap: () {
        controller.selectDateBMMCD(context);
        controller.update();
      },
    );
  }

  Widget buildReadOnlyTextField(BuildContext context,TextEditingController controller2,String labelText, height) {
    return TextFormField(
      style: const TextStyle(fontWeight: FontWeight.bold),
      controller: controller2,
      textAlign: TextAlign.center,
      readOnly: true,
    //  enabled: false,
      decoration: buildInputDecoration(labelText,height),
    );
  }


  //بيانات الرئيسية
  Widget _buildFirstColumn(BuildContext context, height) {
    /// التحقق من حالة تعطيل حقل التاريخ
    bool _isDateFieldDisabled() {
      return controller.Date_of_Insert_Invoice == '1' ||
          (controller.Date_of_Insert_Invoice == '4' &&
              controller.Allow_to_Inserted_Date_of_Sales_Invoices != 1);
    }

    /// إنشاء حقل نصي قياسي
    Widget _buildTextFormField(BuildContext context, height,focusNode,
        {required String labelText, required TextEditingController controller}) {
      return TextFormField(
        style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
        controller: controller,
        focusNode:focusNode,
        keyboardType: TextInputType.number,
        decoration: buildInputDecoration(labelText,height,isFocused:focusNode.hasFocus),
      );
    }

    /// بناء الصف الأول
    Widget _buildFirstRow(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: controller.DropdownBra_InfBuilder(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.6,
            child: IgnorePointer(
              ignoring: _isDateFieldDisabled(),
              child: InkWell(
                onTap: () {
                  controller.selectDateFromDays(context);
                },
                child: Center(
                  child: Text(
                    controller.SelectDays ??=
                    controller.selectedDatesercher.toString().split(" ")[0],
                    style:
                    ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                  ),
                ),
              ),
            ),
          ),
        ],
      );
    }

    /// بناء الصف الثاني
    Widget _buildSecondRow(BuildContext context, height) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: controller.BMKID == 11 || controller.BMKID == 12
                ? controller.DropdownBil_PoiBuilder()
                : controller.DropdownSto_InfBuilder(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.6,
            child: _buildTextFormField(
              context,
              height,
              controller.focusNode,
              labelText: 'StringBMMNO'.tr,
              controller: controller.BMMREController,
            ),
          ),
        ],
      );
    }

    /// بناء الصف الثالث
    Widget _buildThirdRow(BuildContext context) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 1.8,
            child: controller.BMKID == 11 || controller.BMKID == 12
                ? controller.DropdownSto_InfBuilder()
                : controller.DropdownSYS_CURBuilder(),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.6,
            child: controller.DropdownPAY_KINBuilder(),
          ),
        ],
      );
    }

    /// بناء صف ديناميكي يعتمد على `PKID` و `BMKID`
    Widget _buildDynamicRow(BuildContext context, height) {
      if (controller.PKID == 1) {
        return controller.BMKID == 11 || controller.BMKID == 12
            ? controller.DropdownSYS_CURBuilder()
            : controller.DropdownACC_CASBuilder();
      } else if (controller.PKID == 3) {
        return controller.BMKID == 11 || controller.BMKID == 12
            ? controller.DropdownSYS_CURBuilder()
            : _buildReadOnlyTextField(context,controller.BMMCDController,'StringBMMCD'.tr, height);
      } else if (controller.PKID == 9) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width / 1.8,
                child: controller.DropdownACC_BANBuilder()),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.6,
              child: _buildTextFormField(
                context,
                height,
                controller.focusNode,
                labelText: 'StringTransferNo'.tr,
                controller: controller.BMMCNController,
              ),
            ),
          ],
        );
      } else {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 1.8,
              child: controller.BMKID == 11 || controller.BMKID == 12
                  ? controller.DropdownSYS_CURBuilder()
                  : controller.DropdownBIL_CRE_CBuilder(),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width / 2.6,
              child: _buildTextFormField(
                context,
                height,
                controller.focusNode,
                labelText: 'StringTransferNo'.tr,
                controller: controller.BMMCNController,
              ),
            ),
          ],
        );
      }
    }

    /// بناء الصف الأخير
    Widget _buildLastRow(BuildContext context, height) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: (controller.BMKID == 1 || controller.BMKID == 2)
                ? controller.DropdownBIL_IMPBuilder()
                : controller.DropdownBIL_CUSBuilder(),
          ),
          if (controller.GUID_LNK.toString().length<5)
            IconButton(
              icon: Icon(Icons.add_circle, color: AppColors.MainColor, size: 0.05 * height),
              onPressed: () async {
                controller.ADD_T = 1;
                await controller.fetchAutoCompleteData(StteingController().SHOW_ITEM==true ||
                    StteingController().SHOW_ITEM_C==true?2:controller.ADD_T,'1');
                controller.update();
                AddItems();
              },
            ),
        ],
      );
    }


    return Column(
      children: [
        SizedBox(height: 0.01 * height),
        _buildFirstRow(context),
        SizedBox(height: 0.01 * height),
        _buildSecondRow(context, height),
        SizedBox(height: 0.01 * height),
        _buildThirdRow(context),
        SizedBox(height: 0.01 * height),
        _buildDynamicRow(context, height),
        SizedBox(height: 0.01 * height),
        _buildLastRow(context, height),
      ],
    );
  }

  //بيانات اضافية
  Widget _buildLASTColumn(BuildContext context, height) {

    Widget buildRowField(
        TextEditingController controller,
        String labelText, {
          required double height,
          required BuildContext context,
          VoidCallback? onTap,
        }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              decoration: buildInputDecoration(labelText, height),
              onTap: onTap,
              readOnly: onTap != null, // اجعل الحقل للقراءة فقط إذا كانت هناك وظيفة onTap
            ),
          ),
        ],
      );
    }


    Widget buildTextFormField(
        String label,
        TextEditingController controller, {
          required double height,
          TextStyle? style,
          bool readOnly = false,
          TextAlign textAlign = TextAlign.start,
          VoidCallback? onTap,
        }) {
      return TextFormField(
        controller: controller,
        decoration: buildInputDecoration(label, height),
        style: style,
        readOnly: readOnly,
        textAlign: textAlign,
        onTap: onTap,
      );
    }

    Widget buildRow(Widget child) {
      return Row(
        children: [Expanded(child: child)],
      );
    }

    bool shouldShowAccountingEffectFields() {
      return (controller.Accounting_Effect_of_Branches == '3' &&
          LoginController().BIID_ALL_V == '2') ||
          (controller.Accounting_Effect_of_Branches == '4' &&
              controller.UPIN_ACCOUNTING_EFFECT == 1 &&
              LoginController().BIID_ALL_V == '2');
    }

    Widget buildTaxFields(BuildContext context, double height) {
      if (controller.USING_TAX_SALES == '3') {
        return Row(
          children: [
            IgnorePointer(
              ignoring: controller.edit == true || controller.CheckBack == 1,
              child: Checkbox(
                value: controller.Price_include_Tax,
                onChanged: (value) {
                  controller.Price_include_Tax = value!;
                  controller.update();
                },
                activeColor: AppColors.MainColor,
              ),
            ),
            ThemeHelper().buildText(context, 'StrinPriceincludeTax', Colors.black, 'M'),
          ],
        );
      } else if (LoginController().CIID == '2') {
        return buildTextFormField(
          'StringBMMDR'.tr,
          controller.BMMRE2Controller,
          height: height,
        );
      }
      return Container();
    }

    bool shouldShowBMKIDFields() =>
        controller.BMKID == 7 || controller.BMKID == 10;

    bool canGiveCashDiscount() =>
        (controller.PKID == 1 &&
            controller.Allow_give_discount_Pay_Cash == '1') ||
            (controller.Allow_give_discount_Pay_Cash == '3' &&
                controller.UPIN_Allow_give_discount_Pay_Cash == 1);

    bool canGiveDueDiscount() =>
        (controller.PKID == 3 && controller.Allow_give_discount_Pay_due == '1') ||
            (controller.Allow_give_discount_Pay_due == '3' &&
                controller.UPIN_Allow_give_discount_Pay_due == 1);

    bool canGiveOtherDiscount() =>
        (controller.PKID != 1 &&
            controller.PKID != 3 &&
            controller.Allow_give_discount_Pay_Not_Cash_Due == '1') ||
            (controller.Allow_give_discount_Pay_Not_Cash_Due == '3' &&
                controller.UPIN_Allow_give_discount_Pay_Not_Cash_Due == 1);

    Widget buildDiscountFields(height) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.15,
            child: TextFormField(
              decoration: buildInputDecoration('StringDiscount_R'.tr, height),
              controller: controller.BMMDIRController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              onChanged: (v) {
                if (v.isNotEmpty && double.parse(v) >= 0) {
                  controller.UPDATE_BMMDI();
                }
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.15,
            child: TextFormField(
              decoration: buildInputDecoration('StringDiscount'.tr, height),
              controller: controller.BMMDIController,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              onChanged: (v) {
                if (v.isNotEmpty && double.parse(v) >= 0) {
                  controller.BMMDIRController.text = '0';
                  controller.UPDATE_BMMDI();
                }
              },
            ),
          ),
        ],
      );
    }


    return Column(
      children: [
        // Fields shown based on BMKID conditions
        if (shouldShowBMKIDFields()) ...[
          SizedBox(height: 0.01 * height),
          buildTextFormField(
            'StringBMMGR'.tr,
            controller.BMMGRController,
            style: TextStyle(color: Colors.black),
            height: height,
          ),
          if (controller.PKID != 3) ...[
            SizedBox(height: 0.01 * height),
            buildTextFormField(
              'StringBMMCD2'.tr,
              controller.BMMCDController,
              style: TextStyle(fontWeight: FontWeight.bold),
              height: height,
              readOnly: true,
              textAlign: TextAlign.center,
              onTap: () {
                controller.selectDateBMMCD(context);
                controller.update();
              },
            ),
          ]
        ],

        SizedBox(height: 0.01 * height),

        // Discount-related fields
        if (controller.Allow_give_Discount == '1' && controller.UPIN_BMMDI == 1) ...[
          if (canGiveCashDiscount() || canGiveDueDiscount() || canGiveOtherDiscount())
            controller.DropdownDiscountTYPEBuilder(),
          SizedBox(height: 0.01 * height),
          if (controller.SelectDataBMMDN == '0' && (canGiveCashDiscount() || canGiveDueDiscount() || canGiveOtherDiscount()))
          buildDiscountFields(height),
          SizedBox(height: 0.01 * height),
        ],

        // Delivery date field
        if (controller.Use_delivery_date == '1')
          buildRowField(
            controller.BMMDDController,
            'StringBMMDD'.tr,
            height: height,
            context: context,
            onTap: () {
              controller.selectDateBMMDD(context);
              controller.update();
            },
          ),

        SizedBox(height: 0.01 * height),

        // Dropdown for BIL_DISBuilder
        if (controller.BMKID != 11 || (controller.BMKID == 11 || controller.BMKID == 12) && controller.SHOW_BDID != '1')
          buildRow(controller.DropdownBIL_DISBuilder()),

        SizedBox(height: 0.01 * height),

        // Dropdown for ACC_COSBuilder
        if ((controller.BMKID != 11 && controller.BMKID != 12) ||
            controller.P_COSM != '1' ||
            (controller.P_COS_SEQ == '2' && controller.P_COSS == '5'))
          buildRow(controller.DropdownACC_COSBuilder()),
        if (controller.BMKID != 11 && controller.BMKID != 12)
        SizedBox(height: 0.01 * height),

        // Additional text field
        buildTextFormField(
          'StringDetails'.tr,
          controller.BMMINController,
          style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
          height: height,
        ),

        SizedBox(height: 0.01 * height),

        // Additional text field
        buildTextFormField(
          'StringBCDMO'.tr,
          controller.BCDMOController,
          style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
          height: height,
        ),

        // Conditional fields for BMKID
        if (controller.BMKID == 7 || controller.BMKID == 10) ...[
          SizedBox(height: 0.01 * height),
          buildTextFormField(
            'StringBMMDR2'.tr,
            controller.BMMDRController,
            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
            height: height,
          ),
          SizedBox(height: 0.01 * height),
          buildTextFormField(
            'StringBMMDE2'.tr,
            controller.BMMDEController,
            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
            height: height,
          ),
        ],
        SizedBox(height: 0.01 * height),

        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
         SizedBox(
         width: MediaQuery.of(context).size.width / 2.2,
          child:buildReadOnlyTextField(context,controller.BCLATController,'StringLATITUDE'.tr, height),
         ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 2.2,
            child: buildReadOnlyTextField(context,controller.BCLONController,'StringLONGITUDE'.tr, height),
          ),
        ],),

        SizedBox(height: 0.01 * height),

        // Accounting Effect of Branches
        if (shouldShowAccountingEffectFields())
          buildRow(controller.DropdownACCOUNTING_EFFECTBuilder(context)),

        SizedBox(height: 0.01 * height),
        // Tax-related fields
        buildTaxFields(context, height),
      ],
    );
  }

  Widget _buildColumnGRO(BuildContext context,screenHeight,height,width) {
    return Column(
      children: [
        SizedBox(height: 0.01 * height),
        SizedBox(
          height: controller.MAT_GRO.length < 4
              ? screenHeight / 13.5
              : screenHeight / 7.5,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
              controller.MAT_GRO.length < 4 ? 1 : 2,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              mainAxisExtent: 240,
            ),
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.MAT_GRO.length,
            itemBuilder:
                (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.only(
                    left: 0.01 * width,
                    right: 0.01 * width),
                child: TextButton(
                  onPressed: () async {
                    controller.SelectDataMGNO = controller.MAT_GRO[index].MGNO.toString();
                    controller.MGNOController.text = controller.MAT_GRO[index].MGNO.toString();
                    await controller.fetchAutoCompleteData(2,'2');
                    controller.update();
                  },
                  style: controller.MAT_GRO[index].MGNO.toString() == controller.SelectDataMGNO
                      ? TextButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.red),
                    //foregroundColor: Colors.black,
                    // backgroundColor: Colors.grey[400],
                    shape:
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius
                          .circular(0.02 *
                          height), // <-- Radius
                    ),
                  )
                      : TextButton.styleFrom(
                    side: const BorderSide(
                        color: Colors.black45),
                    // foregroundColor: Colors.black,
                    shape:
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius
                          .circular(0.02 *
                          height), // <-- Radius
                    ),
                  ),
                  child: Text(
                      controller.MAT_GRO[index].MGNA_D.toString(),
                      style: ThemeHelper().buildTextStyle(context, controller.MAT_GRO[index].MGNO.toString() == controller.SelectDataMGNO ? Colors.red : Colors.black, 'M')),
                ).fadeAnimation(index * 0.1),
              );
            },
          ),
        ),
        Divider(
            color: Colors.black,
            height: 0.01 * height),
        SizedBox(
          height: controller.autoCompleteData.length < 6 ? screenHeight / 11.0 : controller.autoCompleteData.length < 11
              ? screenHeight / 6.0 : screenHeight / 4.0,
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: controller.autoCompleteData.length < 6 ? 1 : controller.autoCompleteData.length < 11 ? 2 : 3,
              crossAxisSpacing: 5.0,
              mainAxisSpacing: 5.0,
              mainAxisExtent: 200,
            ),
            // shrinkWrap: true,
            scrollDirection: Axis.horizontal,
            itemCount: controller.autoCompleteData.length,
            itemBuilder: (context, index) {
              return getItem(index, controller.autoCompleteData[index], width, height);
            },
          ),
        ),
        SizedBox(height: 0.01 * height),
      ],
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

  void displayAddItems() {
    controller.ClearBil_Mov_D_Data();
    controller.update();
    controller.displayAddItemsWindo();
    controller.update();
  }

  Future<void> AddItems() async {
    controller.update();
    if (controller.SelectDataBIID == null) {
      Fluttertoast.showToast(
          msg: 'StringBrach'.tr,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if (controller.SelectDataSIID == null) {
      Fluttertoast.showToast(
          msg: 'StringStoch'.tr,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if (controller.SelectDataSCID == null) {
      Fluttertoast.showToast(
          msg: 'StringChi_currency'.tr,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if ((controller.BMKID == 3 ||
            controller.BMKID == 5 ||
            controller.BMKID == 7 ||
            controller.BMKID == 10) &&
        controller.SelectDataBCID == null) {
      Fluttertoast.showToast(
          msg: 'StringvalidateBCNA'.tr,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if (controller.BMKID != 1 && controller.BMKID != 2 &&
        controller.PKID == 3 &&
        controller.SelectDataBCID == null) {
      Fluttertoast.showToast(
          msg: 'StringvalidateBCNA'.tr,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if ((controller.BMKID == 1 || controller.BMKID == 2) && controller.SelectDataBIID2 == null) {
      Fluttertoast.showToast(
          msg: 'StringChi_BIID'.tr,
          textColor: Colors.white,
          backgroundColor: Colors.red);
    } else if (controller.BMKID != 11 &&
        controller.BMKID != 12 &&
        controller.PKID == 1 &&
        controller.SelectDataACID == null) {
      Fluttertoast.showToast(
          msg: 'StringChi_ACID'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    } else if (controller.SelectDataBCID != null &&
        controller.BCCT == 2 &&
        int.parse(controller.SelectDataSCID.toString()) != 1) {
      Fluttertoast.showToast(
          msg: 'StringCHK_SCID_C'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    } else if (controller.SelectDataBCID != null &&
        controller.BCCT == 3 &&
        int.parse(controller.SelectDataSCID.toString()) == 1) {
      Fluttertoast.showToast(
          msg: 'StringCHK_SCID_C'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    } else if (controller.SelectDataBCID != null &&
        controller.BCCT == 4 &&
        int.parse(controller.SelectDataSCID.toString()) != controller.SCID_C) {
      Fluttertoast.showToast(
          msg: 'StringCHK_SCID_C'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    } else if (controller.SelectDataBCID != null &&
        controller.BCCT == 5 &&
        int.parse(controller.SelectDataSCID.toString()) == controller.SCID_C) {
      Fluttertoast.showToast(
          msg: 'StringCHK_SCID_C'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    } else if (controller.edit == false &&
            controller.SCEXController.text.isEmpty ||
        (controller.SCHRController.text.isNotEmpty &&
            double.parse(controller.SCEXController.text) >
                double.parse(controller.SCHRController.text)) ||
        (controller.SCLRController.text.isNotEmpty &&
            double.parse(controller.SCEXController.text) <
                double.parse(controller.SCLRController.text))) {
      Fluttertoast.showToast(
          msg: 'StringError_SCEX'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    } else if (controller.edit == false &&
            controller.SCEXSController.text.isEmpty ||
        (controller.SCHRSController.text.isNotEmpty &&
            double.parse(controller.SCEXSController.text) >
                double.parse(controller.SCHRSController.text)) ||
        (controller.SCLRSController.text.isNotEmpty &&
            double.parse(controller.SCEXSController.text) <
                double.parse(controller.SCLRSController.text))) {
      Fluttertoast.showToast(
          msg: 'StringError_SCEXS'.tr,
          toastLength: Toast.LENGTH_LONG,
          textColor: Colors.white,
          backgroundColor: Colors.redAccent);
    } else {
      if (controller.ADD_T == 2) {
        controller.SelectDataMGNO='0';
        controller.SHOW_GRO == true ? controller.SHOW_GRO = false : controller.SHOW_GRO = true;
        controller.update();
      } else {
        controller.MGNOController.clear();
        controller.SelectDataMGNO = null;
        controller.SelectDataMGNO2 = null;
        controller.titleAddScreen = 'StringAdd'.tr;
        controller.TextButton_title = 'StringAdd'.tr;
        controller.update();
        displayAddItems();
        controller.update();
      }
    }
  }

  // عرض الاصناف
  Widget getItem(int index, YourDataType, width, height) {
  final  option=  controller.autoCompleteData[index];
    return Padding(
      padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
      child: TextButton(
        onPressed: () async {
          controller.SelectDataMINO = controller.autoCompleteData[index].MINO.toString();
          controller.MGNOController.text = controller.autoCompleteData[index].MGNO.toString();
          controller.SelectDataMUID = controller.autoCompleteData[index].MUID.toString();
          controller.MGKI = controller.autoCompleteData[index].MGKI;
          controller.SIID_V2 = controller.SelectDataSIID.toString();
          controller.BMDAMController.text =controller.BCPR==2? option.MPS2.toString(): controller.BCPR==3?
          option.MPS3.toString() :controller.BCPR==4? option.MPS4.toString(): option.MPS1.toString();
          controller.MPS1 = double.parse(controller.BMDAMController.text);
          controller.update();
          await controller.GET_COUNT_NO_P(
              controller.autoCompleteData[index].MGNO.toString(),
              controller.autoCompleteData[index].MINO.toString(),
              controller.autoCompleteData[index].MUID!);
          controller.MINAController.text = controller.autoCompleteData[index].MINA_D.toString();
          controller.SelectDataMUCNA = controller.autoCompleteData[index].MUNA_D.toString();
          if (controller.COUNT_NO > 0) {
            await controller.GET_COUNT_MINO_P();
            controller.update();
            var BIL_BMMNO = await GET_BIL_MOV_D_ORD(
                controller.BMKID == 11 || controller.BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',
                controller.BMMID.toString(),
                controller.autoCompleteData[index].MGNO.toString(),
                controller.autoCompleteData[index].MINO.toString(),
                controller.autoCompleteData[index].MUID!);
            if (BIL_BMMNO.isNotEmpty) {
              await controller.UPDATE_BIF_MOV_D_ORD(BIL_BMMNO.elementAt(0), 1);
              controller.update();
            }
          } else {
            controller.COUNT_MINO = 0;
            controller.MIED = controller.autoCompleteData[index].MIED;
            controller.BMDNOController.text = '1';
            controller.BMDNO_V = 1;
            await controller.GETSNDE_ONE();
            controller.BMDNFController.text = '0';
            controller.SUMBMDAMController.text = '0';
            controller.BMDDIRController.text = '0';
            controller.BMDDIController.text = '0';
            // controller.MPS1 = double.parse(controller.BMDAMController.text);
            if (controller.TTID1 != null) {
              await controller.GET_TAX_LIN_P('MAT',
                  controller.autoCompleteData[index].MGNO.toString(),
                  controller.autoCompleteData[index].MINO.toString());
            }
            Timer(const Duration(milliseconds: 200), () async {
              if (controller.COUNT_NO <= 0) {
                await controller.Calculate_BMD_NO_AM();
                controller.update();
                bool isValid = await controller.Save_BIL_MOV_D_ORD_P();
                if (isValid) {
                  controller.ClearBil_Mov_D_Data();
                }
              }
            });
            controller.update();
          }
        },
        style: "${option.MINA_D.toString()}-${option.MUNA_D.toString()}" ==
                "${controller.MINAController.text}-${controller.SelectDataMUCNA.toString()}"
            ? TextButton.styleFrom(
                side: const BorderSide(color: Colors.red),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(0.01 * height), // <-- Radius
                ),
              )
            : TextButton.styleFrom(
                side: const BorderSide(color: Colors.black45),
                // foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(0.01 * height), // <-- Radius
                ),
              ),
        child: Text(
            "${option.MINA_D.toString()}-${option.MUNA_D.toString()} (${controller.formatter.format(
                controller.BCPR==2? option.MPS2:controller.BCPR==3? option.MPS3:controller.BCPR==4? option.MPS4:option.MPS1).toString()})",
            style: ThemeHelper().buildTextStyle(
                context,
                "${option.MINA_D.toString()}-${option.MUNA_D.toString()}" ==
                        "${controller.MINAController.text}-${controller.SelectDataMUCNA.toString()}"
                    ? Colors.red
                    : Colors.black,
                'M')),
      ).fadeAnimation(index * 0.1),
    );
  }

}
