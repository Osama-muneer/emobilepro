import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'dart:ui' as UI;
import '../../../PrintFile/Store/store_view_simple.dart';
import '../../../PrintFile/share_mode.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/pdf.dart';
import '../../../Widgets/pdfpakage.dart';
import '../../../Widgets/theme_helper.dart';
import '../../Controllers/inventory_controller.dart';

class InventoryView extends StatefulWidget {
  @override
  State<InventoryView> createState() => _InventoryViewState();
}

class _InventoryViewState extends State<InventoryView> {
  final InventoryController controller = Get.find();
  DateTime DateDays = DateTime.now();
  DateTime DateDays_last = DateTime.now();
  UI.TextDirection direction = UI.TextDirection.rtl;
  late search.SearchBar searchBar;
  String query = '';
  int check = 0;
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
  void configloading(){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 2000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.redAccent
      ..indicatorColor = Colors.white
      ..textColor = Colors.white
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = false;
    EasyLoading.showError("خطأ في المزامنة");
  }
  void searchRequestData(String query) {
    final listDatacustmoerRequest = controller.STO_MOV_M_List.where((list) {
      final titleLower = list.BINA_D.toString().toLowerCase();
      final authorLower = list.SINA_D.toString().toLowerCase();
      final author2Lower = list.SMMNO!.toString().toLowerCase();
      final author3Lower = list.SMMDO!.toString().toLowerCase();
      final searchLower = query.toLowerCase();

      return titleLower.contains(searchLower) ||
          author2Lower.contains(searchLower) ||
          author3Lower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      controller.STO_MOV_M_List = listDatacustmoerRequest;
      if (query == '') {
        controller.GETSTO_MOV_M_P("ALL");
      }
    });
  }

  final txtController = TextEditingController();

