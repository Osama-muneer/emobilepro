import 'dart:async';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:emobilepro/Widgets/app_extension.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Operation/Views/SaleInvoices/return_sale_invoices_view.dart';
import '../../../PrintFile/Invoice/generate_invoice.dart';
import '../../../PrintFile/share_mode.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Setting/models/bil_poi.dart';
import '../../../Setting/models/bra_inf.dart';
import '../../../Setting/models/cou_typ_m.dart';
import '../../../Setting/models/pay_kin.dart';
import '../../../Setting/models/res_sec.dart';
import '../../../Setting/models/sto_inf.dart';
import '../../../Setting/models/sys_cur.dart';
import '../../../Widgets/AnimatedTextWidget.dart';
import '../../../Packages/ES_FAT_PKG.dart';
import '../../../Widgets/clipper.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/invoices_db.dart';
import '../../../database/setting_db.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Widgets/config.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:intl/intl.dart';
import '../../models/bil_mov_d.dart';
import 'Filter_Sale.dart';

class Sale_Invoices_view extends StatefulWidget {
  const Sale_Invoices_view({Key? key}) : super(key: key);

  @override
  State<Sale_Invoices_view> createState() => _Sale_Invoices_viewState();
}

class _Sale_Invoices_viewState extends State<Sale_Invoices_view> {
  final Sale_Invoices_Controller controller = Get.find();
  // final Sale_Invoices_Controller controller = Get.put(Sale_Invoices_Controller());
  late search.SearchBar searchBar;
  String query = '';
  DateTime DateDays = DateTime.now();
  DateTime DateDays_last = DateTime.now();
  final txtController = TextEditingController();
  static const Color grey_5 = Color(0xFFf2f2f2);



  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(color: Colors.white),
      automaticallyImplyLeading:  STMID=='EORD'?false:true,
      title: Text(
        controller.BMKID==3?'StringSale_Invoices'.tr:
        controller.BMKID==1?'StringPurchases_Invoices'.tr:
        controller.BMKID==2?'StringReturn_Purchase'.tr:
        controller.BMKID==4?'StringReturn_Sale_Invoices'.tr:
        controller.BMKID==7?'StringQuotations'.tr:
        controller.BMKID==10?'StringCustomer_Requests'.tr:
        controller.BMKID==12?'StringReturn_Sale_Invoices_POS'.tr:
        controller.BMKID==5?'StringService_Bills'.tr:
        STMID=='COU'?'StringCounterSalePosting_REP'.tr
            :'StringPOS'.tr,
        style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),
      ),
      backgroundColor: AppColors.MainColor,
      actions: [
        IconButton(
            icon: const Icon(Icons.sync_rounded,color: Colors.white),
            onPressed: () async {
              if (controller.BIL_MOV_M_List.isNotEmpty) {
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
                    Get.back();
                    controller.Socket_IP_Connect('SyncAll', '',true,2);
                  },
                  // barrierDismissible: false,
                );
              }
            }),
        IconButton(
          icon: const Icon(Icons.picture_as_pdf_sharp,color: Colors.white),
          onPressed: () async {
            await generateReportFromDatabase(
                TAB_N:[11,12].contains(controller.BMKID) ? 'BIF_MOV_M' : 'BIL_MOV_M',
                TAB_D: [11,12].contains(controller.BMKID) ? 'BIF_MOV_D' : 'BIL_MOV_D',
                GETBMKID: controller.BMKID!,
                TYPE: controller.TYPE_SHOW,
                GETDateNow: controller.TYPE_SHOW == "DateNow" ? DateFormat('dd-MM-yyyy').format(DateTime.now()) :
                controller.TYPE_SHOW == "FromDate" ? controller.SelectNumberOfDays : '',
                GETBMMST: controller.currentIndex,BMMDO_F: controller.FromDaysController.text,
                BMMDO_T:controller.ToDaysController.text,SCID_V: controller.SelectDataSCID_S.toString(),
                PKID_V: controller.SelectDataPKID_S.toString(),TYPE_SER: controller.TYPE_SER!,
                 BIID_F: controller.selectedBranchFrom.toString(), BIID_T: controller.selectedBranchTo.toString()
            );
          },
        ),
        searchBar.getSearchAction(context),
        IconButton(
          icon: const Icon(Icons.filter_list),
          onPressed: () => Fliter_Sales().showFilterSheet(context),
        ),
        // PopupMenuButton<int>(
        //   color: Colors.white,
        //   enableFeedback: true,
        //   initialValue: 0,
        //   elevation: 0.0,
        //   itemBuilder: (BuildContext context) {
        //     // بناء القائمة ديناميكيًا هنا
        //     return buildPopupMenuItems();
        //   },
        //   // itemBuilder: (BuildContext context) {
        //   //   return _popupMenuItems.where((item) => _shouldShowMenuItem).toList();
        //   // },
        //   onSelected: (int value) {
        //     print('value');
        //     print(value);
        //     if(value==1){
        //       controller.TYPE_SHOW="ALL";
        //       controller.get_BIL_MOV_M("ALL");
        //     }else if (value==2){
        //       controller.TYPE_SHOW="DateNow";
        //       controller.get_BIL_MOV_M("DateNow");
        //     }else {
        //       _selectDataFromDate(context);
        //     }
        //     // معالجة القيمة المحددة
        //   },
        // ),
      ],
    );
  }



  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('You wrote $value!'))));
  }

  void searchRequestData(String query) {
    final listDatacustmoerRequest = controller.BIL_MOV_M_List.where((list) {
      final titleLower = list.BMMNO.toString().toLowerCase();
      final authorLower = list.BMMDO.toString().toLowerCase();
      final author2Lower = list.BINA_D.toString().toLowerCase();
      final author3Lower = list.SINA_D.toString().toLowerCase();
      final author4Lower = list.PKNA_D.toString().toLowerCase();
      final author5Lower = list.BMMNA.toString().toLowerCase();
      final author6Lower = list.BMMMT.toString().toLowerCase();
      final author7Lower = list.BMMDI.toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          author2Lower.contains(searchLower) ||
          author3Lower.contains(searchLower) ||
          authorLower.contains(searchLower) ||
          author4Lower.contains(searchLower) ||
          author6Lower.contains(searchLower) ||
          author7Lower.contains(searchLower) ||
          author5Lower.contains(searchLower);
    }).toList();
    setState(() {
      this.query = query;
      controller.BIL_MOV_M_List = listDatacustmoerRequest;
      if (query == '') {
        controller.GET_BIL_MOV_M_P("DateNow");
      }
    });
    controller.CheckSearech = 1;
  }

  SearchBarDemoHomeState() {
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
            controller.GET_BIL_MOV_M_P("DateNow");
            controller.update();
          });
          print("cleared");
        },
        onClosed: () {
          setState(() {
            controller.GET_BIL_MOV_M_P("DateNow");
            controller.update();
          });
          print("closed");
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    SearchBarDemoHomeState();
  }

  Future<bool> onWillPop() async {
    final shouldPop;
    if (controller.CheckSearech == 1) {
      controller.CheckSearech = 0;
      controller.SER_MINA = '';
      controller.update();
      return true;
    }
    else {
      Get.back();
      shouldPop = await Get.offAllNamed('/Home');
    }
    return shouldPop ?? false;
  }

  final List locale_PDF =[
    {'name':'String58thermal'.tr,'value':'58'},
    {'name':'String80thermal'.tr,'value':'80'},
    {'name':'StringA4Form1'.tr,'value':'3'},
    {'name':'StringA4Form2'.tr,'value':'4'},
  ];
  int selectedValue = 2;

  Future<dynamic> buildShowDialogState(BuildContext context,int GETBMKID,int GETBMMID) {
    return  Get.defaultDialog(
        title: 'StringState_Ord'.tr,
        content: GetBuilder<Sale_Invoices_Controller>(
            init: Sale_Invoices_Controller(),
            builder: ((value) {
              return Column(
                  children: [
                    ListTile(
                      title: Text('Stringfinal'.tr,style: TextStyle(color: Colors.green)),
                      leading: Radio(
                        value: 1,
                        groupValue: controller.BMMST,
                        onChanged: (value) {
                          controller.BMMST = value as int;
                          controller.update();
                        },
                        activeColor: AppColors.MainColor ,
                      ),
                    ),
                    ListTile(
                      title: Text('StringNotfinal'.tr,style: TextStyle(color: Colors.blue)),
                      leading: Radio(
                        value: 2,
                        groupValue: controller.BMMST,
                        onChanged: (value) {
                          controller.BMMST = value as int;
                          controller.update();
                        },
                        activeColor: AppColors.MainColor ,
                      ),
                    ),
                  ]);
            })),
        backgroundColor: Colors.white,
        radius: 40,
        actions:[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton (
                onPressed: () {
                  // إجراء عند النقر على الزر الأول (متابعة)
                  controller.Socket_IP_Connect('SyncOnly', GETBMMID.toString(),true,1);
                  STMID=='EORD'?UpdateStateBIF_EPRD_M(GETBMKID, GETBMMID.toString()):false;
                  Get.back();
                  // UpdateStateBIF_MOV_M_ORDER(controller.BMMST,'SyncOnly', GETBMKID, GETBMMID.toString());
                  // UpdateStateBIF_MOV_D_ORDER('SyncOnly', GETBMKID, GETBMMID.toString(), 1);
                },
                child: Text('StringContinue'.tr,style: TextStyle(color: Colors.black),),
              ),
              TextButton (
                onPressed: () {
                  // إجراء عند النقر على الزر الثاني (الغاء)
                  Get.back();
                },
                child: Text('StringCancel'.tr,style: TextStyle(color: Colors.black)),
              ),
            ],
          ),
        ]
      // barrierDismissible: false,
    );
  }

  Future<dynamic> buildShowDialogLang(BuildContext context, String? GetBMKID,String? GetBMMID,
      String? GetBMMDO, String? GetBMMNO, String? GetPKNA, AANO, SCID, PKID) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Get.defaultDialog(
      title: "StringReport_Type".tr,
      content:Container(
        height: 0.17 * height,
        width: 4 * width,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return InkWell(
                child: Text(locale_PDF[index]['name']),
                onTap: () async {
                  //Get.back();
                  Navigator.of(context).pop(false);
                  controller.update();
                  await controller.PRINT_BALANCE_P(
                    BMMID:GetBMMID,AANO:AANO, SCID:SCID, PKID:PKID,
                    typeRep: locale_PDF[index]['value'].toString(),
                    GetBMKID: GetBMKID, GetBMMDO: GetBMMDO,
                    GetBMMNO: GetBMMNO, GetPKNA: GetPKNA,
                    mode: ShareMode.view,
                  );
                  //Navigator.of(context).pop(false);
                },
              );
            },
            separatorBuilder: (context,index){
              return const Divider(
                color: Colors.blue,
              );
            },
            itemCount: locale_PDF.length),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }

  Widget build(BuildContext context) {
    controller.isTablet = MediaQuery.of(context).size.shortestSide >= 600;
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: grey_5,
        appBar: searchBar.build(context),
        body:  GetBuilder<Sale_Invoices_Controller>(
            init: Sale_Invoices_Controller(),
            builder: ((value) {
              if (controller.BIL_MOV_M_List.isEmpty){
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "${ImagePath}no_data.png",
                        height: 0.1 * height,
                      ),
                      Text('StringNoData'.tr,
                          style: ThemeHelper().buildTextStyle(context, Colors.black,'L')
                      ),
                    ],
                  ),
                );
              }
              return ListView.builder(
                  itemCount: controller.BIL_MOV_M_List.length,
                  itemBuilder: (BuildContext context, int index) {
                    var item =  controller.BIL_MOV_M_List[index];
                    print('item.BMMFST');
                    print(item.BMMFST);
                    return  InkWell(
                      onTap: () async {
                        controller.BIL_MOV_D_SHOW.clear();
                        controller.update();
                        controller.GET_BIF_MOV_D_SHOW(item.BMMID.toString());
                        controller.update();
                        controller.BMMID_L = item.BMMID;
                        controller.update();
                        await Future.delayed(const Duration(milliseconds: 800));
                        Navigator.of(context).push(
                          PageRouteBuilder(
                            fullscreenDialog: true,
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation) {
                              return Scaffold(
                                appBar: AppBar(
                                  title: ThemeHelper().buildText(
                                      context, 'StringDetails', Colors.black,
                                      'L'),
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
                                              children: [
                                                Container(
                                                  width: double.infinity,
                                                  color: AppColors.MainColor,
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0.02 * height),
                                                  child: Center(
                                                    child: Text(STMID == 'EORD'
                                                        ? item.BMATY.toString() == '1'
                                                        ? 'StrinLocal'.tr
                                                        :
                                                    item.BMATY.toString() == '2'
                                                        ? 'StrinExternal'.tr
                                                        : 'StrinDelivery'.tr
                                                        : item.BMMNA.toString(),
                                                        style: ThemeHelper()
                                                            .buildTextStyle(
                                                            context, Colors.white,
                                                            'L')),
                                                  ),
                                                ),
                                                Container(
                                                  height: firstSectionHeight,
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                                    children: <Widget>[
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          Text(
                                                            item.BINA_D.toString(),
                                                            style: ThemeHelper().buildTextStyle(
                                                                context, Colors.black,
                                                                item.BINA_D.toString().length >= 30 ? 'S' : 'M'),
                                                          ),
                                                          Text(
                                                              STMID == 'EORD'
                                                                  ? item.BMMDO.toString().substring(0, 10)
                                                                  : item.SINA_D.toString(),
                                                              style: ThemeHelper().buildTextStyle(
                                                                  context,
                                                                  Colors.black,
                                                                  STMID != 'EORD' ?
                                                                  item.SINA_D.toString().length >= 30 ? 'S' : 'M' : 'M')),
                                                          item.BMATY.toString() == '1' ?
                                                          Text(STMID == 'EORD'
                                                              ? item.RSNA_D.toString()
                                                              : item.PKNA_D.toString(),
                                                            style: ThemeHelper().buildTextStyle(
                                                                context,Colors.black, 'M'),) :
                                                          Text(STMID == 'EORD'
                                                              ? '' :item.PKNA_D.toString(),
                                                            style: ThemeHelper().buildTextStyle(
                                                                context, Colors.black, 'M'),),
                                                          Text(
                                                            STMID == 'EORD'
                                                                ? item.PKNA_D.toString()
                                                                : item.SCNA_D.toString(),
                                                            style: ThemeHelper().buildTextStyle(
                                                                context, Colors.black, 'M'),),
                                                        ],
                                                      ),
                                                      Column(
                                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                        children: <Widget>[
                                                          Text(item.BMMNO.toString(),
                                                            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                                          ),
                                                          Text(STMID == 'EORD' ?
                                                            "${item.BMMDO.toString().substring(10, 17)} " :
                                                            "${item.BMMDO.toString()} ",
                                                            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),),
                                                          item.BMATY.toString() == '1' ?
                                                          Text(STMID == 'EORD' ?
                                                          item.RTNA_D.toString() == 'null' ? '' :
                                                          item.RTNA_D.toString() : item.BMMDI.toString(),
                                                            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),) :
                                                          Text(STMID == 'EORD' ? '' : item.BMMDI.toString(),
                                                            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),
                                                          item.SCSY.toString()=='SAR'?
                                                          Row(children: [
                                                            Text(STMID == 'EORD' ?
                                                            ('${controller.formatter.format(item.BMMMT).toString() } ') :
                                                            controller.formatter.format(item.BMMMT).toString(),
                                                                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')),
                                                            SizedBox(width: 5,),
                                                            Image.asset("${ImagePath}Saudi_Riyal_Symbol.png",
                                                              //child: Image.asset("/data/data/com.elitesoftsys.emobilepro/app_flutter/2023_05_13_11_53_28.png",
                                                              fit: BoxFit.cover,
                                                              height: 0.02 * height,
                                                            ),
                                                          ],):
                                                          Text(STMID == 'EORD' ?
                                                          ('${controller.formatter.format(item.BMMMT).toString() } ${item.SCSY}') :
                                                          controller.formatter.format(item.BMMMT).toString(),
                                                            style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Expanded(child: Container(
                                                  child: ListView.builder(
                                                      itemCount: controller.BIL_MOV_D_SHOW.length,
                                                      itemBuilder: (
                                                          BuildContext context,
                                                          int index) {
                                                        return Card(
                                                          elevation: 2,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius
                                                                .circular(
                                                                0.02 * height),
                                                          ),
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          child: Container(
                                                            color: Colors
                                                                .grey[100],
                                                            child: ListTile(
                                                              leading: const Icon(
                                                                  Icons
                                                                      .assignment_rounded,
                                                                  color: Colors
                                                                      .black),
                                                              title: Text(
                                                                controller
                                                                    .BIL_MOV_D_SHOW[index]
                                                                    .NAM
                                                                    .toString(),
                                                                style: ThemeHelper()
                                                                    .buildTextStyle(
                                                                    context,
                                                                    Colors.black,
                                                                    'M'),),
                                                              subtitle: Text(
                                                                "${controller
                                                                    .formatter
                                                                    .format(
                                                                    controller
                                                                        .BIL_MOV_D_SHOW[index]
                                                                        .BMDNO)
                                                                    .toString()} (${controller
                                                                    .formatter
                                                                    .format(
                                                                    controller
                                                                        .BIL_MOV_D_SHOW[index]
                                                                        .BMDAM)
                                                                    .toString()})",
                                                                style: ThemeHelper()
                                                                    .buildTextStyle(
                                                                    context,
                                                                    Colors.black,
                                                                    'M'),),
                                                              trailing: Text(
                                                                controller
                                                                    .formatter
                                                                    .format(
                                                                    controller
                                                                        .roundDouble(
                                                                        controller
                                                                            .BIL_MOV_D_SHOW[index]
                                                                            .BMDAMT! +
                                                                            controller
                                                                                .BIL_MOV_D_SHOW[index]
                                                                                .BMDTXT!,
                                                                        3))
                                                                    .toString(),
                                                                style: ThemeHelper()
                                                                    .buildTextStyle(
                                                                    context,
                                                                    Colors.red,
                                                                    'M'),),
                                                            ),
                                                          ),
                                                        );
                                                      }),
                                                ),)
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                )
                                ,
                              );
                            },
                            transitionsBuilder: (BuildContext context,
                                Animation<double> animation,
                                Animation<double> secondaryAnimation,
                                Widget child) {
                              return FadeTransition(
                                opacity:
                                animation,
                                // CurvedAnimation(parent: animation, curve: Curves.elasticInOut),
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
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.02 * height),),
                            clipBehavior: Clip.antiAliasWithSaveLayer,
                            child: Container(
                              color: Colors.white,
                              child: Column(
                                children: [
                                  Container(
                                    width: double.infinity,
                                    color: AppColors.MainColor,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0.02 * height),
                                    child: Center(

                                      child: Text(STMID == 'EORD' ? item.BMATY.toString() ==
                                          '1' ? '${'StrinLocal'.tr}  ${item.RTNA_D.toString() == 'null' ? '' :
                                      ' - ${item.RTNA_D.toString()}' }'
                                                :
                                      item.BMATY
                                          .toString() == '2'
                                          ? 'StrinExternal'.tr
                                          : 'StrinDelivery'.tr
                                          : item.BMMNA
                                          .toString(),
                                        style: ThemeHelper().buildTextStyle(
                                            context, Colors.white, 'L'),),
                                    ),
                                  ),
                                  SizedBox(
                                    width: double.infinity,
                                    height: 0.2 * height,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              item.BINA_D.toString().length > 20? AnimatedTextWidget(
                                                text: item.BINA_D.toString(),)
                                                  :Text(
                                                item.BINA_D.toString(),
                                                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                              ),
                                              item.SINA_D.toString().length > 20 ?
                                              AnimatedTextWidget(
                                                text: STMID == 'EORD' ? item.BMMDO.toString().substring(0, 10) :
                                                STMID == 'COU' ?item.BPNA_D.toString() :
                                                item.SINA_D.toString(),):
                                              Text(
                                                  STMID == 'EORD' ? item.BMMDO.toString().substring(0, 10) :
                                                  STMID == 'COU' ?item.BPNA_D.toString() :
                                                  item.SINA_D.toString(),
                                                  style: ThemeHelper().buildTextStyle(
                                                      context, Colors.black,
                                                      STMID != 'EORD' ?
                                                      STMID == 'COU' ? item.BPNA_D.toString().length >= 30 ?
                                                      'S' : 'M' :
                                                      item.SINA_D.toString().length >= 30 ?
                                                      'S' : 'M' : 'M')),
                                              item.BMATY.toString() == '1' ?
                                              Text(STMID == 'EORD' ?
                                              item.RSNA_D.toString() :
                                              STMID == 'COU' ? item.CTMNA_D.toString() :
                                              item.PKNA_D.toString(),
                                                  style: ThemeHelper().buildTextStyle(
                                                      context, Colors.black, 'M')) :
                                              Text(STMID == 'EORD' ? '' :
                                              STMID == 'COU' ? item.CTMNA_D.toString() :
                                              item.PKNA_D.toString(),
                                                  style: ThemeHelper().buildTextStyle(
                                                      context, Colors.black, 'M')),
                                              Text(
                                                  STMID == 'EORD' || STMID == 'COU'
                                                      ? item.PKNA_D.toString()
                                                      : item.SCNA_D.toString(),
                                                  style: ThemeHelper().buildTextStyle(
                                                      context, Colors.black, 'M')),
                                              InkWell(
                                                onTap: () {
                                                  if (STMID == 'EORD' && item.BMMST2 == 2) {
                                                    controller.BMMST = item.BMMST2!;
                                                    buildShowDialogState(context, item.BMKID!, item.BMMID!);
                                                  }
                                                },
                                                child: Text('${item.BMMST2}'.toString() == '2'
                                                    ? 'StringNotfinal'.tr
                                                    : '${item.BMMST2}'.toString() == '4'
                                                    ? 'StringPending'.tr
                                                    : 'Stringfinal'.tr,
                                                    style: '${item.BMMST2}'.toString() == '2'
                                                        ? ThemeHelper().buildTextStyle(context, Colors.red, STMID == 'EORD'?'L':'M')
                                                        : '${item.BMMST2}'.toString() == '3'
                                                        ? ThemeHelper().buildTextStyle(context, Colors.blueAccent, STMID == 'EORD'?'L':'M')
                                                        : '${item.BMMST2}'.toString() == '4'
                                                        ? ThemeHelper().buildTextStyle(context, Colors.blueAccent, STMID == 'EORD'?'L':'M')
                                                        : ThemeHelper().buildTextStyle(context, Colors.green, STMID == 'EORD'?'L':'M')),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              item.BMMNO.toString(),
                                              style: ThemeHelper().buildTextStyle(context, Colors.black, 'M'),
                                            ),
                                            Text(
                                                STMID == 'EORD' ?
                                                "${item.BMMDO.toString().substring(10, 17)} " :
                                                "${item.BMMDO.toString()} ",
                                                style: ThemeHelper().buildTextStyle(
                                                    context, Colors.black, 'M')),
                                            item.BMATY.toString() == '1' ?
                                            Text(STMID == 'EORD' ?
                                            item.RTNA_D.toString() == 'null' ? '' :
                                            item.RTNA_D.toString() :
                                            STMID == 'COU' ? controller.formatter.format(
                                                item.BMDNO).toString()
                                                : controller.formatter.format(
                                                item.BMMDI).toString(),
                                                style: ThemeHelper().buildTextStyle(
                                                    context, Colors.black, 'M')) :
                                            Text(STMID == 'EORD' ? '' :
                                            STMID == 'COU' ? controller.formatter.format(item.BMDNO).toString()
                                                : controller.formatter.format(item.BMMDI).toString(),
                                                style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')),
                                            item.SCSY.toString()=='SAR'?
                                            Row(children: [
                                              Text(STMID == 'EORD' ?
                                              ('${controller.formatter.format(item.BMMMT).toString() } ') :
                                              controller.formatter.format(item.BMMMT).toString(),
                                                  style: ThemeHelper().buildTextStyle(context, Colors.black, 'M')),
                                              SizedBox(width: 5,),
                                              Image.asset("${ImagePath}Saudi_Riyal_Symbol.png",
                                                fit: BoxFit.cover,height: 0.02 * height,
                                              ),
                                            ],):
                                            Text(STMID == 'EORD' ?
                                            ('${controller.formatter.format(item.BMMMT).toString() } ') :
                                            controller.formatter.format(
                                                item.BMMMT).toString(),
                                                style: ThemeHelper().buildTextStyle(
                                                    context, Colors.black, 'M')),
                                            '${item
                                                .BMMST}' != '4'
                                                ? InkWell(
                                              onTap: () async {
                                                print('BMMFST');
                                                print(item.BMMFST);
                                                print(item.BMMST);
                                                await controller.GET_BIL_MOV_M_PRINT_P(item.BMMID!);
                                                await controller.GET_BIF_MOV_D_P(item.BMMID.toString(), controller.RINT_RELATED_ITEMS_DETAIL.toString());
                                                await controller.GET_Sys_Own_P(item.BIID2.toString());
                                                await controller.GET_BIL_CUS_IMP_INF_P(controller.BMKID == 1 ? item.BIID.toString() : item.BCID.toString());
                                                await controller.GET_COUNT_BMDNO_P(item.BMMID!);
                                                await controller.GET_CountRecode(item.BMMID!);
                                                await controller.GET_BIL_ACC_C_P(
                                                    item.AANO.toString(),
                                                    item.GUIDC.toString(),
                                                    item.BIID2.toString(),
                                                    item.SCID.toString(),
                                                    item.PKID.toString(),
                                                    GETBMMID: item.BMMID.toString());
                                                buildShowDialogLang(context,
                                                    item.BMKID.toString(),
                                                    item.BMMID.toString(),
                                                    item.BMMDO.toString(),
                                                    item.BMMNO.toString(),
                                                    item.PKNA_D.toString(),
                                                    item.AANO.toString(),
                                                    item.SCID.toString(),
                                                    item.PKID.toString());
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
                                                  Text(
                                                      'StringPrint'.tr,
                                                      style: ThemeHelper()
                                                          .buildTextStyle(
                                                          context, Colors.blueAccent,
                                                          'M')
                                                  )
                                                ],
                                              ),
                                            ) :
                                            Text(''),
                                          ],
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              if(('${item.BMMFST}' == '3' || '${item.BMMFST}' == '5') || '${item.BMMST}' == '4' ||
                                                  (STMID == 'EORD' && ('${item.BMMST2}' == '2' || '${item.BMMST2}' == '4')))
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      LoginController().SET_P('Return_Type', '1');
                                                      controller.EditSales_Invoices(item);
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 0.026 * height,
                                                    ),
                                                  ),
                                                ),
                                              '${item.BMMST}' == '1' || (STMID == 'EORD' && ('${item.BMMST2}' == '2' || '${item.BMMST2}' == '1'))
                                                  ? Expanded(
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.settings_backup_restore,
                                                      color: Colors.black,
                                                      size: 0.026 * height,
                                                    ),
                                                    onPressed: () async {
                                                      controller.GET_CountRecode(item.BMMID!);
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
                                                          Get.back();
                                                          controller.Socket_IP_Connect('SyncOnly', item.BMMID.toString(), true,
                                                              item.BMMST2.toString() == '1' ? 1 : 2);
                                                        },
                                                      );
                                                    }),
                                              )
                                                  : '${item.BMMST2}' == '4'
                                                  ? Expanded(
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: Colors.red,
                                                      size: 0.026 * height,
                                                    ),
                                                    onPressed: () async {
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'.tr,
                                                        middleText: 'StringDeleteMessage'
                                                            .tr,
                                                        backgroundColor: Colors.white,
                                                        radius: 40,
                                                        textCancel: 'StringNo'.tr,
                                                        cancelTextColor: Colors.red,
                                                        textConfirm: 'StringYes'.tr,
                                                        confirmTextColor: Colors
                                                            .white,
                                                        onConfirm: () {
                                                          if (item.BMMST2.toString() == '4') {
                                                            bool isValid = controller.delete_BIL_MOV(item.BMMID, 2);
                                                            if (isValid) {
                                                              controller.GET_BIL_MOV_M_P("DateNow");
                                                            }
                                                            Get.back();
                                                          } else {
                                                            Get.snackbar(
                                                                'StringUPDL'.tr,
                                                                'String_CHK_UPDL'.tr,
                                                                backgroundColor: Colors
                                                                    .red,
                                                                icon: const Icon(
                                                                    Icons.error,
                                                                    color: Colors
                                                                        .white),
                                                                colorText: Colors
                                                                    .white,
                                                                isDismissible: true,
                                                                dismissDirection: DismissDirection
                                                                    .horizontal,
                                                                forwardAnimationCurve: Curves
                                                                    .easeOutBack);
                                                          }
                                                        },
                                                      );
                                                    }),
                                              )
                                                  : Expanded(child: Container()),
                                              if('${item.BMMST2}' != '4')
                                                Expanded(
                                                  child: IconButton(
                                                    onPressed: () async {
                                                      // await FileHelper().initPlatformState();
                                                      await  controller.GET_BIL_MOV_M_PRINT_P(item.BMMID!);
                                                      await  controller.GET_BIF_MOV_D_P(item.BMMID.toString(), controller.RINT_RELATED_ITEMS_DETAIL.toString());
                                                      await  controller.GET_Sys_Own_P(item.BIID2.toString());
                                                      await  controller.GET_BIL_CUS_IMP_INF_P(controller.BMKID == 1 ? item.BIID.toString() : item.BCID.toString());
                                                      await  controller.GET_COUNT_BMDNO_P(item.BMMID!);
                                                      await  controller.GET_CountRecode(item.BMMID!);
                                                      await  controller.GET_BIL_ACC_C_P(
                                                          item.AANO.toString(),
                                                          item.GUIDC.toString(),
                                                          item.BIID2.toString(),
                                                          item.SCID.toString(),
                                                          item.PKID.toString(),
                                                          GETBMMID: item.BMMID.toString());
                                                        await Future.delayed(const Duration(seconds: 1));
                                                        await controller.PRINT_BALANCE_P(
                                                            BMMID: item.BMMID.toString(),
                                                            AANO:item.AANO.toString(),
                                                            SCID:item.SCID.toString(),
                                                            PKID:item.PKID.toString(),
                                                            typeRep: controller.typeRep,
                                                            GetBMKID: item.BMKID.toString(),
                                                            GetBMMDO: item.BMMDO.toString(),
                                                            GetBMMNO: item.BMMNO.toString(),
                                                            GetPKNA: item.PKNA_D.toString(),
                                                            mode: ShareMode.print
                                                        );
                                                    },
                                                    icon: Icon(
                                                      Icons.print,
                                                      color: Colors.black,
                                                      size: 0.026 * height,
                                                    ),
                                                  ),
                                                ),
                                            //  if('${item.BMMFST}' != '10' && LoginController().USE_VAT_N == '1' && LoginController().USE_FAT_P_N == 1)
                                              if(LoginController().USE_VAT_N == '1' && LoginController().USE_FAT_P_N == 1)
                                                Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        print(item.BMMFST);
                                                        if ('${item.BMMFST}' != '1') {
                                                          var FAT_CHK = await ES_FAT_PKG.MAIN_FAT_SND_INV(
                                                              item.BMKID,
                                                              item.BMMID,
                                                              item.BIID2,
                                                              item.BMMDO.toString(),
                                                              item.GUID.toString(),
                                                              item.BMMST,
                                                              LoginController().SSID_N,
                                                              item.BMMFST,
                                                              LoginController().SIGN_N,
                                                              controller.ST_O_N,
                                                              controller.MSG_O);
                                                          print(controller.MSG_O);
                                                          print(controller.ST_O_N);
                                                          print(FAT_CHK);
                                                          print('FAT_CHK');
                                                          if (await FAT_CHK) {
                                                            print(controller.MSG_O);
                                                            print(controller.ST_O_N);
                                                            controller.update();
                                                          }
                                                          StteingController().isActivateAutoMoveSync == true
                                                              ? await controller.Socket_IP_Connect(
                                                              'SyncOnly', item.BMMID.toString(), false, 2) : false;
                                                          controller.update();
                                                          await controller.GET_BIL_MOV_M_P("FromDate");
                                                          controller.update();
                                                        }
                                                        // هنا تضع الإجراء الذي تريده عند الضغط
                                                        print('تم الضغط على الصورة!');
                                                      },
                                                      child: Image.asset(
                                                        '${item.BMMFST}' == '1' ?
                                                        '${ImagePath}TAX_S.png' :
                                                        '${item.BMMFST}' == '5' ||
                                                        '${item.BMMFST}' == '10' ?
                                                        '${ImagePath}TAX_I.png' :
                                                        '${item.BMMFST}' == '4' ?
                                                        '${ImagePath}TAX4.png'
                                                        : '${ImagePath}TAX_E.png', // استبدل بهذا المسار الصحيح للصورة
                                                      ),
                                                    )
                                                ),
                                              if('${item.BMMST}' != '4' && StteingController().WAT_ACT == true)
                                                Expanded(
                                                    child: GestureDetector(
                                                      onTap: () async {
                                                        // هنا تضع الإجراء الذي تريده عند الضغط
                                                        print('تم الضغط على الصورة!');
                                                      },
                                                      child: Image.asset(
                                                        '${ImagePath}WhatsApp.png', // استبدل بهذا المسار الصحيح للصورة
                                                      ),
                                                    )
                                                ),
                                             STMID=='EORD' && item.RTNA_D.toString() != 'null' && '${item.BMMST2}' == '2' ?
                                              Expanded(
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.table_bar_sharp,
                                                      color: Colors.black,
                                                      size: 0.026 * height,
                                                    ),
                                                    onPressed: () async {
                                                      controller.GET_RES_SEC_P(controller.SelectDataBIID.toString()=='null'?
                                                      LoginController().BIID.toString() :controller.SelectDataBIID.toString());
                                                      controller.update();
                                                      controller.BMMID=item.BMMID;
                                                      controller.SelectDataRTID=item.RTID.toString();
                                                      controller.SelectDataRTIDO=item.RTID.toString();
                                                      controller.SelectDataRSIDO=item.RSID.toString();
                                                      controller.SelectDataGETTYPE=item.BMATY.toString();
                                                      showTableSheet('ED',item.GUID.toString());
                                                    }),
                                              ):Container(),
                                              ('${item.BMMFST}' == '1' || '${item.BMMFST}' == '10') && ('${item.BMMST}' == '2')
                                                  ? Expanded(
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.sync,
                                                      color: Colors.black,
                                                      size: 0.026 * height,
                                                    ),
                                                    onPressed: () async {
                                                      Get.defaultDialog(
                                                        title: 'StringMestitle'.tr,
                                                        middleText: 'StringSuresyn'
                                                            .tr,
                                                        backgroundColor: Colors.white,
                                                        radius: 40,
                                                        textCancel: 'StringNo'.tr,
                                                        cancelTextColor: Colors.red,
                                                        textConfirm: 'StringYes'.tr,
                                                        confirmTextColor: Colors
                                                            .white,
                                                        onConfirm: () {
                                                          Get.back();
                                                          controller.Socket_IP_Connect('SyncOnly', item.BMMID.toString(),true, 2);
                                                        },
                                                      );
                                                    }),
                                              )
                                                  : '${item.BMMST}' == '4'
                                                  ? Expanded(child: Container()) :
                                              Expanded(
                                                child: Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 0.001 * height),
                                                  child: Text(
                                                    [2, 3, 4, 5, 6].contains(item.BMMFST) ? '' :
                                                    "${'StringDoSync'.tr} (${item.BMMNR.toString()})",
                                                    style: ThemeHelper()
                                                        .buildTextStyle(
                                                        context, Colors.green, 'M'),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          BIL_MOV_D_SHOW(item.BMKID == 11 || item.BMKID == 12 ? 'BIF_MOV_D' : 'BIL_MOV_D',item.BMMID.toString()),
                        ],
                      ),
                    );
                  });
            })),
        floatingActionButton: FloatingActionButton.extended(
          backgroundColor: AppColors.MainColor,
          onPressed: () async {
            final difference = DateDays_last.difference(DateDays).inDays;
            // if (difference >= 7) {
            //   Get.snackbar('StringCHK_Syn'.tr, 'StringCHK_Syn_Err'.tr,
            //       backgroundColor: Colors.red,
            //       icon: const Icon(Icons.error, color: Colors.white),
            //       colorText: Colors.white);
            // }
            //  else
            if (controller.BYST == 2) {
              Get.snackbar('StringByst_Mes'.tr, 'String_CHK_Byst'.tr,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error, color: Colors.white),
                  colorText: Colors.white);
            }
            else if (controller.UPIN == 2) {
              Get.snackbar('StringUPIN'.tr, 'String_CHK_UPIN'.tr,
                  backgroundColor: Colors.red,
                  icon: const Icon(Icons.error, color: Colors.white),
                  colorText: Colors.white,
                  isDismissible: true,
                  dismissDirection: DismissDirection.horizontal,
                  forwardAnimationCurve: Curves.easeOutBack);
            } else {
              if(controller.BMKID==11 && LoginController().InstallData == false) {
                await controller.GET_BRA_INF_P();
                await controller.GET_SYS_CUR_ONE_P_POS();
                await controller.GET_BIL_POI_ONE_P();
                await controller.GET_PAY_KIN_ONE_P_POS();
                if(STMID=='COU'){
                  buildShowSetting_COU(context);
                }
                else{
                  controller.SelectDataGETTYPE = '1';
                  await  controller.GET_BIL_POI_ONE_P();
                  await  controller.GET_PAY_KIN_ONE_P_POS();
                  await  controller.GET_STO_INF_ONE_P();
                  STMID == 'EORD' ? (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1)
                      || TYPEPHONE=="ANDROID"?
                  buildShowSetting_order(context) :Container(): buildShowSetting();
                  controller.update();

                }
              }
              else if(controller.BMKID==11 && LoginController().InstallData == true){

                if(STMID=='COU'){
                  controller.CTMTYController.text = LoginController().CTMTY_V;
                  controller.SelectDataPKID = LoginController().PKID_COU;
                  controller.PKID = int.parse(LoginController().PKID_COU.toString());
                  controller.SelectDataCTMID = LoginController().CTMID_V;
                }else{
                  controller.SelectDataRSID = LoginController().RSID.toString();
                }
                controller.SelectDataBIID=LoginController().BIID_V;
                controller.SelectDataBPID=LoginController().BPID_V;
                controller.SelectDataSIID=LoginController().SIID_V;
                controller.SelectDataSCID=LoginController().SCID_V;
                controller.SCEXController.text = LoginController().SCEX_SALE.toString();
                controller.BPPR = LoginController().BPPR;
                controller.BCPR = LoginController().BPPR;
                controller.PKID = LoginController().PKID_SALE;
                controller.SelectDataPKID = LoginController().PKID_SALE.toString();
                controller.SelectDataGETTYPE='1';
                controller.loadingerror(false);
                print(controller.SelectDataPKID);
                print(controller.PKID);
                print('PKID2222');
                controller.update();
                if ( controller.SelectDataGETTYPE=='1' && StteingController().SHOW_TAB==true) {
                  controller.SelectDataRTID = null;
                  controller.SelectDataREID = null;
                  controller.GET_RES_SEC_P(controller.SelectDataBIID.toString());
                  showTableSheet('ADD','');
                }
                else {
                  controller.SelectDataRTID = null;
                  controller.SelectDataREID = null;
                  controller.AddSale_Invoices();
                }
              }
              else if( controller.BMKID==2){
                  LoginController().SET_P('Return_Type','2');
                  controller.update();
                  Get.to(() => const Return_Sale_Invoices_view(), arguments:  controller.BMKID);
                  LoginController().SET_P('Return_Type','2');
                  controller.update();
                  controller.get_RETURN_SALE('ALL');
                  controller.update();
              }
              else if( controller.BMKID==4){
                if(LoginController().USE_VAT_N=='1' && LoginController().USE_FAT_P_N==1){
                  LoginController().SET_P('Return_Type','2');
                  controller.update();
                  Get.to(() => const Return_Sale_Invoices_view(), arguments:  controller.BMKID);
                  LoginController().SET_P('Return_Type','2');
                  controller.update();
                  controller.get_RETURN_SALE('ALL');
                  controller.update();
                }else {
                  buildShowDialogReturn_Sale_Invoices(4);
                }
              }
              else if( controller.BMKID==12){
                if(LoginController().USE_VAT_N=='1' && LoginController().USE_FAT_P_N==1){
                  LoginController().SET_P('Return_Type','2');
                  controller.update();
                  Get.to(() => const Return_Sale_Invoices_view(), arguments:  controller.BMKID);
                  LoginController().SET_P('Return_Type','2');
                  controller.update();
                  controller.get_RETURN_SALE('ALL');
                  controller.update();
                }else {
                  buildShowDialogReturn_Sale_Invoices(12);
                }
              }
              else {
                controller.AddSale_Invoices();
              }
            }
          },
          label: Text(controller.BMKID==4 || controller.BMKID==12?'StringAdd'.tr:'StringAdd_Inv_Num'.tr,
              style: ThemeHelper().buildTextStyle(context,Colors.white,'M')),
          icon: const Icon(Icons.add,color: Colors.white),
        ),
        bottomNavigationBar: GetBuilder<Sale_Invoices_Controller>(
          init: Sale_Invoices_Controller(),
          builder: (controller) {
            if (STMID == 'MOB' || STMID == 'COU' || STMID == 'EORD') {
              return SalomonBottomBar(
                currentIndex: controller.currentIndex,
                selectedItemColor: Colors.pink,
                onTap: (index) async {
                  setState(() {
                    controller.currentIndex = index;
                    controller.update();
                  });
                  await controller.GET_BIL_MOV_M_P("DateNow");
                  controller.update();
                },
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: Icon(Icons.thermostat, color: Colors.black),
                    title: Text("${'StringAll'.tr} (${controller.BIL_MOV_M_List.length})"),
                    selectedColor: Colors.black,
                  ),
                  /// Operation
                  SalomonBottomBarItem(
                    icon: Icon(Icons.thermostat, color: Colors.green),
                    title: Text("${'Stringfinal'.tr} (${controller.BIL_MOV_M_List.length})"),
                    selectedColor: Colors.green,
                  ),
                  /// Reports
                  SalomonBottomBarItem(
                    icon: Icon(Icons.thermostat, color: Colors.red),
                    title: Text("${'StringNotfinal'.tr} (${controller.BIL_MOV_M_List.length})"),
                    selectedColor: Colors.red,
                  ),
                  /// Settings
                  SalomonBottomBarItem(
                    icon: Icon(Icons.thermostat, color: Colors.blueAccent),
                    title: Text("${'StringPending'.tr} (${controller.BIL_MOV_M_List.length})"),
                    selectedColor: Colors.blueAccent,
                  ),
                ],
              );
            }
            return SizedBox.shrink(); // إرجاع عنصر فارغ إذا لم يكن الشرط صحيحًا
          },
        ),
      ),
    );
  }

  void showTableSheet(Type,GETGUID) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    Get.bottomSheet(
        GetBuilder<Sale_Invoices_Controller>(
          init: Sale_Invoices_Controller(),
          builder: (controller) {
            return Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ClipPath(
                        clipper: BottomClipper(),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              bottomRight: Radius.circular(30),
                            ),
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                          ),
                          Text('StringRES_TAB'.tr,
                              style: ThemeHelper().buildTextStyle(context,AppColors.black,'L')
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      if(controller.RES_SEC.length>0)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'StrinRSID'.tr,
                              style:ThemeHelper().buildTextStyle(context,AppColors.black,'L'),
                            ),
                          ],
                        ).fadeAnimation(0 * 0.1),
                      if(controller.SelectDataGETTYPE=='1' )
                        SizedBox(
                          height:  height * 0.05,
                          child: ListView.builder(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.RES_SEC.length,
                            itemBuilder: (BuildContext context, int index) {
                              return   Padding(
                                padding:EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      controller.SelectDataRSID=controller.RES_SEC[index].RSID.toString();
                                      controller.SelectDataRTID=null;
                                      controller.SelectDataREID=null;
                                      controller.GET_RES_TAB_P(controller.RES_SEC[index].RSID.toString());
                                      controller.GET_RES_EMP_P(controller.RES_SEC[index].RSID.toString());
                                      controller.update();
                                    });
                                  },
                                  style:
                                  TextButton.styleFrom(
                                    side:  BorderSide(color:controller.RES_SEC[index].RSID.toString()==controller.SelectDataRSID?
                                    Colors.red:Colors.black45),
                                    //foregroundColor: Colors.black,
                                    // backgroundColor: Colors.grey[400],
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(0.01 * height), // <-- Radius
                                    ),
                                  ),
                                  child: Text(
                                      controller.RES_SEC[index].RSNA_D.toString(),
                                      style:ThemeHelper().buildTextStyle(context, controller.RES_SEC[index].RSID.toString()==controller.SelectDataRSID?
                                      Colors.red:Colors.black,'M')
                                  ),
                                ).fadeAnimation(index * 0.6),
                              );
                            },
                          ),
                        ),
                      SizedBox(height: 0.02 * height),
                      if(controller.SelectDataGETTYPE=='1'  && controller.RES_TAB.length>0 )
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'StringRES_TAB'.tr,
                              style:ThemeHelper().buildTextStyle(context,AppColors.black,'L'),
                            ),
                          ],
                        ).fadeAnimation(1 * 0.1),
                      if(controller.SelectDataGETTYPE=='1')
                        SizedBox(
                          height: height * 0.1,
                          child:  GridView.builder(
                            shrinkWrap: true,
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemCount: controller.RES_TAB.length,
                            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2, // عدد الصفوف
                              crossAxisSpacing: 2.0,
                              mainAxisSpacing: 2.0,
                              mainAxisExtent: 100, // تناسب العرض مع الطول (اضبط حسب الحاجة)
                            ),
                            itemBuilder: (BuildContext context, int index) {
                              return Padding(
                                padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                                child: TextButton(
                                  onPressed: () {
                                      if(controller.RES_TAB[index].RTID==controller.SelectDataRTID){
                                        controller.SelectDataRTID=null;
                                      }else{
                                        controller.SelectDataRTID=controller.RES_TAB[index].RTID.toString();
                                        controller.SelectDataRTNA=controller.RES_TAB[index].RTNA_D.toString();
                                      }
                                      controller.update();
                                  },
                                  style:
                                  TextButton.styleFrom(
                                    side:  BorderSide(color:controller.RES_TAB[index].RTID.toString()==controller.SelectDataRTID?
                                    Colors.red:Colors.black45),
                                    shape:RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular( 0.01 * height), // <-- Radius
                                    ),
                                  ),
                                  child:
                                  Text(
                                      "${controller.RES_TAB[index].RTID.toString()}-${controller.RES_TAB[index].RTNA_D.toString()}",
                                      style: ThemeHelper().buildTextStyle(context, controller.RES_TAB[index].RTID.toString()==controller.SelectDataRTID?
                                      Colors.red:Colors.black,'M')
                                  ),
                                ).fadeAnimation(index * 0.6),
                              );
                            },
                          )
                          ,),
                      SizedBox(height: 0.02 * height),
                      Type == 'ADD'
                          ? Column(
                        children: [
                          if (controller.SelectDataGETTYPE == '1' && controller.RES_EMP.length > 0)
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'StringRES_EMP'.tr,
                                  style: ThemeHelper().buildTextStyle(context, AppColors.black, 'L'),
                                ),
                              ],
                            ).fadeAnimation(2 * 0.1),
                          if (controller.SelectDataGETTYPE == '1')
                            SizedBox(
                              height: height / 23,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.RES_EMP.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return Padding(
                                    padding: EdgeInsets.only(left: 0.01 * width, right: 0.01 * width),
                                    child: TextButton(
                                      onPressed: () {
                                        setState(() {
                                          if (controller.RES_EMP[index].REID == controller.SelectDataREID) {
                                            controller.SelectDataREID = null;
                                          } else {
                                            controller.SelectDataREID = controller.RES_EMP[index].REID.toString();
                                          }
                                          controller.update();
                                        });
                                      },
                                      style: TextButton.styleFrom(
                                        side: BorderSide(
                                          color: controller.RES_EMP[index].REID.toString() == controller.SelectDataREID
                                              ? Colors.red
                                              : Colors.black45,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(0.01 * height),
                                        ),
                                      ),
                                      child: Text(
                                        "${controller.RES_EMP[index].RENA_D.toString()}",
                                        style: ThemeHelper().buildTextStyle(
                                          context,
                                          controller.RES_EMP[index].REID.toString() == controller.SelectDataREID
                                              ? Colors.red
                                              : Colors.black,
                                          'M',
                                        ),
                                      ),
                                    ).fadeAnimation(index * 0.6),
                                  );
                                },
                              ),
                            ),
                        ],
                      )
                          : SizedBox.shrink(),// ترجع Widget فارغ في حالة الشرط غير متحقق
                    ],
                  ),
                  SizedBox(height: height * 0.026),
                  SizedBox(
                    width: double.infinity,
                    height: height * 0.06,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.red,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onPressed: () {
                        Type=='ED' ?
                        {
                          if (controller.SelectDataRTIDO!=controller.SelectDataRTID){
                          controller.Save_BIF_TRA_TBL_P(GETGUID),
                          Get.back(),
                        }
                          else{
                          Fluttertoast.showToast(
                              msg: "Save_BIF_TRA_TBL",
                              toastLength: Toast.LENGTH_LONG,
                              textColor: Colors.white,
                              backgroundColor: Colors.redAccent)
                        }
                        } : controller.AddSale_Invoices();
                      },
                      child: Text(
                        Type=='ED'?'StringEdit'.tr:'StringContinue'.tr,
                        style: ThemeHelper().buildTextStyle(context, Colors.white, 'M'),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        )
    );
  }

  final List locale =[
    {'name':'StringFree_Return_Sale'.tr,'value':'1'},
    {'name':'StringReturn_Sale'.tr,'value':'2'},
  ];

  Future<dynamic> buildShowDialogReturn_Sale_Invoices(int GETBMKID) {
    return Get.defaultDialog(
      title: "StringReturn_Type".tr,
      content:Container(
        height: 95,
        width: 200,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(locale[index]['name']),
                onTap: (){
                  Get.back();
                  if(locale[index]['value']=='1'){
                    LoginController().SET_P('Return_Type','1');
                    if(GETBMKID==12){
                      controller.SelectDataBIID=LoginController().BIID.toString();
                      controller.GET_BIL_POI_ONE_P();
                      Timer(const Duration(milliseconds: 600), () {
                        controller.GET_SYS_CUR_ONE_P_POS();
                        controller.GET_PAY_KIN_ONE_P_POS();
                        controller.GET_STO_INF_ONE_P();
                        STMID=='EORD'?buildShowSetting_order(context):buildShowSetting();
                        controller.update();
                      });
                    }else{
                      controller.AddSale_Invoices();
                    }
                  }else{
                    LoginController().SET_P('Return_Type','2');
                    controller.update();
                    Get.to(() => const Return_Sale_Invoices_view(), arguments: GETBMKID);
                    LoginController().SET_P('Return_Type','2');
                    controller.update();
                    controller.get_RETURN_SALE('ALL');
                    controller.update();
                  }
                  // Get.toNamed(Routes.Sale_Invoices,arguments: 4);
                },
              );
            },
            separatorBuilder: (context,index){
              return const Divider(
                color: Colors.blue,
              );
            },
            itemCount: 2),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }


  void buildShowSetting() {
    Get.defaultDialog(
      title: "Stringsetting".tr,
      content: Builder(
        builder: (BuildContext context) {
          // الآن `context` مضمون أن يكون صالحًا هنا.
          double height = MediaQuery.of(context).size.height;
          double width = MediaQuery.of(context).size.width;

          return GetBuilder<Sale_Invoices_Controller>(
            init: Sale_Invoices_Controller(),
            builder: ((controller) => Column(
              children: [
                DropdownBra_InfBuilder(),
                SizedBox(height: 0.01 * height),
                DropdownBil_PoiBuilder(),
                SizedBox(height: 0.01 * height),
                DropdownSto_InfBuilder(),
                SizedBox(height: 0.01 * height),
                DropdownSYS_CURBuilder(),
                SizedBox(height: 0.01 * height),
                DropdownPAY_KINBuilder(),
                SizedBox(height: 0.01 * height),
                MaterialButton(
                  onPressed: () async {
                    if (controller.SelectDataBIID == null) {
                      Fluttertoast.showToast(
                          msg: 'StringStoch'.tr,
                          textColor: Colors.white,
                          backgroundColor: Colors.red);
                    } else if (controller.SelectDataSIID == null) {
                      Fluttertoast.showToast(
                          msg: 'StringStoch'.tr,
                          textColor: Colors.white,
                          backgroundColor: Colors.red);
                    } else if (controller.SelectDataBPID == null) {
                      Fluttertoast.showToast(
                          msg: 'StringChi_currency'.tr,
                          textColor: Colors.white,
                          backgroundColor: Colors.red);
                    } else if (controller.SelectDataSCID == null) {
                      Fluttertoast.showToast(
                          msg: 'StringChi_currency'.tr,
                          textColor: Colors.white,
                          backgroundColor: Colors.red);
                    } else if (controller.SelectDataPKID == null) {
                      Fluttertoast.showToast(
                          msg: 'StringChi_PAY'.tr,
                          textColor: Colors.white,
                          backgroundColor: Colors.red);
                    } else {
                      controller.AddSale_Invoices();
                      LoginController().SET_B_P('InstallData', controller.isloadingInstallData);
                      LoginController().SET_P('BIID_V', controller.SelectDataBIID.toString());
                      LoginController().SET_P('BPID_V', controller.SelectDataBPID.toString());
                      LoginController().SET_P('SIID_V', controller.SelectDataSIID.toString());
                      LoginController().SET_P('SCID_V', controller.SelectDataSCID.toString());
                      controller.update();
                    }
                  },
                  child: Container(
                    height: 0.05 * height,
                    width: 2 * width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.MainColor,
                        borderRadius: BorderRadius.circular(0.02 * height)),
                    child: Text(
                      'StringContinue'.tr,
                      style: ThemeHelper()
                          .buildTextStyle(context, Colors.white, 'M'),
                    ),
                  ),
                ),
                SizedBox(height: 0.01 * height),
                MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Container(
                    height: 0.05 * height,
                    width: 2 * width,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: AppColors.MainColor,
                        borderRadius: BorderRadius.circular(0.02 * height)),
                    child: Text(
                      'StringLogout'.tr,
                      style: ThemeHelper()
                          .buildTextStyle(context, Colors.white, 'M'),
                    ),
                  ),
                ),
              ],
            )),
          );
        },
      ),
      backgroundColor: Colors.white,
      radius: 30,
      barrierDismissible: false,
    );
  }

  List<PopupMenuItem<int>> buildPopupMenuItems() {
    return [
      PopupMenuItem(
        value: 1,
        child: ListTile(
          title: Text(
            'StringShowAll'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      PopupMenuItem(
        value: 2,
        child: ListTile(
          title: Text(
            'StringDateNow'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      PopupMenuItem(
        value: 3,
        child: ListTile(
          title: Text(
            'StringSerDate'.tr,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      // PopupMenuItem(
      //   value: 4,
      //   child: ChikeSer(),
      // ),
    ].where((item) {
      // شرط التصفية
      return true; // استبدل `true` بشرطك الخاص
    }).toList();
  }


  Future<dynamic> buildShowSetting_COU(BuildContext context) async {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "Stringsetting".tr,
      content: GetBuilder<Sale_Invoices_Controller>(
          init: Sale_Invoices_Controller(),
          builder: ((controller) => Column(
            children: [
              DropdownBra_InfBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownBil_PoiBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownCou_Typ_MBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownSYS_CURBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownPAY_KINBuilder(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: controller.isloadingInstallData,
                        onChanged: (value) {
                          controller.isloadingInstallData = value!;
                          controller.update();
                        },
                        activeColor: AppColors.MainColor,
                      ),
                      Text(
                          'StringInstallData'.tr,
                          style: ThemeHelper().buildTextStyle(context, Colors.grey,'M')
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 0.01 * height),
              MaterialButton(
                onPressed: () async {
                  controller.errorText = controller.validate_Continue();
                  controller.update();
                  if (controller.errorText.isNull) {
                    controller.AddSale_Invoices();
                    Get.back();
                    controller.loadingerror(false);
                    LoginController().SET_B_P('InstallData',controller.isloadingInstallData);
                    LoginController().SET_P('BIID_V',controller.SelectDataBIID.toString());
                    LoginController().SET_P('BPID_V',controller.SelectDataBPID.toString());
                    LoginController().SET_P('SIID_V',controller.SelectDataSIID.toString());
                    LoginController().SET_P('CTMID_V',controller.SelectDataCTMID.toString());
                    LoginController().SET_P('CTMTY_V',controller.CTMTYController.toString());
                    LoginController().SET_P('SCID_V',controller.SelectDataSCID.toString());
                    LoginController().SET_D_P('SCEX_SALE',double.parse(controller.SCEXController.text));
                    LoginController().SET_P('PKID_COU',controller.SelectDataPKID.toString());
                    LoginController().SET_N_P('PKID_SALE',int.parse(controller.SelectDataPKID.toString()));

                  } else {
                    controller.loadingerror(true);
                    controller.update();
                  }
                },
                child: Container(
                  height: 0.05 * height,
                  width: 2 * width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.MainColor,
                      borderRadius: BorderRadius.circular(0.02 * height)),
                  child: Text(
                      'StringContinue'.tr,
                      style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
                  ),
                ),
              ),
              SizedBox(height: 0.01 * height),
              MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  height: 0.05 * height,
                  width: 2 * width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.MainColor,
                      borderRadius: BorderRadius.circular(0.02* height)),
                  child: Text(
                      'StringLogout'.tr,
                      style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
                  ),
                ),
              ),
            ],
          ))),
      backgroundColor: Colors.white,
      radius: 30,
      barrierDismissible: false,
    );
  }

  Future<dynamic> buildShowSetting_order(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StringMOV_M_DATA".tr,
      content: GetBuilder<Sale_Invoices_Controller>(
          init: Sale_Invoices_Controller(),
          builder: ((controller) => Column(
            children: [
              DropdownBra_InfBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownBil_PoiBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownSto_InfBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownSYS_CURBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownPAY_KINBuilder(),
              SizedBox(height: 0.01 * height),
              DropdownGET_TYPBuilder(),
              SizedBox(height: 0.01 * height),
              controller.SelectDataGETTYPE=='1'? DropdownRES_SECBuilder():Container(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Checkbox(
                        value: controller.isloadingInstallData,
                        onChanged: (value) {
                          controller.isloadingInstallData = value!;
                          controller.update();
                        },
                        activeColor: AppColors.MainColor,
                      ),
                      Text('StringInstallData'.tr, style: ThemeHelper().buildTextStyle(context, Colors.grey,'M'),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 0.01 * height),
              MaterialButton(
                onPressed: () async {
                  if (controller.SelectDataBIID == null) {
                    Fluttertoast.showToast(
                        msg: 'StringStoch'.tr,
                        textColor: Colors.white,
                        backgroundColor: Colors.red);
                  }
                  else if (controller.SelectDataSIID == null) {
                    Fluttertoast.showToast(
                        msg: 'StringStoch'.tr,
                        textColor: Colors.white,
                        backgroundColor: Colors.red);
                  }
                  else if (controller.SelectDataBPID == null) {
                    Fluttertoast.showToast(
                        msg: 'StringChi_currency'.tr,
                        textColor: Colors.white,
                        backgroundColor: Colors.red);
                  }
                  else if (controller.SelectDataSCID == null) {
                    Fluttertoast.showToast(
                        msg: 'StringChi_currency'.tr,
                        textColor: Colors.white,
                        backgroundColor: Colors.red);
                  }
                  else if (controller.SelectDataPKID == null) {
                    Fluttertoast.showToast(
                        msg: 'StringChi_PAY'.tr,
                        textColor: Colors.white,
                        backgroundColor: Colors.red);
                  }
                  else{
                    if ( controller.SelectDataGETTYPE=='1' && StteingController().SHOW_TAB==true) {
                      controller.SelectDataRTID = null;
                      controller.SelectDataREID = null;
                      controller.GET_RES_SEC_P(controller.SelectDataBIID.toString());
                      showTableSheet('ADD','');
                    //  Get.dialog(Table_View(),);
                    } else {
                      controller.AddSale_Invoices();
                    }
                    LoginController().SET_B_P('InstallData',controller.isloadingInstallData);
                    LoginController().SET_P('BIID_V',controller.SelectDataBIID.toString());
                    LoginController().SET_P('BPID_V',controller.SelectDataBPID.toString());
                    LoginController().SET_P('SIID_V',controller.SelectDataSIID.toString());
                    LoginController().SET_P('SCID_V',controller.SelectDataSCID.toString());
                    LoginController().SET_N_P('PKID_SALE',controller.PKID!);
                    LoginController().SET_P('RSID',controller.SelectDataRSID.toString());
                    LoginController().SET_N_P('BPPR',controller.BPPR!);
                    LoginController().SET_D_P('SCEX_SALE',double.parse(controller.SCEXController.text));
                    controller.update();
                  }
                },
                child: Container(
                  height: 0.05 * height,
                  width: 2 * width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.MainColor,
                      borderRadius: BorderRadius.circular(0.02 * height)),
                  child: Text(
                      'StringContinue'.tr,
                      style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
                  ),
                ),
              ),
              SizedBox(height: 0.01 * height),
              MaterialButton(
                onPressed: () {
                  Get.back();
                },
                child: Container(
                  height: 0.05 * height,
                  width: 2 * width,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: AppColors.MainColor,
                      borderRadius: BorderRadius.circular(0.02* height)),
                  child: Text(
                      'StringLogout'.tr,
                      style: ThemeHelper().buildTextStyle(context, Colors.white,'L')
                  ),
                ),
              ),
            ],
          ))),
      backgroundColor: Colors.white,
      radius: 30,
      barrierDismissible: false,
    );
  }

  GetBuilder<Sale_Invoices_Controller> DropdownBra_InfBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Bra_Inf_Local>>(
            future: GET_BRA(1),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bra_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringBIIDlableText'.tr),
                isExpanded: true,
                hint:  ThemeHelper().buildText(context,'StringBrach', Colors.grey,'S'),
                value: controller.SelectDataBIID,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!
                    .map((item) => DropdownMenuItem<String>(
                  value: item.BIID.toString(),
                  child: Text("${item.BIID.toString()} - ${item.BINA_D.toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                validator: (v) {
                  if (v == null) {
                    return 'StringBrach'.tr;
                  }
                  return null;
                },
                onChanged: (value) async {
                  //Do something when changing the item if you want.
                  controller.SelectDataBIID = value.toString();
                  controller.SelectDataBPID= null;
                  controller.SelectDataSIID = null;
                  controller.SelectDataRSID = null;
                  controller.update();
                  await controller.GET_BIL_POI_ONE_P();
                  controller.update();
                },
              );
            })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownSto_InfBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Sto_Inf_Local>>(
            future: Get_STO_INF(controller.BMKID!,controller.SelectDataBIID.toString(),controller.SelectDataBPID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Sto_Inf_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringBrach',
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
                  child: Text("${item.SIID.toString()} - ${item.SINA_D.toString()}",
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
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownBil_PoiBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Poi_Local>>(
            future: GET_BIL_POI(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Bil_Poi_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringBPIDlableText'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringBPIDlableText', Colors.grey,'S'),
                value: controller.SelectDataBPID,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.BPPR=item.BPPR;
                    controller.BCPR=item.BPPR;
                  },
                  value: item.BPID.toString(),
                  child: Text("${item.BPID.toString()} - ${item.BPNA_D.toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                  ),
                )).toList().obs,
                onChanged: (value) async {
                  controller.SelectDataBPID = value.toString();
                  controller.SelectDataPKID = null;
                  controller.SelectDataSIID = null;
                  await  controller.GET_STO_INF_ONE_P();
                },
              );
            })));
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
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown("${'StringSCIDlableText'.tr}  ${'Stringexchangerate'.tr} ${controller.SCEXController.text}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
            value: controller.SelectDataSCID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!.map((item) => DropdownMenuItem<String>(
              value: item.SCID.toString(),
              onTap: () {
                controller.SCEXController.text = item.SCEX.toString();
                controller.SCNA = item.SCNA_D.toString();
                controller.SCSY = item.SCSY!;
                controller.SCSFL = item.SCSFL!;
                controller.update();
              },
              child:Text("${item.SCID.toString()} - ${item.SCNA_D.toString()}",
                style:ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (v) {
              if (v == null) {
                return 'StringBrach'.tr;
              }
              return null;
            },
            onChanged: (value) {
              controller.SelectDataSCID = value.toString();
              controller.update();
            },
          );
        });
  }

  GetBuilder<Sale_Invoices_Controller> DropdownPAY_KINBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Pay_Kin_Local>>(
            future:GET_PAY_KIN(controller.BMKID!,controller.BMKID==3?'BO':controller.BMKID==1?'BI':'BF',
                controller.UPIN_PKID,controller.SelectDataBPID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Pay_Kin_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StringChi_PAY'.tr,
                );
              }
              return DropdownButtonFormField2(
                decoration: ThemeHelper().InputDecorationDropDown('StringPKIDlableText'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StringChi_PAY', Colors.grey,'S'),
                value: controller.SelectDataPKID,
                style:ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  onTap: (){
                    controller.PKNA= item.PKNA_D.toString();
                  },
                  value: item.PKID.toString(),
                  child: Text("${item.PKID.toString()} - ${item.PKNA_D.toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),)
                ).toList().obs,
                onChanged: (value) {
                  setState(() {
                    //Do something when changing the item if you want.
                    controller.SelectDataPKID = value.toString();
                    controller.PKID = int.parse(value.toString());
                    controller.update();
                  });
                },
              );
            })));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownGET_TYPBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => DropdownButtonFormField2(
          decoration: ThemeHelper().InputDecorationDropDown('StrinGet_Type'.tr),
          isExpanded: true,
          value: controller.SelectDataGETTYPE,
          style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
          items: controller.GET_TYP_LIST.map((item) => DropdownMenuItem<String>(
            value: item['id'],
            child:  Text("${item['id']} - ${item['name']}",
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),)).toList().obs,
          onChanged: (value) {
            controller.SelectDataGETTYPE = value.toString();
            controller.update();
          },
        )));
  }

  GetBuilder<Sale_Invoices_Controller> DropdownRES_SECBuilder() {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Res_Sec_Local>>(
            future:GET_RES_SEC(controller.SelectDataBIID.toString()),
            builder: (BuildContext context,
                AsyncSnapshot<List<Res_Sec_Local>> snapshot) {
              if (!snapshot.hasData) {
                return Dropdown(
                  josnStatus: josnStatus,
                  GETSTRING: 'StrinRSID'.tr,
                );
              }
              return DropdownButtonFormField2(
                decoration:ThemeHelper().InputDecorationDropDown('StrinRSID'.tr),
                isExpanded: true,
                hint: ThemeHelper().buildText(context,'StrinRSID', Colors.grey,'S'),
                value: snapshot.data!.any((item) =>
                item.RSID.toString() == controller.SelectDataRSID)
                    ? controller.SelectDataRSID : null,
                // value: controller.SelectDataRSID,
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                items: snapshot.data!.map((item) => DropdownMenuItem<String>(
                  value: item.RSID.toString(),
                  child: Text("${item.RSID.toString()} - ${item.RSNA_D.toString()}",
                    style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),),)
                ).toList().obs,
                onChanged: (value) {
                  setState(() {
                    //Do something when changing the item if you want.
                    controller.SelectDataRSID = value.toString();
                    controller.update();
                  });
                },
              );
            })));
  }

  FutureBuilder<List<Cou_Typ_M_Local>> DropdownCou_Typ_MBuilder() {
    return FutureBuilder<List<Cou_Typ_M_Local>>(
        future: GET_COU_TYP_M('NOTALL'),
        builder: (BuildContext context,
            AsyncSnapshot<List<Cou_Typ_M_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown('StringCTMIDlableText'.tr),
            isExpanded: true,
            hint:  ThemeHelper().buildText(context,'StringFuelType', Colors.grey,'S'),
            value: controller.SelectDataCTMID,
            style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.CTMID.toString(),
              onTap: () {
                controller.CTMTYController.text = item.CTMTY.toString();
              },
              child: Text("${item.CTMID.toString()} - ${item.CTMNA_D.toString()}",
                style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            ))
                .toList()
                .obs,
            validator: (v) {
              if (v == null) {
                return 'StringBrach'.tr;
              }
              ;
            },
            onChanged: (value) {
              controller.SelectDataCTMID = value.toString();
            },
          );
        });
  }

  GetBuilder<Sale_Invoices_Controller> BIL_MOV_D_SHOW(String TAB_N,String BMMID) {
    return GetBuilder<Sale_Invoices_Controller>(
        init: Sale_Invoices_Controller(),
        builder: ((controller) => FutureBuilder<List<Bil_Mov_D_Local>>(
          future: GET_BIL_MOV_D(TAB_N,BMMID,'','2'),
          builder: (BuildContext context, AsyncSnapshot<List<Bil_Mov_D_Local>> snapshot) {
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
                      child: Text(
                        "${item.NAM.toString()} ${controller.formatter.format(item.BMDNO).toString()} (${controller.formatter.format(item.BMDAM).toString()}) ${
                            controller.formatter.format(
                                controller.roundDouble(item.BMDAMT! + item.BMDTXT!, 3)).toString()}",
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


}