import 'dart:async';
import 'dart:io';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../Operation/models/acc_mov_d.dart';
import '../../../Operation/Controllers/Pay_Out_Controller.dart';
import '../../../PrintFile/Vouchers/generate_vouchers.dart';
import '../../../PrintFile/Vouchers/vouchers_view_thermal.dart';
import '../../../PrintFile/Vouchers/vouchers_view_simple.dart';
import '../../../PrintFile/file_helper.dart';
import '../../../PrintFile/share_mode.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/SignatureScreen.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/TreasuryVouchers_db.dart';
import '../../../database/setting_db.dart';

class ViewPay_Out extends StatefulWidget {
  @override
  State<ViewPay_Out> createState() => _ViewPay_OutState();
}

class _ViewPay_OutState extends State<ViewPay_Out> {
  final Pay_Out_Controller controller = Get.find();
  late search.SearchBar searchBar;
  String query = '';
  DateTime DateDays = DateTime.now();
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
  final txtController = TextEditingController();

  static const Color grey_5 = Color(0xFFf2f2f5);
  Future<void> _selectDataFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateDays,
      firstDate: DateTime(2020, 5),
      lastDate: DateTime(3000),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
              primaryColor: const Color(0xFF4A5BF6),
              colorScheme:
              ColorScheme.fromSwatch(primarySwatch: buttonTextColor)
                  .copyWith(
                  secondary: const Color(0xFF4A5BF6)) //selection color
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        DateDays = picked;
        String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        controller.SelectNumberOfDays = formattedDate;
        setState(() {
          controller.TYPE_SHOW = "FromDate";
          controller.GET_ACC_MOV_M_P("FromDate", controller.AMKID!);
        });
      });
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text(
          (Get.arguments == 1 || controller.AMKID == 1)
              ? 'StringReceipt_Vouchers'.tr
              : (Get.arguments == 2 || controller.AMKID == 2)
              ? 'StringPayOuts'.tr
              : (Get.arguments == 3 || controller.AMKID == 3)
              ? 'StringCollection_Vouchers'.tr
              : 'StringJournalVouchers'.tr,
          style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
        ),
        backgroundColor: AppColors.MainColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.picture_as_pdf_sharp,color: Colors.white),
            onPressed: () async {
              await generateReportVou(
                  GETAMKID: controller.AMKID!,
                  TYPE: controller.TYPE_SHOW,
                  GETDateNow: controller.TYPE_SHOW == "DateNow" ? DateFormat('dd-MM-yyyy').format(DateTime.now()) :
                  controller.TYPE_SHOW == "FromDate" ? controller.SelectNumberOfDays : '',GETAMMST:
                  controller.currentIndex,BIID_F: controller.selectedBranchFrom.toString(),
                  BIID_T:controller.selectedBranchTo.toString(),AMMDO_F:controller.FromDaysController.text,
                  AMMDO_T:controller.ToDaysController.text,
                  SCID_V:controller.SelectDataSCID_S.toString(),TYPE_SER: controller.TYPE_SER
              );},
          ),
          IconButton(
              icon: const Icon(
                Icons.sync_rounded,
                color: Colors.white,
              ),
              onPressed: () async {
                // await SyncronizationData.isInternet().then((connection) async {
                //   if (connection) {
                if (controller.ACC_MOV_M_List.length > 0) {
                  Get.defaultDialog(
                    title: 'StringMestitle'.tr,
                    // titleStyle: TextStyle(),
                    middleText: 'StringSuresyn'.tr,
                    backgroundColor: Colors.white,
                    radius: 40,
                    textCancel: 'StringNo'.tr,
                    cancelTextColor: Colors.red,
                    textConfirm: 'StringYes'.tr,
                    confirmTextColor: Colors.white,
                    onConfirm: () {
                      Navigator.of(context).pop(false);
                      controller.Socket_IP_Connect('SyncAll', '', true);
                    },
                    // barrierDismissible: false,
                  );
                }
                //   }
                // });
                //   } else {
                //     Get.snackbar('StringCHK_Int_Tit'.tr, 'StringCHK_Int_Mes'.tr,
                //         backgroundColor: Colors.red,
                //         icon: Icon(Icons.wifi_off, color: Colors.white),
                //         colorText: Colors.white,
                //         isDismissible: true,
                //         dismissDirection: DismissDirection.horizontal,
                //         forwardAnimationCurve: Curves.easeOutBack);
                //   }
                // });
              }),
          Row(
            children: [
              searchBar.getSearchAction(context),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => showFilterSheet(context),
              ),
              // PopupMenuButton(
              //   color: Colors.white,
              //   enableFeedback: true,
              //   initialValue: 0,
              //   elevation: 0.0,
              //   itemBuilder: (BuildContext context) => <PopupMenuEntry>[
              //     PopupMenuItem(
              //       child: InkWell(
              //         onTap: () {
              //           setState(() {
              //             controller.TYPE_SHOW = "ALL";
              //             controller.GET_ACC_MOV_M_P("ALL", controller.AMKID!);
              //             Navigator.of(context).pop(false);
              //             // Get.offAndToNamed(Routes.Inventory);
              //           });
              //         },
              //         child: ListTile(
              //           title: Text(
              //             'StringShowAll'.tr,
              //             style: const TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //       ),
              //     ),
              //     PopupMenuItem(
              //       child: InkWell(
              //         onTap: () {
              //           setState(() {
              //             controller.TYPE_SHOW = "DateNow";
              //             controller.GET_ACC_MOV_M_P("DateNow", controller.AMKID!);
              //             Navigator.of(context).pop(false);
              //           });
              //         },
              //         child: ListTile(
              //           title: Text(
              //             'StringDateNow'.tr,
              //             style: const TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //       ),
              //     ),
              //     PopupMenuItem(
              //       child: InkWell(
              //         onTap: () {
              //           Navigator.pop(context);
              //           setState(() {
              //             _selectDataFromDate(context);
              //           });
              //         },
              //         child: ListTile(
              //           title: Text(
              //             'StringSerDate'.tr,
              //             style: const TextStyle(fontWeight: FontWeight.bold),
              //           ),
              //         ),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          )
        ]);
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

  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  void searchRequestData(String query) {
    final listDatacustmoerRequest = controller.ACC_MOV_M_List.where((list) {
      final AMMNOLower = list.AMMNO.toString().toLowerCase();
      final AMMDOLower = list.AMMDO.toString().toLowerCase();
      final BINA_DLower = list.BINA_D.toString().toLowerCase();
      final AMMINLower = list.AMMIN.toString().toLowerCase();
      final AMMAMLower = list.AMMAM.toString().toLowerCase();
      final AANO_DLower = list.AANO_D.toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return AMMNOLower.contains(searchLower) ||
          AMMDOLower.contains(searchLower) ||
          BINA_DLower.contains(searchLower) ||
          AMMINLower.contains(searchLower) ||
          AMMAMLower.contains(searchLower) ||
          AANO_DLower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;

      controller.ACC_MOV_M_List = listDatacustmoerRequest;
      if (query == '') {
        controller.GET_ACC_MOV_M_P("DateNow", controller.AMKID!);
      }
    });
    controller.CheckSearech = 1;
  }

  _SearchBarDemoHomeState() {

    searchBar = search.SearchBar(
        hintText: 'StringSearchBarInv'.tr,
        onChanged: searchRequestData,
        controller: txtController,
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onCleared: () {
          setState(() {
            controller.GET_ACC_MOV_M_P("DateNow", controller.AMKID!);
            controller.update();
          });
          print("cleared");
        },
        onClosed: () {
          setState(() {
            controller.GET_ACC_MOV_M_P("DateNow", controller.AMKID!);
            controller.update();
          });
          print("closed");
        });
  }

  Future<bool> onWillPop() async {
    final shouldPop;
    if (controller.CheckSearech == 1) {
      controller.CheckSearech = 0;
      controller.update();
      return true;
    }
    else {
      print('object');
      Navigator.of(context).pop(false);
      shouldPop = await Get.offAllNamed('/Home');
    }
    return shouldPop ?? false;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _SearchBarDemoHomeState();
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: searchBar.build(context),
        // appBar: ThemeHelper().MainAppBar((Get.arguments==1 || controller.AMKID==1)?'StringReceipt_Vouchers'.tr:
        // (Get.arguments==2 || controller.AMKID==2) ? 'StringPayOuts'.tr:'StringCollection_Vouchers'.tr),
        backgroundColor: grey_5,
        body: GetBuilder<Pay_Out_Controller>(
            init: Pay_Out_Controller(),
            builder: ((value) {
              if (controller.ACC_MOV_M_List.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "${ImagePath}no_data.png",
                        height: 0.1 * height,
                      ),
                      ThemeHelper().buildText(context,'StringNoData', Colors.black,'L'),
                    ],
                  ),
                );
              }
              return ListView.builder(
                itemCount: controller.ACC_MOV_M_List.length,
                itemBuilder: (BuildContext context, int index) => InkWell(
                  onTap: () async {
                    // if (controller.loading_l == false) {
                    controller.ListACC_MOV_D.clear();
                    controller.update();
                    controller.GET_ACC_MOV_D_View_P(
                        controller.ACC_MOV_M_List[index].AMKID.toString(),
                        controller.ACC_MOV_M_List[index].AMMID.toString());
                    controller.update();
                    await Future.delayed(const Duration(milliseconds: 1000));
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        fullscreenDialog: true,
                        transitionDuration: Duration(milliseconds: 1000),
                        pageBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation) {
                          return Scaffold(
                              appBar: AppBar(
                                title:  ThemeHelper().buildText(context,'StringDetails', Colors.black,'L'),
                                backgroundColor: Colors.grey[100],
                              ),
                              body: LayoutBuilder(
                                  builder: (context, constraints) {
                                    double screenHeight = constraints.maxHeight;
                                    double firstSectionHeight = screenHeight / 6;
                                    double secondSectionHeight = (screenHeight / 3) * 2;
                                    return Hero(
                                      tag: 'osa',
                                      child: Card(
                                        elevation: 2,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              0.02 * height),
                                        ),
                                        clipBehavior: Clip.antiAliasWithSaveLayer,
                                        child: Container(
                                          color: Colors.white,
                                          child: Column(
                                            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                height: firstSectionHeight,
                                                child: Row(
                                                  mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                                  children: <Widget>[
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          controller.ACC_MOV_M_List[index].BINA_D.toString(),
                                                          style:  ThemeHelper().buildTextStyle(context, Colors.black,
                                                              controller.ACC_MOV_M_List[index].BINA_D.toString().length >= 30
                                                                  ? 'S' : 'M'),
                                                        ),
                                                        Text(
                                                          controller.AMKID != 15
                                                              ? controller.ACC_MOV_M_List[index].PKNA_D.toString() : '',
                                                          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                                        Text(
                                                            controller.AMKID != 15 ? controller.ACC_MOV_M_List[index].PKID == '1'
                                                                ? controller.ACC_MOV_M_List[index].ACNA_D.toString()
                                                                : controller.ACC_MOV_M_List[index].PKID == '8' ? controller.ACC_MOV_M_List[index].BCCNA_D.toString()
                                                                : controller.ACC_MOV_M_List[index].ABNA_D.toString()
                                                                : controller.ACC_MOV_M_List[index].AMMDO.toString().substring(0, 10),
                                                            style: ThemeHelper().buildTextStyle(context, Colors.black,
                                                              controller.ACC_MOV_M_List[index].ACNA_D.toString().length >= 35 ||
                                                                  controller.ACC_MOV_M_List[index].BCCNA_D.toString()
                                                                      .length >=
                                                                      35 ||
                                                                  controller
                                                                      .ACC_MOV_M_List[
                                                                  index]
                                                                      .ABNA_D
                                                                      .toString()
                                                                      .length >=
                                                                      35
                                                                  ? 'S'
                                                                  : 'M',)
                                                        ),
                                                      ],
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceEvenly,
                                                      children: <Widget>[
                                                        Text(
                                                          controller
                                                              .ACC_MOV_M_List[index]
                                                              .AMMNO
                                                              .toString(),
                                                          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                                        ),
                                                        controller.ACC_MOV_M_List[index].SCSY.toString()=='SAR'?
                                                        Row(children: [
                                                          Text(
                                                              controller.AMKID != 15
                                                                  ? '${controller.formatter.format(double.parse(controller.ACC_MOV_M_List[index].AMMAM.toString()))} '
                                                                  : ' ',
                                                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                                          Image.asset(
                                                            "${ImagePath}Saudi_Riyal_Symbol.png",
                                                            //child: Image.asset("/data/data/com.elitesoftsys.emobilepro/app_flutter/2023_05_13_11_53_28.png",
                                                            fit: BoxFit.cover,
                                                            height: 0.02 * height,
                                                          ),
                                                        ],):
                                                        Text(
                                                          controller.AMKID != 15
                                                              ? '${controller.formatter.format(double.parse(controller.ACC_MOV_M_List[index].AMMAM.toString()))}'
                                                              ' ${controller.ACC_MOV_M_List[index].SCSY.toString()}'
                                                              : ' ${controller.ACC_MOV_M_List[index].SCNA_D.toString()}',
                                                          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                                        Text(
                                                          controller.AMKID != 15 ? controller.ACC_MOV_M_List[
                                                          index].AMMDO.toString() : controller.ACC_MOV_M_List[index].AMMDO.toString().substring(10, 19),
                                                          style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              // controller.ACC_MOV_M_List[index].AMMID == controller.AMMID_L ?
                                              Expanded(
                                                child: Container(
                                                  child: ListView.builder(
                                                      itemCount: controller.ListACC_MOV_D.length,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                          int index) {
                                                        return Card(
                                                          elevation: 2,
                                                          shape:
                                                          RoundedRectangleBorder(
                                                            borderRadius:
                                                            BorderRadius.circular(
                                                                0.02* height),
                                                          ),
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          child: Container(
                                                            color: Colors.grey[100],
                                                            child:
                                                            ListTile(
                                                              leading: const Icon(
                                                                Icons.assignment_rounded,
                                                                color: Colors.black,
                                                              ),
                                                              title: Text(
                                                                controller.ListACC_MOV_D[index].AANA_D.toString(),
                                                                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                                              ),
                                                              trailing: controller.ListACC_MOV_D[index].SCSY.toString()=='SAR'?
                                                              SizedBox(
                                                                width: 80, // adjust width as needed
                                                                child: Row(
                                                                  mainAxisSize: MainAxisSize.min,
                                                                  children: [
                                                                    Text(
                                                                      '${controller.formatter.format(controller.roundDouble(controller.ListACC_MOV_D[index].AMDMD != 0.0 ? controller.ListACC_MOV_D[index].AMDMD! : controller.ListACC_MOV_D[index].AMDDA!, 3))} ',
                                                                      style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                                                    ),
                                                                    Image.asset(
                                                                      "${ImagePath}Saudi_Riyal_Symbol.png",
                                                                      fit: BoxFit.cover,
                                                                      height: 0.02 *height,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ):
                                                                Text(
                                                                '${controller.formatter.format(controller.roundDouble(controller.ListACC_MOV_D[index].AMDMD != 0.0 ? controller.ListACC_MOV_D[index].AMDMD! : controller.ListACC_MOV_D[index].AMDDA!, 3)).toString()} ${controller.ListACC_MOV_D[index].SCSY.toString()}',
                                                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                                            ),
                                                            )

                                                          ),
                                                        );
                                                      }),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }));
                        },
                        transitionsBuilder: (BuildContext context,
                            Animation<double> animation,
                            Animation<double> secondaryAnimation,
                            Widget child) {
                          return FadeTransition(
                            opacity:
                            animation, // CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
                            child: child,
                          );
                        },
                      ),
                    );
                  },
                  child: Column(
                    children: [
                      Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0.02 * height),
                        ),
                        clipBehavior: Clip.antiAliasWithSaveLayer,
                        child: Container(
                          color: Colors.white,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                height: 0.18 * height,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: <Widget>[
                                    Expanded(
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          Text(
                                            controller.ACC_MOV_M_List[index].BINA_D.toString(),
                                            style: ThemeHelper().buildTextStyle(context, Colors.black,
                                                controller.ACC_MOV_M_List[index].BINA_D.toString().length >= 30
                                                    ? 'S' : 'M'),
                                          ),
                                          Text(
                                            controller.AMKID != 15
                                                ? controller
                                                .ACC_MOV_M_List[index].PKNA_D
                                                .toString()
                                                : '',
                                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                          Text(
                                              controller.AMKID != 15
                                                  ? controller.ACC_MOV_M_List[index].PKID == '1'
                                                  ? controller.ACC_MOV_M_List[index].ACNA_D.toString()
                                                  : controller.ACC_MOV_M_List[index].PKID == '8'
                                                  ? controller.ACC_MOV_M_List[index].BCCNA_D.toString()
                                                  : controller.ACC_MOV_M_List[index].ABNA_D.toString()
                                                  : controller
                                                  .ACC_MOV_M_List[index].AMMDO
                                                  .toString()
                                                  .substring(0, 10),
                                              style: ThemeHelper().buildTextStyle(context, Colors.black,
                                                controller.ACC_MOV_M_List[index].ACNA_D
                                                    .toString().length >=
                                                    35 ||
                                                    controller
                                                        .ACC_MOV_M_List[
                                                    index]
                                                        .BCCNA_D
                                                        .toString()
                                                        .length >=
                                                        35 ||
                                                    controller
                                                        .ACC_MOV_M_List[
                                                    index]
                                                        .ABNA_D
                                                        .toString()
                                                        .length >=
                                                        35
                                                    ? 'S'
                                                    : 'M',)
                                          ),
                                          Text(
                                              '${controller.ACC_MOV_M_List[index].AMMST}'
                                                  .toString() ==
                                                  '2'
                                                  ? 'StringNotfinal'.tr
                                                  : '${controller.ACC_MOV_M_List[index].AMMST}'
                                                  .toString() ==
                                                  '3'
                                                  ? 'StringPending'.tr
                                                  : 'Stringfinal'.tr,
                                              style: '${controller.ACC_MOV_M_List[index].AMMST}'
                                                  .toString() ==
                                                  '2'
                                                  ? ThemeHelper().buildTextStyle(context, Colors.red,'M')
                                                  : '${controller.ACC_MOV_M_List[index].AMMST}'
                                                  .toString() ==
                                                  '3'
                                                  ? ThemeHelper().buildTextStyle(context, Colors.blueAccent,'M')
                                                  : ThemeHelper().buildTextStyle(context, Colors.green,'M')
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        Text(
                                            controller.ACC_MOV_M_List[index].AMMNO.toString(),
                                            style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')
                                        ),
                                        controller.ACC_MOV_M_List[index].SCSY.toString()=='SAR'?
                                            Row(children: [
                                              Text(
                                                  controller.AMKID != 15
                                                      ? '${controller.formatter.format(double.parse(controller.ACC_MOV_M_List[index].AMMAM.toString()))} '
                                                      : ' ',
                                                  style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                              Image.asset(
                                                "${ImagePath}Saudi_Riyal_Symbol.png",
                                                //child: Image.asset("/data/data/com.elitesoftsys.emobilepro/app_flutter/2023_05_13_11_53_28.png",
                                                fit: BoxFit.cover,
                                                height: 0.02 * height,
                                              ),
                                            ],) :
                                        Text(
                                            controller.AMKID != 15
                                                ? '${controller.formatter.format(double.parse(controller.ACC_MOV_M_List[index].AMMAM.toString()))}'
                                                ' ${controller.ACC_MOV_M_List[index].SCSY.toString()}'
                                                : ' ${controller.ACC_MOV_M_List[index].SCNA_D.toString()}',
                                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                        Text(
                                            controller.AMKID != 15
                                                ? controller
                                                .ACC_MOV_M_List[index].AMMDO
                                                .toString()
                                                : controller
                                                .ACC_MOV_M_List[index].AMMDO
                                                .toString()
                                                .substring(10, 19),
                                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                        InkWell(
                                          onTap: () async {
                                            controller.GET_ACC_MOV_M_PRINT_P(
                                                controller.ACC_MOV_M_List[index].AMMID!,
                                                controller.ACC_MOV_M_List[index].AMKID!);
                                            controller.GET_ACC_MOV_D_P(controller.ACC_MOV_M_List[index].AMKID.toString(),
                                                controller.ACC_MOV_M_List[index].AMMID.toString());
                                            if(controller.UseSignature==0 && controller.ShowSignatureAlert==0){
                                                buildPdf_vouchers_samplie(index);
                                            }
                                            else if(controller.UseSignature==1 && controller.ShowSignatureAlert==0){
                                               controller.signature = await Navigator.push(context,MaterialPageRoute(builder: (_) => SignatureScreen()),);
                                              if (controller.signature != null) {
                                                  buildPdf_vouchers_samplie(index);
                                              }
                                            }
                                            else{
                                              Get.defaultDialog(
                                                title: 'StringMestitle'.tr,
                                                middleText: 'StringPrintSureSUID'.tr,
                                                backgroundColor: Colors.white,
                                                radius: 40,
                                                textCancel: 'StringNo'.tr,
                                                cancelTextColor: Colors.red,
                                                textConfirm: 'StringYes'.tr,
                                                confirmTextColor: Colors.white,
                                                onConfirm: () async {
                                                  Navigator.of(context).pop(false);
                                                  controller.signature = await Navigator.push(context,MaterialPageRoute(builder: (_) => SignatureScreen()),);
                                                  if (controller.signature != null) {
                                                   buildPdf_vouchers_samplie(index);
                                                  }
                                                },
                                                onCancel: (){
                                                  buildPdf_vouchers_samplie(index);
                                                },
                                              );
                                            }
                                          },
                                          child: Row(
                                            children: <Widget>[
                                              Icon(
                                                Icons.picture_as_pdf,
                                                size: 0.026 * height,
                                                color: Colors.blue,
                                              ),
                                              SizedBox(
                                                width: 0.002 * height,
                                              ),
                                              ThemeHelper().buildText(context,'StringPrint', Colors.blueAccent,'M'),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Expanded(
                                      child: Column(
                                        children: [
                                          '${controller.ACC_MOV_M_List[index].AMMST}' !=
                                              '1'
                                              ? Expanded(
                                            child: IconButton(
                                              onPressed: () async {
                                                if (controller
                                                    .ACC_MOV_M_List[index]
                                                    .AMMST
                                                    .toString() ==
                                                    '2') {
                                                  controller.EditTreasury(
                                                      controller.ACC_MOV_M_List[
                                                      index]);
                                                } else {
                                                  Get.snackbar('StringUPCH'.tr,
                                                      'String_CHK_UPCH'.tr,
                                                      backgroundColor:
                                                      Colors.red,
                                                      icon: const Icon(
                                                          Icons.error,
                                                          color: Colors.white),
                                                      colorText: Colors.white,
                                                      isDismissible: true,
                                                      dismissDirection:
                                                      DismissDirection
                                                          .horizontal,
                                                      forwardAnimationCurve:
                                                      Curves.easeOutBack);
                                                }
                                              },
                                              icon: Icon(
                                                Icons.edit,
                                                size: 0.026 * height,
                                              ),
                                            ),
                                          )
                                              : Expanded(child: Container()),
                                          '${controller.ACC_MOV_M_List[index].AMMST}' !=
                                              '1'
                                              ? Expanded(
                                            child: IconButton(
                                                icon: Icon(
                                                    Icons.delete,
                                                    color: Colors.red,
                                                    size: 0.026 * height
                                                ),
                                                onPressed: () async {
                                                  print(controller.UPDL);
                                                  Get.defaultDialog(
                                                    title: 'StringMestitle'.tr,
                                                    // titleStyle: TextStyle(),
                                                    middleText:
                                                    'StringDeleteMessage'
                                                        .tr,
                                                    backgroundColor:
                                                    Colors.white,
                                                    radius: 40,
                                                    textCancel: 'StringNo'.tr,
                                                    cancelTextColor: Colors.red,
                                                    textConfirm: 'StringYes'.tr,
                                                    confirmTextColor:
                                                    Colors.white,
                                                    onConfirm: () {
                                                      if (controller.UPDL ==
                                                          1) {
                                                        print(controller
                                                            .ACC_MOV_M_List[
                                                        index]
                                                            .AMMID);
                                                        print(
                                                            'controller.ACC_MOV_M_List[index].AMMID');
                                                        bool isValid = controller
                                                            .DELETE_ACC_MOV(
                                                            controller
                                                                .ACC_MOV_M_List[
                                                            index]
                                                                .AMMID
                                                                .toString(),
                                                            2);
                                                        if (isValid) {
                                                          controller
                                                              .GET_ACC_MOV_M_P(
                                                              "DateNow",
                                                              controller
                                                                  .ACC_MOV_M_List[
                                                              index]
                                                                  .AMKID!);
                                                        }
                                                        //  Get.back();
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      } else {
                                                        Get.snackbar(
                                                            'StringUPDL'.tr,
                                                            'String_CHK_UPDL'
                                                                .tr,
                                                            backgroundColor:
                                                            Colors.red,
                                                            icon: const Icon(
                                                                Icons.error,
                                                                color: Colors
                                                                    .white),
                                                            colorText:
                                                            Colors.white,
                                                            isDismissible: true,
                                                            dismissDirection:
                                                            DismissDirection
                                                                .horizontal,
                                                            forwardAnimationCurve:
                                                            Curves
                                                                .easeOutBack);
                                                        Navigator.of(context)
                                                            .pop(false);
                                                      }
                                                    },
                                                    // barrierDismissible: false,
                                                  );
                                                }),
                                          )
                                              : Expanded(
                                            child: IconButton(
                                                icon: Icon(
                                                    Icons.settings_backup_restore,
                                                    color: Colors.black,
                                                    size: 0.026 * height
                                                ),
                                                onPressed: () async {
                                                  Get.defaultDialog(
                                                    title: 'StringMestitle'.tr,
                                                    middleText:
                                                    'StringSuresyn'.tr,
                                                    backgroundColor:
                                                    Colors.white,
                                                    radius: 40,
                                                    textCancel: 'StringNo'.tr,
                                                    cancelTextColor: Colors.red,
                                                    textConfirm: 'StringYes'.tr,
                                                    confirmTextColor:
                                                    Colors.white,
                                                    onConfirm: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                      controller
                                                          .Socket_IP_Connect(
                                                          'SyncOnly',
                                                          controller
                                                              .ACC_MOV_M_List[
                                                          index]
                                                              .AMMID
                                                              .toString(),
                                                          true);
                                                    },
                                                  );
                                                }),
                                          ),
                                          Expanded(
                                            child: controller.ACC_MOV_M_List[index].AMKID == 1 ||
                                                controller.ACC_MOV_M_List[index].AMKID == 2 ||
                                                controller.ACC_MOV_M_List[index].AMKID == 3
                                                ? IconButton(
                                              onPressed: () async {
                                                // FileHelper().initPlatformState();
                                                // FileHelper().Get_Device();
                                                  if (controller.ShowRePrintingVoucher == '3' &&
                                                      controller.ACC_MOV_M_List[index].AMMPR == 1) {
                                                    Get.defaultDialog(
                                                      title:
                                                      'StringMestitle'.tr,
                                                      middleText:
                                                      'StringSecondprinshow'
                                                          .tr,
                                                      backgroundColor:
                                                      Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringNo'.tr,
                                                      cancelTextColor:
                                                      Colors.red,
                                                      textConfirm:
                                                      'StringYes'.tr,
                                                      confirmTextColor:
                                                      Colors.white,
                                                      onConfirm: () async {
                                                        Navigator.of(context)
                                                            .pop(false);
                                                        controller
                                                            .ShowRePrinting = 1;
                                                        controller.update();
                                                        controller
                                                            .GET_ACC_MOV_M_PRINT_P(
                                                          controller
                                                              .ACC_MOV_M_List[
                                                          index]
                                                              .AMMID!,
                                                          controller
                                                              .ACC_MOV_M_List[
                                                          index]
                                                              .AMKID!,
                                                        );
                                                        controller.GET_ACC_MOV_D_P(
                                                            controller
                                                                .ACC_MOV_M_List[
                                                            index]
                                                                .AMKID
                                                                .toString(),
                                                            controller
                                                                .ACC_MOV_M_List[
                                                            index]
                                                                .AMMID
                                                                .toString());
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1));
                                                        {
                                                          StteingController()
                                                              .Thermal_printer_paper_size ==
                                                              '58'
                                                              ? taxTikcetReportThermal(
                                                              mode: ShareMode
                                                                  .print,
                                                              msg: 'مرحبا',
                                                              orderDetails:
                                                              controller
                                                                  .ACC_MOV_M_PRINT)
                                                              : taxTikcetReportThermal(
                                                              mode: ShareMode
                                                                  .print,
                                                              msg: 'مرحبا',
                                                              orderDetails: controller.ACC_MOV_M_PRINT,
                                                               Type_Rep: '1');
                                                        }
                                                      },
                                                      onCancel: () async {
                                                        controller
                                                            .ShowRePrinting = 0;
                                                        controller.update();
                                                        controller
                                                            .GET_ACC_MOV_M_PRINT_P(
                                                          controller
                                                              .ACC_MOV_M_List[
                                                          index]
                                                              .AMMID!,
                                                          controller
                                                              .ACC_MOV_M_List[
                                                          index]
                                                              .AMKID!,
                                                        );
                                                        controller.GET_ACC_MOV_D_P(
                                                            controller
                                                                .ACC_MOV_M_List[
                                                            index]
                                                                .AMKID
                                                                .toString(),
                                                            controller
                                                                .ACC_MOV_M_List[
                                                            index]
                                                                .AMMID
                                                                .toString());
                                                        await Future.delayed(
                                                            const Duration(
                                                                seconds: 1));
                                                        {
                                                          StteingController()
                                                              .Thermal_printer_paper_size ==
                                                              '58'
                                                              ? taxTikcetReportThermal(
                                                              mode: ShareMode.print,
                                                              msg: 'مرحبا',
                                                              orderDetails: controller.ACC_MOV_M_PRINT,
                                                              Type_Rep: '2')
                                                              : taxTikcetReportThermal(
                                                              mode: ShareMode
                                                                  .print,
                                                              msg: 'مرحبا',
                                                              orderDetails:
                                                              controller.ACC_MOV_M_PRINT,
                                                              Type_Rep: '1');
                                                        }
                                                      },
                                                      barrierDismissible: false,
                                                    );
                                                  } else {
                                                    controller.GET_ACC_MOV_M_PRINT_P(controller
                                                          .ACC_MOV_M_List[index].AMMID!,
                                                      controller.ACC_MOV_M_List[index].AMKID!,
                                                    );
                                                    controller.GET_ACC_MOV_D_P(
                                                        controller.ACC_MOV_M_List[index].AMKID.toString(),
                                                        controller.ACC_MOV_M_List[index].AMMID.toString());
                                                      // التحقق من حالة التوقيع
                                                      if (controller.UseSignature == 0 && controller.ShowSignatureAlert == 0) {
                                                        printReport();
                                                      } else if (controller.UseSignature == 1 && controller.ShowSignatureAlert == 0) {
                                                        controller.signature = await Navigator.push(context, MaterialPageRoute(builder: (_) => SignatureScreen()));
                                                        if (controller.signature != null) {
                                                          printReport();
                                                        }
                                                      } else {
                                                        Get.defaultDialog(
                                                          title: 'StringMestitle'.tr,
                                                          middleText: 'StringPrintSureSUID'.tr,
                                                          backgroundColor: Colors.white,
                                                          radius: 40,
                                                          textCancel: 'StringNo'.tr,
                                                          cancelTextColor: Colors.red,
                                                          textConfirm: 'StringYes'.tr,
                                                          confirmTextColor: Colors.white,
                                                          onConfirm: () async {
                                                            Navigator.of(context).pop(false);
                                                            controller.signature = await Navigator.push(context, MaterialPageRoute(builder: (_) => SignatureScreen()));
                                                            if (controller.signature != null) {
                                                              printReport();
                                                            }
                                                          },
                                                          onCancel: () {
                                                            printReport();
                                                          },
                                                        );

                                                    }



                                                  }

                                              },
                                              icon: Icon(
                                                  Icons.print,
                                                  size: 0.026 * height
                                              ),
                                            )
                                                : Container(),
                                          ),
                                          '${controller.ACC_MOV_M_List[index].AMMST}' !=
                                              '1'
                                              ? Expanded(
                                            child: IconButton(
                                                icon: Icon(
                                                    Icons.sync,
                                                    color: Colors.black,
                                                    size: 0.026 * height
                                                ),
                                                onPressed: () async {
                                                  Get.defaultDialog(
                                                    title: 'StringMestitle'.tr,
                                                    middleText:
                                                    'StringSuresyn'.tr,
                                                    backgroundColor:
                                                    Colors.white,
                                                    radius: 40,
                                                    textCancel: 'StringNo'.tr,
                                                    cancelTextColor: Colors.red,
                                                    textConfirm: 'StringYes'.tr,
                                                    confirmTextColor:
                                                    Colors.white,
                                                    onConfirm: () {
                                                      Navigator.of(context)
                                                          .pop(false);
                                                      controller
                                                          .Socket_IP_Connect(
                                                          'SyncOnly',
                                                          controller
                                                              .ACC_MOV_M_List[
                                                          index]
                                                              .AMMID
                                                              .toString(),
                                                          true);
                                                    },
                                                  );
                                                }),
                                          )
                                              : Expanded(
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                  top: 0.002 * height),
                                              child: Text(
                                                "${'StringDoSync'.tr} (${controller.ACC_MOV_M_List[index].ROWN1.toString()})",
                                                style: ThemeHelper().buildTextStyle(context, Colors.green,'M'),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      ACC_MOV_D(controller.ACC_MOV_M_List[index].AMKID,
                          controller.ACC_MOV_M_List[index].AMMID),
                    ],
                  ),
                ),
              );
            })),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.MainColor,
          onPressed: () {
            (Get.arguments == 1 || controller.AMKID == 1)
                ? controller.AMKID = 1
                : (Get.arguments == 2 || controller.AMKID == 2)
                ? controller.AMKID = 2
                : (Get.arguments == 3 || controller.AMKID == 3)
                ? controller.AMKID = 3
                : controller.AMKID = 15;
            print(Get.arguments);
            controller.AddPayOut();
          },
          label: Text(
            (Get.arguments != 15 || controller.AMKID != 15)
                ? 'StringAddPayOut'.tr
                : 'StringAddJournalVouchers'.tr,
            style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
          ),
          icon: const Icon(Icons.add, color: Colors.white),
        ),
          bottomNavigationBar: GetBuilder<Pay_Out_Controller>(
            init: Pay_Out_Controller(),
            builder: (controller) {
                return SalomonBottomBar(
                  currentIndex: controller.currentIndex,
                  selectedItemColor: Colors.pink,
                  onTap: (index) async {
                    setState(() {
                      controller.currentIndex = index;
                      controller.update();
                    });
                    await controller.GET_ACC_MOV_M_P('DateNow',controller.AMKID!);
                    controller.update();
                  },
                  items: [
                    /// Home
                    SalomonBottomBarItem(
                      icon: Icon(Icons.thermostat, color: Colors.black),
                      title: Text("${'StringAll'.tr} (${controller.ACC_MOV_M_List.length})"),
                      selectedColor: Colors.black,
                    ),
                    /// Operation
                    SalomonBottomBarItem(
                      icon: Icon(Icons.thermostat, color: Colors.green),
                      title: Text("${'Stringfinal'.tr} (${controller.ACC_MOV_M_List.length})"),
                      selectedColor: Colors.green,
                    ),
                    /// Reports
                    SalomonBottomBarItem(
                      icon: Icon(Icons.thermostat, color: Colors.red),
                      title: Text("${'StringNotfinal'.tr} (${controller.ACC_MOV_M_List.length})"),
                      selectedColor: Colors.red,
                    ),
                    /// Settings
                    SalomonBottomBarItem(
                      icon: Icon(Icons.thermostat, color: Colors.blueAccent),
                      title: Text("${'StringPending'.tr} (${controller.ACC_MOV_M_List.length})"),
                      selectedColor: Colors.blueAccent,
                    ),
                  ],
                );
               // إرجاع عنصر فارغ إذا لم يكن الشرط صحيحًا
            },
          ),
      ),
    );
  }

  GetBuilder<Pay_Out_Controller> ACC_MOV_D(AMKID,AMMID) {
    return GetBuilder<Pay_Out_Controller>(
        init: Pay_Out_Controller(),
        builder: ((controller) => FutureBuilder<List<Acc_Mov_D_Local>>(
          future: GET_ACC_MOV_D(AMKID.toString(),AMMID.toString()),
          builder: (BuildContext context, AsyncSnapshot<List<Acc_Mov_D_Local>> snapshot) {
            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Container(); // إرجاع عنصر فارغ إذا لم توجد بيانات
            }
            return SizedBox(
              height: 30,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                // shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: snapshot.data!.length,
                itemBuilder: (BuildContext context, int index) {
                  final item = snapshot.data![index];
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 3),
                    child: TextButton(
                      onPressed: () {},
                      style:
                      TextButton.styleFrom(
                        side:  BorderSide(color:Colors.black45),
                         backgroundColor: Colors.white,
                        shape:RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8), // <-- Radius
                        ),
                      ),
                      child:  item.SCSY.toString()=='SAR'?
                      Row(children: [
                        Text(
                          "${item.AANA_D.toString()} (${controller.formatter.format(controller.roundDouble(item.AMDMD != 0.0 ? item.AMDMD! : item.AMDDA!, 3)).toString()}) ",
                          style: ThemeHelper().buildTextStyle(
                            context, Colors.black, 'S',
                          ),
                          //overflow: TextOverflow.ellipsis,
                          // maxLines: 1,
                        ),
                        Image.asset(
                          "${ImagePath}Saudi_Riyal_Symbol.png",
                          //child: Image.asset("/data/data/com.elitesoftsys.emobilepro/app_flutter/2023_05_13_11_53_28.png",
                          fit: BoxFit.cover,
                          height: 15,
                        ),
                      ],) :
                      Text(
                        "${item.AANA_D.toString()} (${controller.formatter.format(controller.roundDouble(item.AMDMD != 0.0 ? item.AMDMD! : item.AMDDA!, 3)).toString()}) ${item.SCSY.toString()}",
                        style: ThemeHelper().buildTextStyle(
                          context, Colors.black, 'S',
                        ),
                        //overflow: TextOverflow.ellipsis,
                        // maxLines: 1,
                      ),
                    ),
                  );
                },
              ),
            );
          },
        )
        ));
  }

  void printReport() {
    Timer(const Duration(milliseconds: 100), () async {
      final report = StteingController().Thermal_printer_paper_size == '58'
          ? taxTikcetReportThermal
          : taxTikcetReportThermal;
      report(
        mode: ShareMode.print,
        msg: 'مرحبا',
        orderDetails: controller.ACC_MOV_M_PRINT,
        Type_Rep:StteingController().Thermal_printer_paper_size == '58'? '2':'1'
      );
    });
  }

  buildPdf_vouchers_samplie(int index) {
    Timer(const Duration(milliseconds: 100), () async {
      Pdf_Vouchers_Samplie(
          ListAcc_Mov_M: controller.ACC_MOV_M_PRINT,
          GetAMKID: controller.ACC_MOV_M_List[index].AMKID.toString(),
          mode: ShareMode.view);
    });
  }


  Widget _buildFilterContent(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return GetBuilder<Pay_Out_Controller>(
        builder: ((controller) =>
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  SizedBox(height: 0.01 * height),
                  _buildDoubleInputRow(
                    DropdownBra_InfBuilder_f(context),
                    DropdownBra_Inf_ToBuilder(context),
                  ),
                  SizedBox(height: 0.02 * height),
                  // التاريخ
                  // _buildSectionHeader('التاريخ'),
                  _buildDoubleInputRow(
                    _buildDateField('StringFROM'.tr, controller.FromDaysController, context,
                            () => controller.selectDateFromDays_F(context)),
                    _buildDateField('StringBPID_TlableText'.tr,  controller.ToDaysController, context,
                            () => controller.selectDateToDays(context)),
                  ),
                  SizedBox(height: 0.02 * height),
                  // // رقم الوثيقة
                  // _buildSectionHeader('رقم الوثيقة'),
                  // _buildDoubleInputRow(
                  //   _buildNumberField('من', context),
                  //   _buildNumberField('الى', context),
                  // ),

                  // طريقة الدفع والعملة
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                            margin: EdgeInsets.only(left: 0.02 * height),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular( 0.02 * height)),
                            child:  DropdownSYS_CUR_SBuilder(context)
                        ),
                      ),
                    ],
                  ),

                  // _buildSectionHeader('طريقة الدفع'),
                  // DropdownPAY_KIN_SBuilder(),
                  // const SizedBox(height: 2),
                  // _buildSectionHeader('العملة'),
                  // DropdownSYS_CUR_SBuilder(context),

                  // الأزرار
                  SizedBox(height: 0.02 * height),
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
                      SizedBox(width: 0.04 * height),
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
                  ),
                  SizedBox(height: 0.02 * height),
                  OutlinedButton.icon(
                    // icon: Icon(Icons.refresh, color: Colors.red[800]),
                    label: Text('StringShowAll'.tr,
                        style: TextStyle(color: Colors.red[800])),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      side: BorderSide(color: Colors.red[800]!),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    onPressed: () async {
                      controller.TYPE_SER=1;
                      await controller.GET_ACC_MOV_M_P("DateNow",controller.AMKID!);
                    },
                  ),
                  // ElevatedButton.icon(
                  //  // icon: const Icon(Icons.check, color: Colors.white),
                  //   label: Text('StringShowAll'.tr,
                  //       style: TextStyle(color: Colors.white)),
                  //   style: ElevatedButton.styleFrom(
                  //     backgroundColor: Colors.red[800],
                  //     padding: const EdgeInsets.symmetric(vertical: 15),
                  //     shape: RoundedRectangleBorder(
                  //       borderRadius: BorderRadius.circular(10),
                  //     ),
                  //     elevation: 3,
                  //   ),
                  //   onPressed: () async {
                  //     controller.TYPE_SER=1;
                  //     await controller.get_BIL_MOV_M("DateNow");
                  //   },
                  // ),
                ],
              ),
            ))
    );
  }

  Widget _buildDoubleInputRow(Widget first, Widget second) {
    double height = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(left: 0.02 * height),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular( 0.02 * height)),
                  child: first
              ),
            ),
            Expanded(
              child: Container(
                  margin: EdgeInsets.only(right: 0.02 * height),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0.02 * height)),
                  child: second
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDateField(String label, TextEditingController controller2,BuildContext context,
      Function  onTap) {
    double height = MediaQuery.of(context).size.height;
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.02 * height),
          borderSide: BorderSide(color: Colors.red),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(0.02 * height)),
        ),
        suffixIcon: const Icon(Icons.calendar_today),
      ),
      readOnly: true,
      controller:controller2,
      onTap: () => onTap(),
    );
  }


  Future<void> _resetFilters() async {
    setState(() {
      controller.selectedBranchFrom = null;
      controller.selectedBranchTo = null;
      controller.SelectDataSCID_S = null;
      controller.FromDaysController.text = controller.SER_DA;
      controller.ToDaysController.text = controller.SER_DA;
    });
    controller.TYPE_SER=2;
    await controller.GET_ACC_MOV_M_P("DateNow",controller.AMKID!);
  }

  Future<void> _applyFilters(BuildContext context) async {
    controller.TYPE_SER=2;
    await controller.GET_ACC_MOV_M_P("DateNow",controller.AMKID!);
    Navigator.pop(context);
    // تطبيق الفلاتر هنا
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_InfBuilder_f(BuildContext context) {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(1),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringFROM'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringFromBrach', Colors.grey,'S'),
            value: controller.selectedBranchFrom,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
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
              controller.selectedBranchFrom = value.toString();
            },
          );
        });
  }

  FutureBuilder<List<Bra_Inf_Local>> DropdownBra_Inf_ToBuilder(BuildContext context) {
    return FutureBuilder<List<Bra_Inf_Local>>(
        future:  GET_BRA(2),
        builder: (BuildContext context,
            AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return  DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringBPID_TlableText'.tr),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringToBrach', Colors.grey,'S'),
            value: controller.selectedBranchTo,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.BIID.toString(),
              child: Text(
                item.BINA_D.toString(),
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
              controller.selectedBranchTo = value.toString();
            },
          );
        });
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CUR_SBuilder(BuildContext context) {
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
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown("${'StringSCIDlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
            value: controller.SelectDataSCID_S,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.SCID.toString(),
              child: Text(
                item.SCNA_D.toString(),
                style:ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            onChanged: (value) {
              controller.SelectDataSCID_S = value.toString();
            },
          );
        });
  }


}
