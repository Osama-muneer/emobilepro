import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../routes/routes.dart';
import '../../Controllers/counter_sale_approving_controller.dart';
class Approve_View extends StatefulWidget {
  @override
  State<Approve_View> createState() => _Approve_ViewState();
}

class _Approve_ViewState extends State<Approve_View> {
  final Counter_Sales_Approving_Controller controller = Get.find();
  late search.SearchBar searchBar;
  String query = '';
  DateTime DateDays = DateTime.now();
  DateTime DateDays_last = DateTime.now();
  final txtController = TextEditingController();
  @override
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
              ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(
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
          controller.GET_BIF_COU_M_P("FromDate");
        });
      });
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: Text(
          'StringCounterSalePosting'.tr,
          style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
        ),
        backgroundColor: AppColors.MainColor,
        actions: [
          IconButton(
              icon: Icon(Icons.sync_rounded,color: Colors.white),
              onPressed: () async {
                if (controller.COUNT_BMMID! > 0) {
                  Fluttertoast.showToast(
                      msg: 'StringChick_BMMID'.tr,
                      toastLength: Toast.LENGTH_LONG,
                      textColor: Colors.white,
                      backgroundColor: Colors.redAccent);
                }
                else {
                  if (controller.BIF_COU_M_List.length > 0) {
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
                        controller.Socket_IP_Connect('SyncAll', '');
                      },
                      // barrierDismissible: false,
                    );
                  }
                }
              }),
          Row(
            children: [
              searchBar.getSearchAction(context),
              PopupMenuButton(
                enableFeedback: true,
                initialValue: 0,
                elevation: 0.0,
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.GET_BIF_COU_M_P("ALL");
                          Navigator.of(context).pop(false);
                          // Get.offAndToNamed(Routes.Inventory);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          'StringShowAll'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.GET_BIF_COU_M_P("DateNow");
                          Navigator.of(context).pop(false);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          'StringDateNow'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectDataFromDate(context);
                        });
                      },
                      child: ListTile(
                        title: Text(
                          'StringSerDate'.tr,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]);
  }

  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  void searchRequestData(String query) {
    final listDatacustmoerRequest = controller.BIF_COU_M_List.where((list) {
      final titleLower = list.BCMNO.toString().toLowerCase();
      final authorLower = list.BCMFD.toString().toLowerCase();
      final author2Lower = list.BCMTD!.toString().toLowerCase();
      final author3Lower = list.BPNA_D!.toString().toLowerCase();
      final author4Lower = list.BINA_D!.toString().toLowerCase();
      final author5Lower = list.CTMNA_D!.toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          author2Lower.contains(searchLower) ||
          author3Lower.contains(searchLower) ||
          authorLower.contains(searchLower) ||
          author4Lower.contains(searchLower) ||
          author5Lower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      controller.BIF_COU_M_List = listDatacustmoerRequest;
      if (query == '') {
        controller.GET_BIF_COU_M_P("DateNow");
      }
    });
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
            controller.GET_BIF_COU_M_P("DateNow");
            controller.update();
          });
          print("cleared");
        },
        onClosed: () {
          setState(() {
            controller.GET_BIF_COU_M_P("DateNow");
            controller.update();
          });
          print("closed");
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _SearchBarDemoHomeState();
  }

  Future<bool> onWillPop() async {
    Navigator.of(context).pop(false);
    final shouldPop = await Get.offAllNamed(Routes.Home);
    return shouldPop ?? false;
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: searchBar.build(context),
        body: GetBuilder<Counter_Sales_Approving_Controller>(
            init: Counter_Sales_Approving_Controller(),
            builder: ((value) {
          if (controller.BIF_COU_M_List.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "${ImagePath}no_data.png",
                    height: 0.1 * height,
                  ),
                  Text(
                    'StringNoData'.tr,
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'L')
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.BIF_COU_M_List.length,
            itemBuilder: (BuildContext context, int index) => Card(
              child: InkWell(
                onTap: () {
                  if (controller.BIF_COU_M_List[index].BCMST.toString() != '1') {
                    controller.EditApprove(controller.BIF_COU_M_List[index]);
                  }},
                child: Container(
                  width: double.infinity,
                  height:  0.2 * height,
                  color:  Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            Text(
                              controller.BIF_COU_M_List[index].BINA_D
                                  .toString(),
                              style: ThemeHelper().buildTextStyle(context, Colors.black,
                                  controller.BIF_COU_M_List[index].BINA_D.toString().length >= 45
                                      ? 'S' : 'M' )
                            ),
                            Text(
                                controller.BIF_COU_M_List[index].BPNA_D
                                    .toString(),
                                style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                            Text(
                                controller.BIF_COU_M_List[index].SCNA_D
                                    .toString(),
                                style: ThemeHelper().buildTextStyle(context, Colors.black,'M')
                              ),
                            Text(
                                '${controller.BIF_COU_M_List[index].BCMST}'
                                    .toString() ==
                                    '2'
                                    ? 'StringNotfinal'.tr
                                    : '${controller.BIF_COU_M_List[index].BCMST}'
                                    .toString() ==
                                    '3'
                                    ? 'StringPending'.tr
                                    : 'Stringfinal'.tr,
                                style: '${controller.BIF_COU_M_List[index].BCMST}'
                                    .toString() ==
                                    '2'
                                    ? ThemeHelper().buildTextStyle(context, Colors.red,'M')
                                    : '${controller.BIF_COU_M_List[index].BCMST}'
                                    .toString() ==
                                    '3'
                                    ? ThemeHelper().buildTextStyle(context, Colors.blueAccent,'M')
                                    : ThemeHelper().buildTextStyle(context, Colors.green,'M')
                               ),
                          ],
                        ),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Text(
                            controller.BIF_COU_M_List[index].BCMID.toString(),
                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                          ),
                          Text(
                              controller.BIF_COU_M_List[index].BCMFD.toString().substring(0, 10),
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                          Text(
                              controller.BIF_COU_M_List[index].BCMTD.toString().substring(0, 10),
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                          Text(
                              controller.BIF_COU_M_List[index].BCMRN.toString(),
                              style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                          // InkWell(
                          //   onTap: () {},
                          //   child: Row(
                          //     children: <Widget>[
                          //       Icon(
                          //         Icons.picture_as_pdf,
                          //         size: Dimensions.iconSize24,
                          //         color: Colors.blue,
                          //       ),
                          //       SizedBox(
                          //         width: Dimensions.height5,
                          //       ),
                          //       Text(
                          //         'StringPrint'.tr,
                          //         style: TextStyle(
                          //           fontWeight: FontWeight.bold,
                          //           color: Colors.blueAccent,
                          //           fontSize: Dimensions.font17,
                          //         ),
                          //       )
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            '${controller.BIF_COU_M_List[index].BCMST}' != '1'
                                ? Expanded(
                              child: Column(
                                children: [
                                  Expanded(
                                    child: IconButton(
                                      onPressed: () async {
                                        if (controller.BIF_COU_M_List[index].BCMST
                                            .toString() !=
                                            '1') {
                                          controller.EditApprove(
                                              controller.BIF_COU_M_List[index]);
                                        }
                                      },
                                      icon: Icon(
                                        Icons.edit,
                                        size: 0.026 * height,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                          size: 0.026 * height,
                                        ),
                                        onPressed: () async {
                                          Get.defaultDialog(
                                            title: 'StringMestitle'.tr,
                                            middleText: 'StringDeleteMessage'.tr,
                                            backgroundColor: Colors.white,
                                            radius: 40,
                                            textCancel: 'StringNo'.tr,
                                            cancelTextColor: Colors.red,
                                            textConfirm: 'StringYes'.tr,
                                            confirmTextColor: Colors.white,
                                            onConfirm: () {
                                              bool isValid =
                                              controller.delete_BIF_COU(
                                                  controller
                                                      .BIF_COU_M_List[index]
                                                      .BCMID,
                                                  2);
                                              if (isValid) {
                                                controller
                                                    .GET_BIF_COU_M_P("DateNow");
                                                controller.update();
                                              }
                                              Navigator.of(context).pop(false);
                                            },
                                          );
                                        }),
                                  ),
                                  '${controller.BIF_COU_M_List[index].BCMST}' ==
                                      '2'
                                      ? Expanded(
                                    child: IconButton(
                                        icon: Icon(
                                          Icons.sync,
                                          color: Colors.black,
                                          // size: Dimensions.iconSize24,
                                        ),
                                        onPressed: () async {
                                          if (controller.COUNT_BMMID! > 0) {
                                            Fluttertoast.showToast(
                                                msg: 'StringChick_BMMID'.tr,
                                                toastLength:
                                                Toast.LENGTH_LONG,
                                                textColor: Colors.white,
                                                backgroundColor:
                                                Colors.redAccent);
                                          } else {
                                            Get.defaultDialog(
                                              title: 'StringMestitle'.tr,
                                              middleText:
                                              'StringSuresyn'.tr,
                                              backgroundColor: Colors.white,
                                              radius: 40,
                                              textCancel: 'StringNo'.tr,
                                              cancelTextColor: Colors.red,
                                              textConfirm: 'StringYes'.tr,
                                              confirmTextColor:
                                              Colors.white,
                                              onConfirm: () {
                                                Navigator.of(context)
                                                    .pop(false);
                                                controller.Socket_IP_Connect('SyncOnly',
                                                    controller.BIF_COU_M_List[index].BCMID.toString());
                                              },
                                            );
                                          }
                                        }),
                                  )
                                      : Text(""),
                                ],
                              ),
                            )
                                : Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 0.16 * height),
                                child: Text(
                                  "${'StringDoSync'.tr} (${controller.BIF_COU_M_List[index].BCMNR.toString()})",
                                  style: ThemeHelper().buildTextStyle(context, Colors.green,'M'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        })),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.MainColor,
          onPressed: () {
             if (controller.BYST == 2) {
              Get.snackbar('StringByst_Mes'.tr, 'String_CHK_Byst'.tr,
                  backgroundColor: Colors.red,
                  icon: Icon(Icons.error, color: Colors.white),
                  colorText: Colors.white);
            } else if (controller.UPIN == 2) {
              Get.snackbar('StringUPIN'.tr, 'String_CHK_UPIN'.tr,
                  backgroundColor: Colors.red,
                  icon: Icon(Icons.error, color: Colors.white),
                  colorText: Colors.white,
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.easeOutBack);
            } else {
              controller.titleScreen = '';
              controller.BCMTAController.text = '0.0';
              controller.BCMAM1Controller.text = '0.0';
              controller.BCMAM2Controller.text = '0.0';
              controller.BCMAM3Controller.text = '0.0';
              controller.SUMCredit = 0.0;
              controller.SUMCredit2 = 0.0;
              controller.SUMCredit3 = 0.0;
              controller.update();
              controller.buildShowSetting();
            }
          },
          label: Text('StrinAdd_Approving'.tr,style: TextStyle(color: Colors.white),),
          icon: Icon(Icons.add,color: Colors.white),
          // backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}

// class SettingInvoicesHelper {
//   final cou_sales_invoice_controller controller = Get.find();
//
// }
