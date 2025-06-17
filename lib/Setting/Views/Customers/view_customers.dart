import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../Setting/controllers/Customers_Controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart' as search;
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../routes/routes.dart';

class ViewCustomers extends StatefulWidget {
  const ViewCustomers({Key? key}) : super(key: key);

  @override
  State<ViewCustomers> createState() => _ViewCustomersState();
}

class _ViewCustomersState extends State<ViewCustomers> {
  final CustomersController controller = Get.find();
  static const Color grey_5 = Color(0xFFf2f2f2);
  late search.SearchBar searchBar;
  String query = '';
  DateTime DateDays = DateTime.now();
  DateTime DateDays_last = DateTime.now();
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
        controller.TYPE_SHOW = "FromDate";
        setState(() {
          controller.GET_BIL_CUS_P("FromDate");
        });
      });
    }
  }

  void searchRequestData(String query) {
    final listDatacustmoerRequest = controller.BIL_CUS_List.where((list) {
      final titleLower = list.BCID.toString().toLowerCase();
      final authorLower = list.BCNA_D.toString().toLowerCase();
      final searchLower = query.toLowerCase();
      return titleLower.contains(searchLower) ||
          authorLower.contains(searchLower);
    }).toList();

    setState(() {
      this.query = query;
      controller.BIL_CUS_List = listDatacustmoerRequest;
      if (query == '') {
        controller.GET_BIL_CUS_P("ALL");
      }
    });
  }

  void onSubmitted(String value) {
    setState(() => ScaffoldMessenger.of(context).showSnackBar( SnackBar(content:  Text('You wrote $value!'))));
  }

  // دالة لفتح تطبيق الاتصال
  void _callCustomer(String phoneNumber) async {
    if(phoneNumber!='0' ) {
      final Uri callUri = Uri(scheme: 'tel', path: phoneNumber);
      if (await canLaunchUrl(callUri)) {
        await launchUrl(callUri);
      } else {
            Get.snackbar('StringErrorMes'.tr, 'StringCallCustomer'.tr,
            backgroundColor: Colors.redAccent, colorText: Colors.white);
      }
    }
    else{
      Get.snackbar('StringErrorMes'.tr, 'StringCallCustomer'.tr,
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }

  // void OpenCustomerLocation(double latitude, double longitude) async {
  //   if (latitude != 0 && longitude != 0) {
  //     final Uri url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
  //     final bool canLaunchResult = await canLaunchUrl(url);
  //     print('canLaunchResult: $canLaunchResult');
  //     if (canLaunchResult) {
  //       await launchUrl(url, mode: LaunchMode.externalApplication);
  //     } else {
  //       Get.snackbar('خطأ', 'لا يمكن فتح الرابط: $url',
  //           backgroundColor: Colors.redAccent, colorText: Colors.white);
  //     }
  //   } else {
  //     Get.snackbar('خطأ', 'الإحداثيات غير صالحة',
  //         backgroundColor: Colors.redAccent, colorText: Colors.white);
  //   }
  // }


  void OpenCustomerLocation(double latitude, double longitude) async {
    if(latitude!=0 || longitude!=0){
    final url = 'https://www.google.com/maps?q=$latitude,$longitude';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'لا يمكن فتح الرابط: $url';
    }
    }
    else{
      Get.snackbar('StringErrorMes'.tr, 'StringCustomerLocationDisplay'.tr,
          backgroundColor: Colors.redAccent, colorText: Colors.white);
    }
  }


  void showCustomerActionsSheet(item) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                item.BCNA_D.toString(),
                  style: ThemeHelper().buildTextStyle(context, Colors.black,'L')
              ),
              SizedBox(height: 10),
              Divider(),
          
              _buildActionItem(Icons.edit, "StringEdit_Client".tr, () {
                Get.back();
                controller.EditCustomer(item);
                // TODO: تنفيذ تعديل العميل
              //  Get.back();
               // Navigator.of(context).pop(false);
          
              }),
              if(item.BCDL_L!=1)
              _buildActionItem(Icons.delete, "StringDelete_Client".tr, () async {
                Get.back();
                await controller.CHECK_DELETE_BCID_P(item.AANO,item.BCID);
                Get.defaultDialog(
                  title: 'StringMestitle'.tr,
                  middleText: 'StringDeleteMessage'.tr,
                  backgroundColor: Colors.white,
                  radius: 40,
                  textCancel: 'StringNo'.tr,
                  cancelTextColor: Colors.red,
                  textConfirm: 'StringYes'.tr,
                  confirmTextColor:
                  Colors.white,
                  onConfirm: () async {
                    bool isValid =await controller.Delete_BIL_CUS_P(item.BCID, item.AANO);
                    if (isValid) {
                      controller.GET_BIL_CUS_P("DateNow");
                    }
                    Navigator.of(context).pop(false);
                  },
                  // barrierDismissible: false,
                );
                // TODO: تنفيذ حذف العميل
              }),
              _buildActionItem(Icons.receipt_long, "StringCustomer_account_statement".tr, () {
                // TODO: تنفيذ كشف الحساب
                Get.back();
                Get.toNamed(Routes.Account_Statement, arguments: {
                  'TYPE': '2', // تمرير رقم الحساب
                  'AANA': item.BCNA_D, // يمكنك تمرير اسم العميل أيضاً إن كنت بحاجة
                  'AANO': item.AANO, // يمكنك تمرير اسم العميل أيضاً إن كنت بحاجة
                  'GUID': item.GUID, // يمكنك تمرير اسم العميل أيضاً إن كنت بحاجة
                  'BCTL': item.BCTL, // يمكنك تمرير اسم العميل أيضاً إن كنت بحاجة
                  'BCAD': item.BCAD, // يمكنك تمرير اسم العميل أيضاً إن كنت بحاجة
                });
              }),
              _buildActionItem(Icons.file_copy, "StringAdd_customer_invoice".tr, () {
                // TODO: تنفيذ فاتورة العميل
                Get.back();
                Get.toNamed(Routes.Sale_Invoices, arguments: {
                  'TYPE': '2', // تمرير رقم الحساب
                  'BCID': item.BCID.toString(), // تمرير رقم الحساب
                  'BCID2': "${item.BCID.toString()} +++ ${item.BCNA_D.toString()}", // تمرير رقم الحساب
                  'item': item, // يمكنك تمرير اسم العميل أيضاً إن كنت بحاجة
                });
          
              }),
              _buildActionItem(Icons.call, "StringContact_the_customer".tr, () {
                item.BCMO=item.BCMO==null?'0':item.BCMO.toString();
                _callCustomer(item.BCMO); // استدعاء دالة الاتصال
              }),
              _buildActionItem(Icons.location_on, "StringCustomerLocation".tr, () {
                item.BCLAT=item.BCLAT==null?'0':item.BCLAT.toString();
                item.BCLON=item.BCLON==null?'0':item.BCLON.toString();
                OpenCustomerLocation(double.parse(item.BCLAT),double.parse(item.BCLON));
                // _callCustomer(item.BCMO); // استدعاء دالة الاتصال
              }),
          
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title,   style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
      onTap: onTap,
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        title: ThemeHelper().buildText(context,'StringCustomer', Colors.white,'L'),
        backgroundColor: AppColors.MainColor,
        actions: [
          Row(
            children: [
              searchBar.getSearchAction(context),
              PopupMenuButton(
                color: Colors.white,
                enableFeedback: true,
                initialValue: 0,
                elevation: 0.0,
                itemBuilder: (BuildContext context) => <PopupMenuEntry>[
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.TYPE_SHOW = "ALL";
                          controller.GET_BIL_CUS_P("ALL");
                          Navigator.of(context).pop(false);
                          // Get.offAndToNamed(Routes.Inventory);
                        });
                      },
                      child: ListTile(
                        title:  ThemeHelper().buildText(context,'StringShowAll', Colors.black,'M'),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          controller.TYPE_SHOW = "DateNow";
                          controller.GET_BIL_CUS_P("DateNow");
                          Navigator.of(context).pop(false);
                        });
                      },
                      child: ListTile(
                        title:  ThemeHelper().buildText(context,'StringDateNow', Colors.black,'M'),
                      ),
                    ),
                  ),
                  PopupMenuItem(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                        setState(() {
                          _selectDataFromDate(context);
                          controller.GET_BIL_CUS_P("FromDate");

                        });
                      },
                      child: ListTile(
                        title:   ThemeHelper().buildText(context,'StringSerDate', Colors.black,'M'),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          )
        ]);
  }

  _SearchBarDemoHomeState() {
    searchBar =  search.SearchBar(
        hintText: 'StringSearchByCusIDName'.tr,
        inBar: false,
        buildDefaultAppBar: buildAppBar,
        setState: setState,
        onSubmitted: onSubmitted,
        onChanged: searchRequestData,
        // onChanged:,
        onCleared: () {
          print("cleared");
          setState(() {
            controller.GET_BIL_CUS_P("ALL");
          });
        },
        onClosed: () {
          print("closed");
          setState(() {
            controller.GET_BIL_CUS_P("ALL");
          });
        });
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    _SearchBarDemoHomeState();
  }

  Future<bool> onWillPop() async {
    Navigator.of(context).pop(false);
    final shouldPop = await Get.offAllNamed('/Home');
    return shouldPop ?? false;
  }

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return WillPopScope(
      onWillPop: onWillPop,
      child: Scaffold(
        appBar: searchBar.build(context),
        backgroundColor: grey_5,
        body: GetBuilder<CustomersController>(
            init: CustomersController(),
            builder: ((value) {
          if (controller.loading.value == true) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (controller.BIL_CUS_List.isEmpty) {
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
          return  ListView.builder(
            itemCount: controller.BIL_CUS_List.length,
            itemBuilder: (BuildContext context, int index) =>
                InkWell(
                  onTap: (){
                    showCustomerActionsSheet(controller.BIL_CUS_List[index]);
                  },
                  child: Card(
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0.002 * height),
                    ),
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    child: Container(
                      color: Colors.white,
                      child: Column(
                        children: [
                          Container(
                            width: double.infinity,
                            color: AppColors.MainColor,
                            padding: EdgeInsets.symmetric(horizontal: 0.002 * height),
                            child: Center(
                              child: Text(  controller.BIL_CUS_List[index].BCNA_D.toString()!=''?
                              controller.BIL_CUS_List[index].BCNA_D.toString():controller.BIL_CUS_List[index].BCNA.toString(),
                                  style: ThemeHelper().buildTextStyle(context, Colors.white,'L'),),
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            height: 0.12 * height,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(controller.BIL_CUS_List[index].BINA_D.toString(),
                                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                    Text(controller.BIL_CUS_List[index].BANA_D.toString()!='null' ?
                                    controller.BIL_CUS_List[index].BANA_D.toString() : controller.BIL_CUS_List[index].BCAD.toString()!='null' ?
                                    controller.BIL_CUS_List[index].BCAD.toString():'' ,
                                      style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
                                    ),
                                    Text(controller.BIL_CUS_List[index].BCMO.toString()=='null'?'':
                                    controller.BIL_CUS_List[index].BCMO.toString(),
                                        style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(controller.BIL_CUS_List[index].BCID.toString(),style: ThemeHelper().buildTextStyle(context, Colors.black,'M')),
                                    Expanded(
                                      child: IconButton(
                                              icon: Icon(
                                                Icons.sync,
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
                                                    Navigator.of(context).pop(false);
                                                    controller.Socket_IP_Connect('SyncOnly',
                                                        controller.BIL_CUS_List[index].BCID.toString());
                                                    controller.GET_BIL_CUS_P("ALL");
                                                  },
                                                );
                                              }),
                                    ),
                                    Expanded(
                                      child: Padding(
                                            padding:  EdgeInsets.only(bottom: 0.002 * height),
                                            child:ThemeHelper().buildText(context,'StringDoSync', Colors.green,'M'),
                                          ),
                                    ),
                                  ],
                                )
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
            final difference = DateDays_last.difference(DateDays).inDays;
            if (difference >= 30) {
              Get.snackbar('StringCHK_Syn'.tr, 'StringCHK_Syn_Err'.tr,
                  backgroundColor: Colors.red,
                  icon: Icon(Icons.error, color: Colors.white),
                  colorText: Colors.white);
            }
            else {
              controller.AddCustomer();
            }
          },
          label: ThemeHelper().buildText(context,'StringAddCustomer', Colors.white,'M' ),
          icon: const Icon(Icons.add,color: Colors.white),
        ),

          bottomNavigationBar:GetBuilder<CustomersController>(
            init: CustomersController(),
            builder: (controller) {
              return SalomonBottomBar(
                currentIndex: controller.currentIndex,
                selectedItemColor: Colors.pink,
                onTap: (index) async {
                  setState(()  {
                    controller.currentIndex = index;
                    controller.update();
                  });
                  await controller.GET_BIL_CUS_P("DateNow");
                  controller.update();
                },
                items: [
                  /// Home
                  SalomonBottomBarItem(
                    icon: Icon(Icons.thermostat, color: Colors.black),
                    title: Text("${'StringAll'.tr} (${controller.BIL_CUS_List.length})"),
                    selectedColor: Colors.black,
                  ),
                  /// Operation
                  SalomonBottomBarItem(
                    icon: Icon(Icons.thermostat, color: Colors.green),
                    title: Text("${'StringAMMST1'.tr} (${controller.BIL_CUS_List.length})"),
                    selectedColor: Colors.green,
                  ),
                  /// Reports
                  SalomonBottomBarItem(
                    icon: Icon(Icons.thermostat, color: Colors.red),
                    title: Text("${'StringNotApprove'.tr} (${controller.BIL_CUS_List.length})"),
                    selectedColor: Colors.red,
                  ),
                  /// Settings

                ],
              );
              // إرجاع عنصر فارغ إذا لم يكن الشرط صحيحًا
            },
          ),
      ),
    );
  }

}
