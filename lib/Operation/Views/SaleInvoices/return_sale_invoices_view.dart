import 'dart:async';
import '../../../Operation/Controllers/sale_invoices_controller.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:intl/intl.dart';

import '../../../Widgets/theme_helper.dart';
import 'Filter_Sale.dart';


class Return_Sale_Invoices_view extends StatefulWidget {
  const Return_Sale_Invoices_view({Key? key}) : super(key: key);

  @override
  State<Return_Sale_Invoices_view> createState() => _Sale_Invoices_viewState();
}

class _Sale_Invoices_viewState extends State<Return_Sale_Invoices_view> {
  final Sale_Invoices_Controller controller = Get.find();
  late search.SearchBar searchBar;
  String query = '';
  DateTime DateDays = DateTime.now();
  DateTime DateDays_last = DateTime.now();
  final txtController = TextEditingController();
  static const Color grey_5 = Color(0xFFf2f2f2);
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
          controller.get_RETURN_SALE("FromDate");
        });
      });
    }
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        title: Text(controller.BMKID==2?'StringReturn_Purchase'.tr:
        'StringReturn_Sale'.tr,
          style:  ThemeHelper().buildTextStyle(context, AppColors.textColor, 'L')
        ),
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: AppColors.MainColor,
        actions: [
          Row(
            children: [
              searchBar.getSearchAction(context),
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => Fliter_Sales().showFilterSheet(context),
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
    final listDatacustmoerRequest = controller.RETURN_SALE_INV.where((list) {
      final titleLower = list.BMMNO.toString().toLowerCase();
      final authorLower = list.BMMDO.toString().toLowerCase();
      final author2Lower = list.BINA_D.toString().toLowerCase();
      final author3Lower = list.SINA_D.toString().toLowerCase();
      final author4Lower = list.PKNA_D.toString().toLowerCase();
      final author5Lower = list.BMMNA.toString().toLowerCase();
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
      controller.RETURN_SALE_INV = listDatacustmoerRequest;
      if (query == '') {
        controller.get_RETURN_SALE("DateNow");
      }
    });
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
            controller.get_RETURN_SALE("DateNow");
            controller.update();
          });
          print("cleared");
        },
        onClosed: () {
          setState(() {
            controller.get_RETURN_SALE("DateNow");
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
    Navigator.of(context).pop(false);
    LoginController().SET_P('Return_Type','1');
    final shouldPop = await Get.offAllNamed('/Sale_Invoices',arguments: controller.BMKID);
    return shouldPop ?? false;
  }

  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        backgroundColor: grey_5,
        appBar: searchBar.build(context),
        body:   GetBuilder<Sale_Invoices_Controller>(
            init: Sale_Invoices_Controller(),
            builder: ((value) {
              if (controller.RETURN_SALE_INV.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "${ImagePath}no_data.png",
                        height: Dimensions.height60,
                      ),
                      Text('StringNoData'.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: Dimensions.fonAppBar),
                      ),
                    ],
                  ),
                );
              }
              return  ListView.builder(
                itemCount: controller.RETURN_SALE_INV.length,
                itemBuilder: (BuildContext context, int index) =>
                    Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                            Dimensions.width10),
                      ),
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      child: InkWell(
                        onTap: (){
                          controller.EditSales_Invoices(controller.RETURN_SALE_INV[index]);
                        },
                        child: Column(
                          children: [
                            Container(
                              width: double.infinity,
                              color: AppColors.MainColor,
                              padding: EdgeInsets.symmetric(
                                  horizontal: Dimensions.height10),
                              child: Center(
                                child: Text( controller.RETURN_SALE_INV[index].BMMNA.toString(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: Dimensions.fonText,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              height: Dimensions.height85,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(controller.RETURN_SALE_INV[index].BINA_D.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: controller.RETURN_SALE_INV[index].BINA_D.toString().length >= 30
                                                ? Dimensions.fonTextSmall : Dimensions.fonText,
                                            overflow: TextOverflow.clip),
                                      ),
                                      Text(controller.RETURN_SALE_INV[index].SINA_D.toString(),
                                          style: TextStyle(
                                              fontSize: controller.RETURN_SALE_INV[index].SINA_D.toString().length >= 45
                                                  ? Dimensions.fonTextSmall : Dimensions.fonText,
                                              fontWeight: FontWeight.bold)),
                                      Text(controller.RETURN_SALE_INV[index].PKNA_D.toString(),
                                          style: TextStyle(
                                              fontSize: Dimensions.fonText,
                                              fontWeight: FontWeight.bold)),
                                      Text(controller.RETURN_SALE_INV[index].SCNA_D.toString(),
                                          style: TextStyle(
                                              fontSize: Dimensions.fonText,
                                              fontWeight: FontWeight.bold)),
                                      Text('${controller.RETURN_SALE_INV[index].BMMST}'.toString() == '2'
                                          ? 'StringNotfinal'.tr
                                          : '${controller.RETURN_SALE_INV[index].BMMST}'.toString() == '3'
                                          ? 'StringPending'.tr : 'Stringfinal'.tr,
                                          style: '${controller.RETURN_SALE_INV[index].BMMST}'.toString() == '2'
                                              ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.red,
                                            fontSize: Dimensions.fonText,
                                          )
                                              : '${controller.RETURN_SALE_INV[index].BMMST}'
                                              .toString() ==
                                              '3'
                                              ? TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.blueAccent,
                                            fontSize: Dimensions.fonText,
                                          )
                                              : TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.green,
                                            fontSize: Dimensions.fonText,
                                          )),
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: <Widget>[
                                      Text(controller.RETURN_SALE_INV[index].BMMID.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimensions.fonText),
                                      ),
                                      Text("${controller.RETURN_SALE_INV[index].BMMDO.toString().substring(11, 17)
                                      } ${controller.RETURN_SALE_INV[index].BMMDO.toString().substring(0, 11)
                                      }",
                                          style: TextStyle(
                                              fontSize: Dimensions.fonText,
                                              fontWeight: FontWeight.bold)),
                                      Text(
                                        controller.RETURN_SALE_INV[index].BMMNO.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: Dimensions.fonText),
                                      ),
                                      Text(controller.RETURN_SALE_INV[index].BMMDI.toString(),
                                          style: TextStyle(
                                              fontSize: Dimensions.fonText,
                                              fontWeight: FontWeight.bold)),
                                      Text(controller.formatter.format(controller.RETURN_SALE_INV[index].BMMMT).toString(),
                                          style: TextStyle(
                                              fontSize: Dimensions.fonText,
                                              fontWeight: FontWeight.bold)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
              );
            })),
      ),
    );
  }
}