  Future<void> _selectDataFromDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateDays,
        firstDate: DateTime(2020, 5),
        lastDate: DateTime(3000),
        builder: (context, child) {
      return   Theme(
        data: ThemeData.light().copyWith(
            primaryColor: const Color(0xFF4A5BF6),
            colorScheme: ColorScheme.fromSwatch(primarySwatch: buttonTextColor).copyWith(secondary: const Color(0xFF4A5BF6))//selection color
        ),
        child: child!,
      );
    },);
    if (picked != null) {
      setState(() {
        DateDays = picked;
        String formattedDate = DateFormat('dd-MM-yyyy').format(picked);
        controller.SelectNumberOfDays = formattedDate;
        setState(() {
          controller.GETSTO_MOV_M_P("FromDate");
        });
      });
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text(
          controller.SMKID==17?'StringInventory'.tr:controller.SMKID==1?'StringItem_In_Voucher'.tr:controller.SMKID==3?'StringItem_Out_Voucher'.tr:
          controller.SMKID==11?'StringTransfer_Store_Request'.tr: controller.SMKID==131?
          'StringTransfer_Store_Branches'.tr:
          controller.SMKID==0?'StringIncoming_Store'.tr:'StringInventoryTransferVoucher'.tr,
          style: TextStyle(fontSize: 18,color: Colors.white),
        ),
        backgroundColor: AppColors.MainColor,
        iconTheme: IconThemeData(
            color: Colors.white
        ),
        actions: [
          IconButton(
              icon: Icon(Icons.sync_rounded,color: Colors.white),
              onPressed: () async {
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
                              controller.Socket_IP_Connect('SyncAll', '',true);
                            },
                            // barrierDismissible: false,
                          );
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
                          controller.GETSTO_MOV_M_P("ALL");
                          Navigator.of(context).pop(false);
                          // Get.offAndToNamed(Routes.Inventory);
                        });
                      },
                      child: ListTile(
                        title:  Text(
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
                          controller.GETSTO_MOV_M_P("DateNow");
                          Navigator.of(context).pop(false);
                        });
                      },
                      child: ListTile(
                        title:  Text(
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
                        title:  Text(
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
    setState(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You wrote $value!'))));
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
            controller.GETSTO_MOV_M_P("ALL");
          });
          print("cleared");
        },
        onClosed: () {
          check = 1;
          setState(() {
            controller.GETSTO_MOV_M_P("ALL");
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
    Get.back();
    final shouldPop = await Get.offAllNamed('/Home');
    return shouldPop ?? false;
  }


  static const Color grey_5 = Color(0xFFf2f2f2);
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: grey_5,
        appBar: searchBar.build(context),
        body: GetBuilder<InventoryController>(
            init: InventoryController(),
            builder: ((value) {
              if (controller.STO_MOV_M_List.isEmpty) {
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
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ],
                  ),
                );
              }
              return  ListView.builder(
                itemCount: controller.STO_MOV_M_List.length,
                itemBuilder: (BuildContext context, int index) => Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0.02 * height),),
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: InkWell(
                    onTap: () {
                      if (controller.STO_MOV_M_List[index].SMMST.toString() != '1') {
                        controller.EditInventory(controller.STO_MOV_M_List[index]);
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: controller.SMKID==17?0.18 * height:0.18 * height,
                      color: Colors.white,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                // controller.STO_MOV_M_List[index].BINA_D.toString().length >= 30? Marquee(
                                //   text: controller.STO_MOV_M_List[index].BINA_D.toString(),
                                //   style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                                //   scrollAxis: Axis.horizontal,
                                //   blankSpace: 20.0,
                                //   velocity: 50.0,
                                // ):
                                Text(controller.STO_MOV_M_List[index].BINA_D.toString(),
                                  style: ThemeHelper().buildTextStyle(context, Colors.black,
                                      controller.STO_MOV_M_List[index].BINA_D.toString().length >= 30
                                          ? 'S' : 'M')
                                ),
                                Text(
                                    '${controller.STO_MOV_M_List[index].SINA_D.toString()}',
                                    style: ThemeHelper().buildTextStyle(context, Colors.black,
                                        controller.STO_MOV_M_List[index].SINA_D.toString().length >= 30
                                            ? 'S' : 'M')),
                                controller.SMKID==17?Container():Text(
                                    '${controller.STO_MOV_M_List[index].SCNA_D.toString()}',
                                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                Text(
                                    '${controller.STO_MOV_M_List[index].SMMST}'.toString() == '2' ? 'StringNotfinal'.tr
                                        : '${controller.STO_MOV_M_List[index].SMMST}'.toString() == '3'
                                        ? 'StringPending'.tr : 'Stringfinal'.tr,
                                    style:
                                        '${controller.STO_MOV_M_List[index].SMMST}'.toString() == '2'
                                        ? ThemeHelper().buildTextStyle(context, Colors.red,'M')
                                        : '${controller.STO_MOV_M_List[index].SMMST}'.toString() == '3'
                                        ? ThemeHelper().buildTextStyle(context, Colors.blueAccent,'M')
                                        : ThemeHelper().buildTextStyle(context, Colors.green,'M')
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  '${controller.STO_MOV_M_List[index].SMMNO.toString()}',
                                  style:  ThemeHelper().buildTextStyle(context, Colors.black,'M')
                                ),
                                Text(controller.SMKID==17? controller.STO_MOV_M_List[index].SMMDO.toString().substring(0, 10):
                                 controller.SMKID==13 || controller.SMKID==11 || controller.SMKID==131?
                                 controller.STO_MOV_M_List[index].SIIDT_D.toString():
                                 controller.STO_MOV_M_List[index].AANA_D.toString(),
                                    style: ThemeHelper().buildTextStyle(context, Colors.black,
                                      controller.STO_MOV_M_List[index].AANA_D
                                          .toString().length >= 35 ||
                                          controller.STO_MOV_M_List[index].SIIDT_D.toString().length >= 35
                                          ? 'S'
                                          : 'M',)
                                ),
                                controller.SMKID==17?Container():Text( controller.STO_MOV_M_List[index].SMMDO.toString().substring(0, 10),
                                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                InkWell(
                                  onTap: () async {
                                    if (controller.UPPR == 1) {
                                      if(controller.SMKID==17){
                                        controller.FetchPdfData(int.parse(controller.STO_MOV_M_List[index].SMMID.toString()));
                                        Timer(Duration(seconds: 2), ()async {
                                          final pdfFile = await Pdf.Inventory_Pdf(
                                              controller.STO_MOV_M_List[index].SMMDO.toString().substring(0, 11),
                                              controller.STO_MOV_M_List[index].SMMNO.toString(),
                                              controller.STO_MOV_M_List[index].SINA_D.toString(),
                                              controller.STO_MOV_M_List[index].BINA_D.toString(),
                                              controller.SDDSA,
                                              controller.SONA,
                                              controller.SONE,
                                              controller.SORN,
                                              controller.SOLN,
                                              'INVC-17',
                                              LoginController().SUNA,
                                              controller.P_PR_REP);
                                          PdfPakage.openFile(pdfFile);
                                        });
                                      }
                                      else{
                                        controller.GET_STO_MOV_M_PRINT_P(controller.STO_MOV_M_List[index].SMKID!,
                                            controller.STO_MOV_M_List[index].SMMID!);
                                        await Future.delayed(const Duration(seconds: 2));
                                        print('GET_STO_MOV_M_PRINT_P');
                                        Pdf_Inventory_Samplie(
                                            GetSMKID: controller.STO_MOV_M_List[index].SMKID,
                                            P_PR_REP:  controller.P_PR_REP,
                                            mode: ShareMode.view);
                                        print('GET_STO_MOV_M_PRINT_P22222');
                                      }
                                    } else {
                                      Get.snackbar('StringUPPR'.tr, 'String_CHK_UPPR'.tr, backgroundColor: Colors.red,
                                          icon: Icon(Icons.error, color: Colors.white), colorText: Colors.white);
                                    }
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Icon(
                                        Icons.picture_as_pdf,
                                        size: 0.026 * height,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 0.004 * height,
                                      ),
                                      ThemeHelper().buildText(context,'StringPrint', Colors.blueAccent,'M'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                              Expanded(
                                child: Column(
                                children: [
                                if('${controller.STO_MOV_M_List[index].SMMST}' == '3')
                                Expanded(
                                  child: IconButton(
                                    onPressed: () async {
                                      controller.EditInventory(controller.STO_MOV_M_List[index]);},
                                    icon: Icon(Icons.edit),
                                  ),
                                ),
                                if('${controller.STO_MOV_M_List[index].SMMST}' == '3')
                                Expanded(
                                  child: IconButton(
                                      icon: Icon(Icons.delete, color: Colors.red,size: 0.026 * height),
                                      onPressed: () async {
                                        Get.defaultDialog(
                                          title: 'StringMestitle'.tr,
                                          // titleStyle: TextStyle(),
                                          middleText: 'StringDeleteMessage'.tr,
                                          backgroundColor: Colors.white,
                                          radius: 40,
                                          textCancel: 'StringNo'.tr,
                                          cancelTextColor: Colors.red,
                                          textConfirm: 'StringYes'.tr,
                                          confirmTextColor: Colors.white,
                                          onConfirm: () {
                                            bool isValid =
                                            controller.delete_STO_MOV_M(controller.STO_MOV_M_List[index].SMMID, 2);
                                            if (isValid) {
                                              controller.GETSTO_MOV_M_P("ALL");
                                            }
                                            Navigator.of(context).pop(false);
                                          },
                                        );
                                      }),
                                ),
                                if('${controller.STO_MOV_M_List[index].SMMST}' == '2')
                                    Expanded(
                                  child: IconButton(
                                      icon: Icon(
                                        Icons.sync,
                                        color: Colors.black,
                                      ),
                                      onPressed: () async {
                                        Get.defaultDialog(
                                          title: 'StringMestitle'.tr,
                                          middleText: 'StringSuresyn'.tr,
                                          backgroundColor: Colors.white,
                                          radius: 40,
                                          textCancel: 'StringNo'.tr,
                                          cancelTextColor: Colors.red,
                                          textConfirm: 'StringYes'.tr,
                                          confirmTextColor: Colors.white,
                                          onConfirm: () {
                                            Navigator.of(context).pop(false);
                                            controller.Socket_IP_Connect('SyncOnly', controller.STO_MOV_M_List[index].SMMID.toString(),true);
                                          },
                                        );
                                      }),
                                ),
                                  if('${controller.STO_MOV_M_List[index].SMMST}' == '1')
                                    Expanded(
                                      child:   IconButton(
                                          icon: Icon(
                                            Icons.settings_backup_restore,
                                            color: Colors.black,
                                            size: 0.026 * height,
                                          ),
                                          onPressed: () async {
                                            Get.defaultDialog(
                                              title: 'StringMestitle'.tr,
                                              middleText: 'StringSuresyn'.tr,
                                              backgroundColor: Colors.white,
                                              radius: 40,
                                              textCancel: 'StringNo'.tr,
                                              cancelTextColor: Colors.red,
                                              textConfirm: 'StringYes'.tr,
                                              confirmTextColor:
                                              Colors.white,
                                              onConfirm: () {
                                                Get.back();
                                                controller.Socket_IP_Connect('SyncOnly', controller.STO_MOV_M_List[index].SMMID.toString(),true);
                                              },
                                            );
                                          }),
                                    ),
                                  if('${controller.STO_MOV_M_List[index].SMMST}' == '1')
                                    Expanded(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                          top: 0.02 * height),
                                      child: Text('StringDoSync'.tr,
                                        style: TextStyle(fontSize: 16,
                                            fontWeight: FontWeight.bold, color: Colors.green),
                                      ),
                                    ),
                                  )
                                ],
                                ),
                              )
                             ,
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
            } else {
              controller.AddInventory();
            }
          },
          label: Text('StringAdd'.tr,style: TextStyle(color:Colors.white),),
          icon: Icon(Icons.add,color: Colors.white),
          // backgroundColor: Colors.blue,
        ),
      ),
    );
  }
}
