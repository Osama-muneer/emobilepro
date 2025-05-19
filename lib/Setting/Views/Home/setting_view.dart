import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import '../../../Setting/Views/Home/print_view.dart';
import '../../../Setting/Views/Home/print_view_bule.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/downloadfile.dart';
import '../../../Widgets/theme_helper.dart';
import 'printers_settings_page.dart';

class SettingView extends StatefulWidget {
  @override
  State<SettingView> createState() => _SettingViewState();
}

class _SettingViewState extends State<SettingView> {
  final StteingController controller = Get.find();

  final List Size_Font =[
    {'name':'StringBig'.tr,'value':'L'},
    {'name':'StringMiddle'.tr,'value':'M'},
    {'name':'StringSmall'.tr,'value':'S'},
  ];

  Future<dynamic> buildShowDialogSize_Font(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StringFontSize".tr,
      content:Container(
        height: 0.12 * height,
        width: 0.2 * width,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(Size_Font[index]['name'].toString()),
                onTap: (){
                  print(Size_Font[index]['name'].toString());
                  controller.SET_P('Size_Font',Size_Font[index]['value']);
                  controller.SET_P('Size_Font_Name',Size_Font[index]['name'].toString());
                  controller.update();
                  print(controller.Size_Font);
                  Navigator.of(context).pop(false);
                },
              );
            },
            separatorBuilder: (context,index){
              return const Divider(
                color: Colors.blue,
              );
            },
            itemCount: 3),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }

  final List localeType_Invc =[
    {'name':'StringInventory_Insert_Count'.tr,'value':'1'},
    {'name':'StringInventory_Insert'.tr,'value':'2'},
  ];

  Future<dynamic> buildShowDialogType_Inventory(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StringType_Inventory".tr,
      content:Container(
        height: 0.1 * height,
        width: 0.2 * width,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(localeType_Invc[index]['name']),
                onTap: (){
                  controller.SET_P('Type_Inventory',localeType_Invc[index]['value']);
                  controller.SET_P('Type_Inventory_Name',localeType_Invc[index]['name']);
                  Navigator.of(context).pop(false);
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

  void configloading(String MESSAGE){
    EasyLoading.instance
      ..displayDuration = const Duration(milliseconds: 8000)
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorSize = 45.0
      ..radius = 10.0
      ..backgroundColor = Colors.grey[300]
      ..indicatorColor = Colors.black
      ..textColor = Colors.black
      ..maskColor = Colors.blue.withOpacity(0.5)
      ..userInteractions = true
      ..dismissOnTap = true;
    EasyLoading.showInfo(MESSAGE);
  }

  final List locale_list =[
    {'name':'String58thermal'.tr,'value':'58'},
    {'name':'String80thermal'.tr,'value':'80'},
    {'name':'StringA4Form1'.tr,'value':'3'},
    {'name':'StringA4Form2'.tr,'value':'4'},
  ];

  Future<dynamic> buildShowDialogLang(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StrinThermal_printer_paper_size".tr,
      content:Container(
        height: 0.17 * height,
        width: 4 * width,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(locale_list[index]['name'].toString()),
                onTap: (){
                  print(locale_list[index]['name'].toString());
                  controller.SET_P('Thermal_printer_paper_size',locale_list[index]['value']);
                  controller.SET_P('Thermal_printer_paper_size_Name',locale_list[index]['name'].toString());
                  controller.update();
                  print(controller.Thermal_printer_paper_size_Name);
                  Navigator.of(context).pop(false);
                },
              );
            },
            separatorBuilder: (context,index){
              return const Divider(
                color: Colors.red,
              );
            },
            itemCount: locale_list.length),
      ),
      backgroundColor: Colors.white,
      radius: 40,
      // barrierDismissible: false,
    );
  }


  final List Type_Model_list =[
    {'name':'النموذج الاول','value':'1'},
    {'name':'النموذج الثاني','value':'2'},
  ];

  Future<dynamic> buildShowType_Model(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StringType_Model".tr,
      content:Container(
        height: 0.1 * height,
        width: 0.2 * width,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(Type_Model_list[index]['name'].toString()),
                onTap: (){
                  print(Type_Model_list[index]['name'].toString());
                  controller.SET_N_P('Type_Model',int.parse(Type_Model_list[index]['value']));
                  controller.SET_P('Type_Model_Name',Type_Model_list[index]['name']);
                  controller.update();
                  print(controller.Type_Model);
                  Navigator.of(context).pop(false);
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

  Future<dynamic> ShowSalesScreenTemplate(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StringSalesScreenTemplate".tr,
      content:Container(
        height: 0.1 * height,
        width: 0.2 * width,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(Type_Model_list[index]['name'].toString()),
                onTap: (){
                  print(Type_Model_list[index]['name'].toString());
                  controller.SET_N_P('TypeSalesTemplate',int.parse(Type_Model_list[index]['value']));
                  controller.SET_P('SalesScreenTemplate',Type_Model_list[index]['name']);
                  controller.update();
                  print(controller.TypeSalesTemplate);
                  Navigator.of(context).pop(false);
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

  final List Standard_Form_list =[
    {'name':'النموذج الاول','value':'1'},
    {'name':'النموذج الثاني','value':'2'},
  ];

  Future<dynamic> buildShowStandard_Form(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Get.defaultDialog(
      title: "StringStandard_Form".tr,
      titleStyle: ThemeHelper().buildTextStyle(context, Colors.black,'M'),
      content:Container(
        height: 0.1 * height,
        width: 0.2 * width,
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context,index){
              return GestureDetector(
                child: Text(Standard_Form_list[index]['name'].toString()),
                onTap: (){
                  print(Standard_Form_list[index]['name'].toString());
                  controller.SET_N_P('Standard_Form',int.parse(Standard_Form_list[index]['value']));
                  controller.SET_P('Standard_Form_Name',Standard_Form_list[index]['name']);
                  controller.update();
                  print(controller.Type_Model);
                  Navigator.of(context).pop(false);
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

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: ThemeHelper().MainAppBar('StringSettings_APP'.tr),
        body: GetBuilder<StteingController>(
            init: StteingController(),
            builder: ((value) =>  SingleChildScrollView(
              child: STMID=='EORD' ? buildEORD(context,height) :
              STMID=='INVC'?
              buildINVC(context,height):
              STMID=='COU'?controller.currentIndex==0 ?
              buildVARCOU(context, height)
                  :buildPrint(context, height):
              STMID=='MOB' ?controller.currentIndex==0 ?
              buildVARMOB1(context, height):controller.currentIndex==1 ?
              buildVARMOB2(context, height)
                  :buildPrint(context, height):Text(''),
            ))),
        bottomNavigationBar:STMID=='MOB' ?
        SalomonBottomBar(
          currentIndex: controller.currentIndex,
          selectedItemColor: Colors.pink,
          onTap: (index) {
            setState(() {
              print(controller.currentIndex);
              print('controller.currentIndex');
              controller.currentIndex = index;
            });
          },
          items: [
            /// settings1
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("${'StringSettings_APP'.tr} 1"),
              selectedColor: Colors.redAccent,
            ),
            /// settings2
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("${'StringSettings_APP'.tr} 2"),
              selectedColor: Colors.redAccent,
            ),
            /// Reports
            SalomonBottomBarItem(
              icon: Icon(Icons.print),
              title: Text('StrinPrintingVariables'.tr),
              selectedColor: Colors.redAccent,
            ),
          ],
        ):
        STMID=='COU'?
        SalomonBottomBar(
          currentIndex: controller.currentIndex,
          selectedItemColor: Colors.pink,
          onTap: (index) {
            setState(() {
              print(controller.currentIndex);
              print('controller.currentIndex');
              controller.currentIndex = index;
            });
          },
          items: [
            /// settings1
            SalomonBottomBarItem(
              icon: Icon(Icons.settings),
              title: Text("${'StringSettings_APP'.tr}"),
              selectedColor: Colors.redAccent,
            ),
            /// Reports
            SalomonBottomBarItem(
              icon: Icon(Icons.print),
              title: Text('StrinPrintingVariables'.tr),
              selectedColor: Colors.redAccent,
            ),
          ],
        )
            :Text('')
    );
  }

  Column buildVARMOB1(BuildContext context, double height) {
    return Column(
      children: [
        ListTile(
          onTap: (){
            buildShowStandard_Form(context);
          },
          leading: const Icon(Icons.type_specimen,color: Colors.black),
          subtitle: Text(controller.Standard_Form_Name, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringStandard_Form', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        buildSize_Font(context),
        Divider(color: Colors.black,),
        buildIMAGE_APP(context),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
           if(StteingController().isActivateInteractionScreens==true){
             StteingController().SET_B_P('isActivateInteractionScreens',false);
             print(StteingController().isActivateInteractionScreens);
           }else{
             StteingController().SET_B_P('isActivateInteractionScreens',true);
             print(StteingController().isActivateInteractionScreens);
           }
           controller.update();
          },
          leading: Switch(
            value: StteingController().isActivateInteractionScreens,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('isActivateInteractionScreens',value);
                print(StteingController().isActivateInteractionScreens);
              });
            },
          ),
          subtitle: Text('StringActivateInteractionScreens_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringActivateInteractionScreens', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().isActivateInteractionScreens,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('isActivateInteractionScreens',value);
        //           print(StteingController().isActivateInteractionScreens);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringActivateInteractionScreens'.tr),
        //     IconButton(
        //         icon: Icon(
        //           Icons.error,
        //         ),
        //         onPressed: () {
        //           configloading('StringHint_UseBro'.tr);
        //         }),
        //   ],
        // ),
        // Divider(color: Colors.black,),
        //تغعيل مزامنه الحركات بشكل تلقائي عند حفظ الحركه
        ListTile(
          onTap: (){
            if(StteingController().isActivateAutoMoveSync==true){
              StteingController().SET_B_P('isActivateAutoMoveSync',false);
              print(StteingController().isActivateAutoMoveSync);
            }else{
              StteingController().SET_B_P('isActivateAutoMoveSync',true);
              print(StteingController().isActivateAutoMoveSync);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().isActivateAutoMoveSync,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('isActivateAutoMoveSync',value);
                print(StteingController().isActivateAutoMoveSync);
              });
            },
          ),
          subtitle: Text('StringActivateAutoMoveSync_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringActivateAutoMoveSync', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().isActivateAutoMoveSync,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('isActivateAutoMoveSync',value);
        //           print(StteingController().isActivateAutoMoveSync);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringActivateAutoMoveSync'.tr),
        //     IconButton(
        //         icon: Icon(
        //           Icons.error,
        //         ),
        //         onPressed: () {
        //           configloading('StringActivateAutoMoveSync'.tr);
        //         }),
        //   ],
        // ),
        // Divider(color: Colors.black,),
        //اظهار شاشة الدفع
        ListTile(
          onTap: (){
            if(StteingController().Show_Inv_Pay==true){
              StteingController().SET_B_P('Show_Inv_Pay',false);
              print(StteingController().Show_Inv_Pay);
            }else{
              StteingController().SET_B_P('Show_Inv_Pay',true);
              print(StteingController().Show_Inv_Pay);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().Show_Inv_Pay,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('Show_Inv_Pay',value);
                print(StteingController().Show_Inv_Pay);
              });
            },
          ),
          subtitle: Text('StringShow_Inv_Pay_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringShow_Inv_Pay', Colors.black,'M'),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().Show_Inv_Pay,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('Show_Inv_Pay',value);
        //           print(StteingController().Show_Inv_Pay);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringShow_Inv_Pay'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringPrint_Invo_Mess'.tr);
        //         }),
        //   ],
        // ),
        Divider(color: Colors.black,),
        //استخدام الباركود
        ListTile(
          onTap: (){
            if(StteingController().isSwitchBrcode==true){
              StteingController().SET_B_P('isSwitchBrcode',false);
              print(StteingController().isSwitchBrcode);
            }else{
              StteingController().SET_B_P('isSwitchBrcode',true);
              print(StteingController().isSwitchBrcode);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().isSwitchBrcode,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('isSwitchBrcode',value);
                print(StteingController().isSwitchBrcode);
              });
            },
          ),
          subtitle: Text('StringHint_UseBro'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringUseBro', Colors.black,'M'),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().isSwitchBrcode,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('isSwitchBrcode',value);
        //           print(StteingController().isSwitchBrcode);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringUseBro'.tr),
        //     IconButton(
        //         icon: Icon(
        //           Icons.error,
        //         ),
        //         onPressed: () {
        //           configloading('StringHint_UseBro'.tr);
        //         }),
        //   ],
        // ),
        Divider(color: Colors.black,),
        //استخدام المجموعات
        ListTile(
          onTap: (){
            if(StteingController().isSwitchUse_Gro==true){
              StteingController().SET_B_P('isSwitchUse_Gro',false);
              print(StteingController().isSwitchUse_Gro);
            }else{
              StteingController().SET_B_P('isSwitchUse_Gro',true);
              print(StteingController().isSwitchUse_Gro);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().isSwitchUse_Gro,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('isSwitchUse_Gro',value);
                print(StteingController().isSwitchUse_Gro);
              });
            },
          ),
          subtitle: Text('StringHint_UseGro'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringUseGro', Colors.black,'M'),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().isSwitchUse_Gro,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('isSwitchUse_Gro',value);
        //           print(StteingController().isSwitchUse_Gro);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringUseGro'.tr),
        //     IconButton(
        //         icon: Icon(
        //           Icons.error,
        //
        //         ),
        //         onPressed: () {
        //           configloading('StringHint_UseGro'.tr);
        //         }),
        //   ],
        // ),
        Divider(color: Colors.black,),
        //تثبيت المحصل
        ListTile(
          onTap: (){
            if(StteingController().Install_BDID==true){
              StteingController().SET_B_P('Install_BDID',false);
              print(StteingController().Install_BDID);
            }else{
              StteingController().SET_B_P('Install_BDID',true);
              print(StteingController().Install_BDID);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().Install_BDID,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('Install_BDID',value);
                print(StteingController().Install_BDID);
              });
            },
          ),
          subtitle: Text('StringInstall_BDID_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringInstall_BDID', Colors.black,'M'),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().Install_BDID,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('Install_BDID',value);
        //           print(StteingController().Install_BDID);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringInstall_BDID'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringInstall_BDID'.tr);
        //         }),
        //   ],
        // ),
        if(controller.Use_Multi_Stores_BO=='1')Divider(color: Colors.black,),
        if(controller.Use_Multi_Stores_BO=='1')
        ListTile(
            onTap: (){
              if(StteingController().MULTI_STORES_BO==true){
                StteingController().SET_B_P('MULTI_STORES_BO',false);
                print(StteingController().MULTI_STORES_BO);
              }else{
                StteingController().SET_B_P('MULTI_STORES_BO',true);
                print(StteingController().MULTI_STORES_BO);
              }
              controller.update();
            },
            leading: Switch(
              value: StteingController().MULTI_STORES_BO,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('MULTI_STORES_BO',value);
                  print(StteingController().MULTI_STORES_BO);
                });
              },
            ),
            subtitle: Text('StringMULTI_STORES_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringMULTI_STORES', Colors.black,'M'),
          ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().MULTI_STORES_BO,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('MULTI_STORES_BO',value);
        //           print(StteingController().MULTI_STORES_BO);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringMULTI_STORES'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringPrint_Invo_Mess'.tr);
        //         }),
        //   ],
        // ),
        if(controller.Use_Multi_Stores_BI=='1')Divider(color: Colors.black,),
        if(controller.Use_Multi_Stores_BI=='1')
        ListTile(
            onTap: (){
              if(StteingController().MULTI_STORES_BI==true){
                StteingController().SET_B_P('MULTI_STORES_BI',false);
                print(StteingController().MULTI_STORES_BI);
              }else{
                StteingController().SET_B_P('MULTI_STORES_BI',true);
                print(StteingController().MULTI_STORES_BI);
              }
              controller.update();
            },
            leading: Switch(
              value: StteingController().MULTI_STORES_BI,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('MULTI_STORES_BI',value);
                  print(StteingController().MULTI_STORES_BI);
                });
              },
            ),
            subtitle: Text('StringMULTI_STORES_BI_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringMULTI_STORES_BI', Colors.black,'M'),
          ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().MULTI_STORES_BI,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('MULTI_STORES_BI',value);
        //           print(StteingController().MULTI_STORES_BI);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringMULTI_STORES_BI'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringPrint_Invo_Mess'.tr);
        //         }),
        //   ],
        // ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().SHOW_ITEM==true){
              StteingController().SET_B_P('SHOW_ITEM',false);
              print(StteingController().SHOW_ITEM);
            }else{
              StteingController().SET_B_P('SHOW_ITEM',true);
              print(StteingController().SHOW_ITEM);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().SHOW_ITEM,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('SHOW_ITEM',value);
                if(value==true){
                  StteingController().SET_B_P('SHOW_ITEM_C',false);
                }
                controller.update();
                print(StteingController().SHOW_ITEM);
              });
            },
          ),
          subtitle: Text('StringSHOW_ITEM_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringSHOW_ITEM', Colors.black,'M'),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().SHOW_ITEM,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('SHOW_ITEM',value);
        //           if(value==true){
        //             StteingController().SET_B_P('SHOW_ITEM_C',false);
        //           }
        //           controller.update();
        //           print(StteingController().SHOW_ITEM);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringSHOW_ITEM'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringSHOW_ITEM'.tr);
        //         }),
        //   ],
        // ),
        Divider(color: Colors.black,),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().SHOW_ITEM_C,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //           StteingController().SET_B_P('SHOW_ITEM_C',value);
        //           if(value==true){
        //             StteingController().SET_B_P('SHOW_ITEM',false);
        //           }
        //           controller.update();
        //           print(StteingController().SHOW_ITEM_C);
        //       },
        //     ),
        //     buildTextSetting('StringSHOW_ITEM_C'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringSHOW_ITEM_C'.tr);
        //         }),
        //   ],
        // ),
        // Divider(color: Colors.black,),
      ],
    );
  }
  Column buildVARMOB2(BuildContext context, double height) {
    return Column(
      children: [
        if(controller.PRINT_INV!='1')
        ListTile(
            onTap: (){
              if(StteingController().Print_Balance==true){
                StteingController().SET_B_P('Print_Balance',false);
                print(StteingController().Print_Balance);
              }else{
                StteingController().SET_B_P('Print_Balance',true);
                print(StteingController().Print_Balance);
              }
              controller.update();
            },
            leading: Switch(
              value: StteingController().Print_Balance,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('Print_Balance',value);
                  print(StteingController().Print_Balance);
                });
              },
            ),
            subtitle: Text('StringPrint_Balance_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringPrint_Balance', Colors.black,'M'),
          ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().PRINT_BALANCE==true){
              StteingController().SET_B_P('PRINT_BALANCE',false);
              print(StteingController().PRINT_BALANCE);
            }else{
              StteingController().SET_B_P('PRINT_BALANCE',true);
              print(StteingController().PRINT_BALANCE);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().PRINT_BALANCE,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('PRINT_BALANCE',value);
                print(StteingController().PRINT_BALANCE);
              });
            },
          ),
          subtitle: Text('StringInclude_Balance_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringInclude_Balance', Colors.black,'M'),
        ),
        if(StteingController().PRINT_BALANCE==true)Divider(color: Colors.black,),
        //اظهار تنبيه للتضمين الرصيد عند الطباعة
        if(StteingController().PRINT_BALANCE==true)
          ListTile(
            onTap: (){
              if(StteingController().PRINT_BALANCE_ALERT==true){
                StteingController().SET_B_P('PRINT_BALANCE_ALERT',false);
                print(StteingController().PRINT_BALANCE_ALERT);
              }else{
                StteingController().SET_B_P('PRINT_BALANCE_ALERT',true);
                print(StteingController().PRINT_BALANCE_ALERT);
              }
              controller.update();
            },
            leading: Switch(
              value: StteingController().PRINT_BALANCE_ALERT,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('PRINT_BALANCE_ALERT',value);
                  print(StteingController().PRINT_BALANCE_ALERT);
                });
              },
            ),
            subtitle: Text('StringInclude_Balance_Alert_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringInclude_Balance_Alert', Colors.black,'M'),
          ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().Print_Balance_Pay==true){
              StteingController().SET_B_P('Print_Balance_Pay',false);
              print(StteingController().Print_Balance_Pay);
            }else{
              StteingController().SET_B_P('Print_Balance_Pay',true);
              print(StteingController().Print_Balance_Pay);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().Print_Balance_Pay,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('Print_Balance_Pay',value);
                print(StteingController().Print_Balance_Pay);
              });
            },
          ),
          subtitle: Text('StringPrint_Balance_Pay_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringPrint_Balance_Pay', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().SHOW_ALTER_REP==true){
              StteingController().SET_B_P('SHOW_ALTER_REP',false);
              print(StteingController().SHOW_ALTER_REP);
            }else{
              StteingController().SET_B_P('SHOW_ALTER_REP',true);
              print(StteingController().SHOW_ALTER_REP);
            }
            controller.update();
          },
          leading:  Switch(
            value: StteingController().SHOW_ALTER_REP,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('SHOW_ALTER_REP',value);
                print(StteingController().SHOW_ALTER_REP);
              });
            },
          ),
          subtitle: Text('StringSHOW_ALTER_REP_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringSHOW_ALTER_REP', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().ALR_CUS_DEBT_SAL==true){
              StteingController().SET_B_P('ALR_CUS_DEBT_SAL',false);
              print(StteingController().ALR_CUS_DEBT_SAL);
            }else{
              StteingController().SET_B_P('ALR_CUS_DEBT_SAL',true);
              print(StteingController().ALR_CUS_DEBT_SAL);
            }
            controller.update();
          },
          leading:   Switch(
            value: StteingController().ALR_CUS_DEBT_SAL,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('ALR_CUS_DEBT_SAL',value);
                print(StteingController().ALR_CUS_DEBT_SAL);
              });
            },
          ),
          subtitle: Text('StringALR_CUS_DEBT_SAL_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringALR_CUS_DEBT_SAL', Colors.black,'M'),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().ALR_CUS_DEBT_SAL,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('ALR_CUS_DEBT_SAL',value);
        //           print(StteingController().ALR_CUS_DEBT_SAL);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringALR_CUS_DEBT_SAL'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringALR_CUS_DEBT_SAL'.tr);
        //         }),
        //   ],
        // ),
        Divider(color: Colors.black,),
        //استخدام التوقيع
        ListTile(
          onTap: () async {
            if(StteingController().UseSignatureValue==true){
              StteingController().SET_B_P('UseSignatureValue',false);
              controller.UPDATEMOB_VAR_P(22,0);
              print(StteingController().UseSignatureValue);
            }else{
              StteingController().SET_B_P('UseSignatureValue',true);
              print(StteingController().UseSignatureValue);
            }
            await controller.UPDATEMOB_VAR_P(21,StteingController().UseSignatureValue==false?0:1);
            controller.update();
          },
          leading: Switch(
            value: controller.UseSignatureValue,
            activeColor: AppColors.MainColor,
            onChanged: (value) async {
              await controller.UPDATEMOB_VAR_P(21,value==false?0:1);
              controller.SET_B_P('UseSignatureValue',value);
              controller.update();
              if(value==false){
                controller.UPDATEMOB_VAR_P(22,0);
                controller.SET_B_P('ShowSignatureAlertValue',false);
              }
            },
          ),
          subtitle: Text('StringUseSignature_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringUseSignature', Colors.black,'M'),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: controller.UseSignatureValue,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) async {
        //          await controller.UPDATEMOB_VAR_P(21,value==false?0:1);
        //           controller.SET_B_P('UseSignatureValue',value);
        //           controller.update();
        //           if(value==false){
        //             controller.UPDATEMOB_VAR_P(22,0);
        //             controller.SET_B_P('ShowSignatureAlertValue',false);
        //           }
        //       },
        //     ),
        //     buildTextSetting('StringUseSignature'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('UseSignature'.tr);
        //         }),
        //   ],
        // ),
        if(controller.UseSignatureValue==true)Divider(color: Colors.black,),
        if(controller.UseSignatureValue==true)
          ListTile(
            onTap: (){
              if(StteingController().ShowSignatureAlertValue==true){
                StteingController().SET_B_P('ShowSignatureAlertValue',false);
                print(StteingController().ShowSignatureAlertValue);
              }else{
                StteingController().SET_B_P('ShowSignatureAlertValue',true);
                print(StteingController().ShowSignatureAlertValue);
              }
              controller.UPDATEMOB_VAR_P(22,StteingController().ShowSignatureAlertValue==false?0:1);
              controller.update();
            },
            leading:  Switch(
              value: StteingController().ShowSignatureAlertValue,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  controller.UPDATEMOB_VAR_P(22,value==false?0:1);
                  controller.SET_B_P('ShowSignatureAlertValue',value);
                });
              },
            ),
            subtitle: Text('StringShowSignatureAlert_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringShowSignatureAlert', Colors.black,'M'),
          ),
        Divider(color: Colors.black,),
        if(LoginController().USE_WS=='1')
          ListTile(
            onTap: (){
              if(StteingController().WAT_ACT==true){
                StteingController().SET_B_P('WAT_ACT',false);
                print(StteingController().WAT_ACT);
              }else{
                StteingController().SET_B_P('WAT_ACT',true);
                print(StteingController().WAT_ACT);
              }
              controller.update();
            },
            leading:  Switch(
              value: StteingController().WAT_ACT,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                StteingController().SET_B_P('WAT_ACT',value);
                print(StteingController().WAT_ACT);
                controller.update();
              },
            ),
            subtitle: Text('StringUSE_WAT'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringUSE_WAT', Colors.black,'M'),
          ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().WAT_ACT,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //           StteingController().SET_B_P('WAT_ACT',value);
        //           print(StteingController().WAT_ACT);
        //           controller.update();
        //       },
        //     ),
        //     buildTextSetting('StringUSE_WAT'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringUSE_WAT'.tr);
        //         }),
        //   ],
        // ),
        if(LoginController().USE_WS=='1')Divider(color: Colors.black,),
        if(StteingController().WAT_ACT==true)
          ListTile(
            onTap: (){
              if(StteingController().USE_WAT_ALERT==true){
                StteingController().SET_B_P('USE_WAT_ALERT',false);
                print(StteingController().USE_WAT_ALERT);
              }else{
                StteingController().SET_B_P('USE_WAT_ALERT',true);
                print(StteingController().USE_WAT_ALERT);
              }
              controller.update();
            },
            leading: Switch(
              value: StteingController().USE_WAT_ALERT,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                StteingController().SET_B_P('USE_WAT_ALERT',value);
                print(StteingController().USE_WAT_ALERT);
                controller.update();
              },
            ),
            subtitle: Text('StringUSE_WAT_ALERT'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringUSE_WAT_ALERT', Colors.black,'M'),
          ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().USE_WAT_ALERT,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //           StteingController().SET_B_P('USE_WAT_ALERT',value);
        //           print(StteingController().USE_WAT_ALERT);
        //           controller.update();
        //       },
        //     ),
        //     buildTextSetting('StringUSE_WAT_ALERT'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringUSE_WAT_ALERT'.tr);
        //         }),
        //   ],
        // ),
        if(StteingController().WAT_ACT==true) Divider(color: Colors.black,),
      ],
    );
  }
  Column buildVARCOU(BuildContext context, double height) {
    return Column(
      children: [
        buildSize_Font(context),
        Divider(color: Colors.black,),
        buildIMAGE_APP(context),
        Divider(color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            buildTextSetting('StrinlChice_item'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                  size: 0.026 * height,
                ),
                onPressed: () {
                  configloading('StringHint_Type_Ser'.tr);
                }),
          ],
        ),
        Type_SerachButton(value: 0,title:'StrinlChice_item_QUANTITY'.tr),
        Type_SerachButton(value: 1,title:'StrinlChice_item_Total'.tr),
        Divider(color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: LoginController().InstallData,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  LoginController().SET_B_P('InstallData', value);
                });
              },
            ),
            buildTextSetting('StringInstallData'.tr),
            IconButton(
                icon: Icon(Icons.error, size: 0.026 * height),
                onPressed: () {
                  configloading('StringHint_UseBro'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: LoginController().InstallAddAfterSaving,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  LoginController().SET_B_P('InstallAddAfterSaving', value);
                });
              },
            ),
            buildTextSetting('StringInstallAddAfterSaving'.tr),
            IconButton(
                icon: Icon(Icons.error, size: 0.026 * height),
                onPressed: () {
                  configloading('StringInstallAddAfterSaving'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black, height: 0.01 * height),
        //تغعيل مزامنه الحركات بشكل تلقائي عند حفظ الحركه
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isActivateAutoMoveSync,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isActivateAutoMoveSync',value);
                  print(StteingController().isActivateAutoMoveSync);
                });
              },
            ),
            buildTextSetting('StringActivateAutoMoveSync'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringActivateAutoMoveSync'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black, height: 0.01 * height),
        //تضمين البيانات الاضافيه الى التفاصيل عند المزامنه
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: LoginController().IncludeAdditionalSyncing,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  LoginController().SET_B_P('IncludeAdditionalSyncing',value);
                  print(LoginController().IncludeAdditionalSyncing);
                });
              },
            ),
            buildTextSetting('StringIncludeAdditionalSyncing'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('IncludeAdditionalSyncing'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black, height: 0.01 * height),
        controller.USING_TAX_SALES=='3'? Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().UPIN_USING_TAX_SALES,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  // StteingController().setUSING_TAX_SALES(value);
                  print(StteingController().UPIN_USING_TAX_SALES);
                });
              },
            ),
            buildTextSetting('StrinPriceincludeTax'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                  size: 0.026 * height,
                ),
                onPressed: () {
                  configloading('StringHint_CollectionOfItems'.tr);
                }),
          ],
        )
            : Container(),
        controller.USING_TAX_SALES=='3'?
        Divider(color: Colors.black, height: 0.01 * height):Container(),
      ],
    );
  }
  Column buildPrint(BuildContext context, double height) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            children: [
              Expanded(
                child: _buildMarginField(1,"StringTopMargin".tr,controller.topMarginController,controller.topMarginFocus),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildMarginField(2,"StringBottomMargin".tr, controller.bottomMarginController,controller.bottomMarginFocus),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Expanded(
                child: _buildMarginField(3,"StringleftMargin".tr,controller.leftMarginController,controller.leftMarginFocus),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildMarginField(4,"StringRightMargin".tr, controller.rightMarginController,controller.rightMarginFocus),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: _buildMarginField(5,"StringFontSize".tr,controller.fontSizeController,controller.fontSizeFocus),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: _buildMarginField(6,"StringNumber_Cop".tr,controller.Number_CopController,controller.copiesFocus),
        ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().isPrint==true){
              StteingController().SET_B_P('isPrint',false);
              print(StteingController().isPrint);
            }else{
              StteingController().SET_B_P('isPrint',true);
              print(StteingController().isPrint);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().isPrint,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('isPrint',value);
                print(StteingController().isPrint);
              });
            },
          ),
          subtitle: Text('StringPrint_Invo_Mess'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringPrint_Invo', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        if(STMID=='MOB')
          ListTile(
            onTap: (){
              if(StteingController().isPrint_VOU==true){
                StteingController().SET_B_P('isPrint_VOU',false);
                print(StteingController().isPrint_VOU);
              }else{
                StteingController().SET_B_P('isPrint_VOU',true);
                print(StteingController().isPrint_VOU);
              }
              controller.update();
            },
            leading: Switch(
              value: StteingController().isPrint_VOU,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isPrint_VOU',value);
                  print(StteingController().isPrint_VOU);
                });
              },
            ),
            subtitle: Text('StringisPrint_VOU_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringisPrint_VOU', Colors.black,'M'),
          ),
        if(STMID=='MOB') Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().SHOW_REP_HEADER==true){
              StteingController().SET_B_P('SHOW_REP_HEADER',false);
              print(StteingController().SHOW_REP_HEADER);
            }else{
              StteingController().SET_B_P('SHOW_REP_HEADER',true);
              print(StteingController().SHOW_REP_HEADER);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().SHOW_REP_HEADER,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('SHOW_REP_HEADER',value);
                print(StteingController().SHOW_REP_HEADER);
              });
            },
          ),
          subtitle: Text('StringShow_Rep_Header_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringShow_Rep_Header', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().REPEAT_REP_HEADER==true){
              StteingController().SET_B_P('REPEAT_REP_HEADER',false);
              print(StteingController().REPEAT_REP_HEADER);
            }else{
              StteingController().SET_B_P('REPEAT_REP_HEADER',true);
              print(StteingController().REPEAT_REP_HEADER);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().REPEAT_REP_HEADER,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('REPEAT_REP_HEADER',value);
                print(StteingController().REPEAT_REP_HEADER);
              });
            },
          ),
          subtitle: Text('StringREPEAT_REP_HEADER_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringREPEAT_REP_HEADER', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().REPEAT_SIN_FOOTER==true){
              StteingController().SET_B_P('REPEAT_SIN_FOOTER',false);
              print(StteingController().REPEAT_SIN_FOOTER);
            }else{
              StteingController().SET_B_P('REPEAT_SIN_FOOTER',true);
              print(StteingController().REPEAT_SIN_FOOTER);
            }
            controller.update();
          },
          leading:Switch(
            value: StteingController().REPEAT_SIN_FOOTER,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('REPEAT_SIN_FOOTER',value);
                print(StteingController().REPEAT_SIN_FOOTER);
              });
            },
          ),
          subtitle: Text('StringREPEAT_signature_Footer_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringREPEAT_signature_Footer', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        //طباعة شعار المنشاه
        ListTile(
          onTap: (){
            if(StteingController().Print_Image==true){
              StteingController().SET_B_P('Print_Image',false);
              print(StteingController().Print_Image);
            }else{
              StteingController().SET_B_P('Print_Image',true);
              print(StteingController().Print_Image);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().Print_Image,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('Print_Image',value);
                print(StteingController().Print_Image);
              });
            },
          ),
          subtitle: Text('StringPrint_Image_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringPrint_Image', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        //اظهار رقم الصنف عند طباعة الفاتورة
        ListTile(
          onTap: (){
            if(StteingController().Show_MINO==true){
              StteingController().SET_B_P('Show_MINO',false);
              print(StteingController().Show_MINO);
            }else{
              StteingController().SET_B_P('Show_MINO',true);
              print(StteingController().Show_MINO);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().Show_MINO,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('Show_MINO',value);
                print(StteingController().Show_MINO);
              });
            },
          ),
          subtitle: Text('StringShow_MINO_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringShow_MINO', Colors.black,'M'),
        ),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            if(StteingController().Show_MINO==true){
              StteingController().SET_B_P('Show_MINO',false);
              print(StteingController().Show_MINO);
            }else{
              StteingController().SET_B_P('Show_MINO',true);
              print(StteingController().Show_MINO);
            }
            controller.update();
          },
          leading: Switch(
            value: StteingController().Show_BMDID,
            activeColor: AppColors.MainColor,
            onChanged: (value) {
              setState(() {
                StteingController().SET_B_P('Show_BMDID',value);
                print(StteingController().Show_BMDID);
              });
            },
          ),
          subtitle: Text('StringShow_BMDID_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringShow_BMDID', Colors.black,'M'),
        ),
        // Divider(color: Colors.black,),
        // ListTile(
        //   onTap: (){
        //     if(StteingController().Type_Print==true){
        //       StteingController().SET_B_P('Type_Print',false);
        //       print(StteingController().Type_Print);
        //     }else{
        //       StteingController().SET_B_P('Type_Print',true);
        //       print(StteingController().Type_Print);
        //     }
        //     controller.update();
        //   },
        //   leading: Switch(
        //     value: StteingController().Type_Print,
        //     activeColor: AppColors.MainColor,
        //     onChanged: (value) {
        //       setState(() {
        //         StteingController().SET_B_P('Type_Print',value);
        //         print(StteingController().Type_Print);
        //       });
        //     },
        //   ),
        //   subtitle: Text('StringType_print_alr'.tr, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
        //   title: ThemeHelper().buildText(context,'StringType_print', Colors.black,'M'),
        // ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //   children: <Widget>[
        //     Switch(
        //       value: StteingController().Type_Print,
        //       activeColor: AppColors.MainColor,
        //       onChanged: (value) {
        //         setState(() {
        //           StteingController().SET_B_P('Type_Print',value);
        //           print(StteingController().Type_Print);
        //         });
        //       },
        //     ),
        //     buildTextSetting('StringType_print'.tr),
        //     IconButton(
        //         icon: Icon(Icons.error,),
        //         onPressed: () {
        //           configloading('StringPrint_Invo_Mess'.tr);
        //         }),
        //   ],
        // ),
        Divider(color: Colors.black,),
        ListTile(
            onTap: () async {
              await controller.Get_Printers();
              Navigator.push(context, MaterialPageRoute(builder: (_)=>
             // StteingController().Type_Print==false?PrintersSettingsPage():Bule_Print_View(),));
              PrintersSettingsPage()));
            },
            leading:  (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
            Icon(Icons.print,color: Colors.black):Container(),
            subtitle: Text(controller.PrintController.text, style:
            ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StrinPrinter', Colors.black,'M')),
        Divider(color: Colors.black,),
        ListTile(
            onTap: (){
              buildShowDialogLang(context);
            },
            leading: (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
            Icon(Icons.newspaper,color: Colors.black):Container(),
            subtitle: Text(controller.Thermal_printer_paper_size_Name, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StrinThermal_printer_paper_size', Colors.black,'M')),
        Divider(color: Colors.black,),
        ListTile(
          onTap: (){
            buildShowType_Model(context);
          },
          leading: (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
          Icon(Icons.type_specimen,color: Colors.black):Container(),
          subtitle: Text(controller.Type_Model_Name, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
          title: ThemeHelper().buildText(context,'StringType_Model', Colors.black,'M'),),
        Divider(color: Colors.black,),
      ],
    );
  }
  Column buildEORD(BuildContext context, double height) {
    return Column(
      children: [
       // if(LoginController().experimentalcopy != 1)
       //  ListTile(
       //      onTap: (){
       //        ShowSalesScreenTemplate(context);
       //      },
       //      leading: const Icon(Icons.type_specimen,color: Colors.black),
       //      subtitle: Text('${controller.SalesScreenTemplate}', style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
       //      title: Text('StringSalesScreenTemplate'.tr,
       //        style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),)),
       //  const Divider(color: Colors.black,),
        buildSize_Font(context),
        Divider(color: Colors.black,),
        buildIMAGE_APP(context),
        Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: LoginController().InstallData,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  LoginController().SET_B_P('InstallData', value);
                });
              },
            ),
            buildTextSetting('StringInstallData'.tr),
            IconButton(
                icon: Icon(Icons.error, size: 0.026 * height),
                onPressed: () {
                  configloading('StringHint_UseBro'.tr);
                }),
          ],
        ),
        const Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isPrint,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isPrint',value);
                  print(StteingController().isPrint);
                });
              },
            ),
            buildTextSetting('StringPrint_Invo'.tr),
            IconButton(
                icon: Icon(Icons.error,),
                onPressed: () {
                  configloading('StringPrint_Invo_Mess'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().Show_MINO,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('Show_MINO',value);
                  print(StteingController().Show_MINO);
                });
              },
            ),
            buildTextSetting('StringShow_MINO'.tr),
            IconButton(
                icon: Icon(Icons.error,),
                onPressed: () {
                  configloading('StringPrint_Invo_Mess'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().Show_BMDID,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('Show_BMDID',value);
                  print(StteingController().Show_BMDID);
                });
              },
            ),
            buildTextSetting('StringShow_BMDID'.tr),
            IconButton(
                icon: Icon(Icons.error,),
                onPressed: () {
                  configloading('StringPrint_Invo_Mess'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().Print_Image,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('Print_Image',value);
                  print(StteingController().Print_Image);
                });
              },
            ),
            buildTextSetting('StringPrint_Image'.tr),
            IconButton(
                icon: Icon(Icons.error,),
                onPressed: () {
                  configloading('StringPrint_Invo_Mess'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().Type_Print,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('Type_Print',value);
                  print(StteingController().Type_Print);
                });
              },
            ),
            buildTextSetting('StringType_print'.tr),
            IconButton(
                icon: Icon(Icons.error,),
                onPressed: () {
                  configloading('StringPrint_Invo_Mess'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().SHOW_TAB,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('SHOW_TAB',value);
                  print(StteingController().SHOW_TAB);
                });
              },
            ),
            buildTextSetting('StringSHOW_TAB'.tr),
            IconButton(
                icon: Icon(Icons.error,),
                onPressed: () {
                  configloading('StringPrint_Invo_Mess'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black,),
        if(LoginController().experimentalcopy != 1)
        ListTile(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (_)=>
              StteingController().Type_Print==false?
              Print_View():Bule_Print_View(),));
            },
            leading: const Icon(Icons.print,color: Colors.black),
            subtitle: Text(controller.PrintController.text, style: TextStyle(
                fontSize: 12,color: Colors.black)),
            title: Text('StrinPrinter'.tr,
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold),)),
        if(LoginController().experimentalcopy != 1)
        Divider(color: Colors.black, height: 0.02 * height),
        if(LoginController().experimentalcopy != 1)
        ListTile(
            onTap: (){
              buildShowDialogLang(context);
            },
            leading: const Icon(Icons.newspaper,color: Colors.black),
            subtitle: Text(controller.Thermal_printer_paper_size_Name, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: Text('StrinThermal_printer_paper_size'.tr,
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),)),
        if(LoginController().experimentalcopy != 1)
        Divider(color: Colors.black, height: 0.02 * height),
        if(LoginController().experimentalcopy != 1)
        ListTile(
            onTap: (){
              buildShowType_Model(context);
            },
            leading: const Icon(Icons.type_specimen,color: Colors.black),
            subtitle: Text(controller.Type_Model_Name, style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: Text('StringType_Model'.tr,
              style: ThemeHelper().buildTextStyle(context, Colors.black,'M'),)),
        if(LoginController().experimentalcopy != 1)
        Divider(
            color: Colors.black, height: 0.02 * height),
      ],
    );
  }
  Column buildINVC(BuildContext context, double height) {
    return  Column(
      children: [
        buildSize_Font(context),
        Divider(
            color: Colors.black, height: 0.01 * height),
        ListTile(
            onTap: (){
              buildShowDialogType_Inventory(context);
            },
            leading: const Icon(Icons.newspaper,color: Colors.black),
            subtitle: Text(controller.Type_Inventory_Name.toString(),
            style: ThemeHelper().buildTextStyle(context, Colors.black,'S')),
            title: ThemeHelper().buildText(context,'StringType_Inventory', Colors.black,'M'),),
        Divider(
            color: Colors.black),
        buildIMAGE_APP(context),
        Divider(color: Colors.black,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isActivateAutoMoveSync,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isActivateAutoMoveSync',value);
                  print(StteingController().isActivateAutoMoveSync);
                });
              },
            ),
            buildTextSetting('StringActivateAutoMoveSync'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringActivateAutoMoveSync'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black, height: 0.001 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isSwitchBrcode,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isSwitchBrcode',value);
                  print(StteingController().isSwitchBrcode);
                });
              },
            ),
            buildTextSetting('StringUseBro'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_UseBro'.tr);
                }),
          ],
        ),
        if(StteingController().isSwitchBrcode==true)
        Divider(
            color: Colors.black, height: 0.01 * height),
        if(StteingController().isSwitchBrcode==true)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().SHOW_BRCODE_SAVE,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                StteingController().SET_B_P('SHOW_BRCODE_SAVE',value);
                print(StteingController().SHOW_BRCODE_SAVE);
                controller.update();
              },
            ),
            buildTextSetting('StringShow_Brcode'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_UseBro'.tr);
                }),
          ],
        ),
        Divider(
            color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isSwitchCollectionOfItems,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isSwitchCollectionOfItems',value);
                  print(StteingController().isSwitchCollectionOfItems);
                });
              },
            ),
            buildTextSetting('StringCollectionOfItems'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_CollectionOfItems'.tr);
                }),
          ],
        ),
        Divider(
            color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isSwitchShowMesMat,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isSwitchShowMesMat',value);
                  if(StteingController().isSave_Automatic==true && StteingController().isSwitchShowMesMat==true){
                    StteingController().SET_B_P('isSwitchShowMesMat',false);
                  }
                  print(StteingController().isSwitchShowMesMat);
                });
              },
            ),
            buildTextSetting('StringMesMat'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_MesMat'.tr);
                }),
          ],
        ),
        Divider(
            color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isSwitchUse_Gro,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isSwitchUse_Gro',value);
                  print(StteingController().isSwitchUse_Gro);
                });
              },
            ),
            buildTextSetting('StringUseGro'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_UseGro'.tr);
                }),
          ],
        ),
        Divider(
            color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isShow_Mat_No_SNNO,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isShow_Mat_No_SNNO',value);
                  print(StteingController().isShow_Mat_No_SNNO);
                });
              },
            ),
            buildTextSetting('StringisShow_Mat_No_SNNO'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_isShow_Mat_No_SNNO'.tr);
                }),
          ],
        ),
        Divider(
            color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isShow_SNNO_OR_DEF,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isShow_SNNO_OR_DEF',value);
                  print(StteingController().isShow_SNNO_OR_DEF);
                  if(value==true){
                    StteingController().SET_D_P('Default_SNNO',1.0);
                    controller.DEFAULTSNNOController.text='1.0';
                    controller.errorText.value = null;
                  }
                });
              },
            ),
            buildTextSetting('StringShow_SNNO_OR_DEF'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_Show_SNNO_OR_DEF'.tr);
                }),
          ],
        ),
        if(StteingController().isShow_SNNO_OR_DEF == false)
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'StringDefault_SNNO'.tr,
                    style: TextStyle(
                      fontSize: 16,),
                  ),
                ),
                //   SizedBox(width: Dimensions.width1,),
                Expanded(
                  child: Obx(() {
                    print('rebuild TextFormField ${controller.errorText.value}');
                    return TextFormField(
                      style: TextStyle(
                          fontSize:
                          16),
                      controller: controller.DEFAULTSNNOController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(
                                  0.2 * height),
                              borderSide: BorderSide(
                                  color: Colors.grey
                                      .shade500)),
                          labelStyle: const TextStyle(
                              color: Colors.grey),
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(
                                  Radius.circular(
                                      0.02 * height))),
                          errorText: controller
                              .errorText.value),
                      onChanged: (v) {
                        //if(v.isNotEmpty) {
                        controller.validateDefault_SNNO(v);
                        // StteingController().setDefault_SSNO(int.parse(controller.DEFAULTSNNOController.text));
                        // }
                      },
                    );
                  },
                  ),
                ),
              ],
            ),
          ],
        ),
        Divider(
            color: Colors.black, height: 0.01 * height),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Switch(
              value: StteingController().isSave_Automatic,
              activeColor: AppColors.MainColor,
              onChanged: (value) {
                setState(() {
                  StteingController().SET_B_P('isSave_Automatic',value);
                  print(StteingController().isSave_Automatic);
                  if(StteingController().isSave_Automatic==true && StteingController().isSwitchShowMesMat==true){
                    StteingController().SET_B_P('isSwitchShowMesMat',false);
                  }
                });
              },
            ),
            buildTextSetting('StringSave_Automatic'.tr),
            IconButton(
                icon: Icon(
                  Icons.error,
                ),
                onPressed: () {
                  configloading('StringHint_Save_Automatic'.tr);
                }),
          ],
        ),
        Divider(color: Colors.black, height: 0.01 * height),],
    );
  }


  Expanded buildTextSetting(StringName) {
    return Expanded(
      flex: 1,
      child: Center(
        child:  ThemeHelper().buildText(context,StringName, Colors.black,'M'),
        // Text(StringName,
        //                 style: TextStyle(
        //                     fontSize: Dimensions.fonText,
        //                     fontWeight: FontWeight.bold),
        //               ),
      ),
    );
  }

  ListTile buildSize_Font(BuildContext context) {
    return ListTile(
      onTap: (){
        buildShowDialogSize_Font(context);
      },
      leading: (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
      Icon(Icons.format_size,color: Colors.black):Container(),
      subtitle: Text(controller.Size_Font_Name, style:
      ThemeHelper().buildTextStyle(context, Colors.black,'S')),
      title: ThemeHelper().buildText(context,'StringFontSize', Colors.black,'M'),
    );
  }

  GetBuilder<StteingController> buildIMAGE_APP(BuildContext context) {
    return GetBuilder<StteingController>(
        builder: ((value) =>  ListTile(
      leading:  LoginController().SOSI!='0'?
           ClipOval(
          child: Image.file(File(SignPicture),
          fit: BoxFit.cover,
          width: 50,
          height: 50,
        ),
      )
          : Icon(Icons.file_download_rounded, color: Colors.black),
      title: ThemeHelper().buildText(context, 'StringGET_IMAGE', Colors.black, 'M'),
      subtitle: ThemeHelper().buildText(context, 'StringGET_IMAGE_ALR', Colors.black, 'S'),
      onTap: () {
        // بدء عملية جلب الصورة
        Socket.connect(LoginController().IP, int.parse(LoginController().PORT),
            timeout: const Duration(seconds: 8)).then((socket) async {
          EasyLoading.instance
            ..displayDuration = const Duration(milliseconds: 2000)
            ..indicatorType = EasyLoadingIndicatorType.fadingCircle
            ..loadingStyle = EasyLoadingStyle.custom
            ..indicatorSize = 45.0
            ..radius = 10.0
            ..progressColor = Colors.white
            ..backgroundColor = Colors.green
            ..indicatorColor = Colors.white
            ..textColor = Colors.white
            ..maskColor = Colors.blue.withOpacity(0.5)
            ..userInteractions = false
            ..dismissOnTap = false;
          EasyLoading.show(status: 'StringShow_Connent'.tr);
          await Future.delayed(const Duration(seconds: 1));
          // جلب الصورة وتحديث المتغير داخل الـ Controller
          GET_IMAGE_APP();
          // socket.destroy();
        }).catchError((error) {
          Get.snackbar('StringCHK_Err_Con'.tr, 'StringCHK_Con'.tr,
              backgroundColor: Colors.red,
              icon: const Icon(Icons.error, color: Colors.white),
              colorText: Colors.white,
              isDismissible: true,
              dismissDirection: DismissDirection.horizontal,
              forwardAnimationCurve: Curves.easeOutBack);
          configloading(error.toString());
          Fluttertoast.showToast(
              msg: "${error.toString()}",
              toastLength: Toast.LENGTH_LONG,
              textColor: Colors.white,
              backgroundColor: Colors.red);
          print("Exception on Socket " + error.toString());
        });
        controller.update();
      },
    )));
  }


  Widget _buildMarginField(TYPE,String label,TextEditingController controller,FocusNode focusNode) {
    return TextField(
      controller: controller,
      focusNode: focusNode, // ربط الحقل بـ FocusNode
      keyboardType: TextInputType.number,
      textAlign: TextAlign.center,
      cursorColor: Colors.red,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(
          color: focusNode.hasFocus ? Colors.red : Colors.grey, // تغيير لون النص بناءً على التركيز
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 1.5),
          borderRadius: BorderRadius.circular(12.0),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey, width: 1.0),
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      onChanged: (v) {
        if (v.isNotEmpty) {
          switch (TYPE) {
            case 1:
              StteingController().SET_D_P('TOP_MARGIN', double.parse(v));
              break;
            case 2:
              StteingController().SET_D_P('BOTTOM_MARGIN', double.parse(v));
              break;
            case 3:
              StteingController().SET_D_P('LEFT_MARGIN', double.parse(v));
              break;
            case 4:
              StteingController().SET_D_P('RIGHT_MARGIN', double.parse(v));
              break;
            case 5:
              StteingController().SET_D_P('FONT_SIZE_PDF', double.parse(v));
              break;
            case 6:
              StteingController().SET_N_P('NUMBER_COPIES_REP', int.parse(v));
              break;
          }
        } else {
          double defaultMargin = 10.0;
          if (TYPE == 1) {
            StteingController().SET_D_P('TOP_MARGIN', defaultMargin);
          } else if (TYPE == 2) {
            StteingController().SET_D_P('BOTTOM_MARGIN', defaultMargin);
          } else if (TYPE == 3) {
            StteingController().SET_D_P('LEFT_MARGIN', defaultMargin);
          } else if (TYPE == 4) {
            StteingController().SET_D_P('RIGHT_MARGIN', defaultMargin);
          } else if (TYPE == 5) {
            StteingController().SET_D_P('FONT_SIZE_PDF', 9.0);
          } else if (TYPE == 6) {
            StteingController().SET_N_P('NUMBER_COPIES_REP', 1);
          }
        }
      },
    );
  }

}

class Type_SerachButton extends StatelessWidget {
  final int value;
  final String title;
  const Type_SerachButton({
    required this.value,
    required this.title,
  });
  @override
  Widget build(BuildContext context) {
    return GetBuilder<StteingController>( init: StteingController(),
        builder: ((stteingController)=> InkWell(
          onTap: () => stteingController.SET_N_P('Type_Serach',value),
          child: Row(
              children: [
            Radio(value: value, groupValue: stteingController.Type_Serach,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              onChanged: (int? v){
                stteingController.SET_N_P('Type_Serach',v!);
                print(v);
                print(stteingController.Type_Serach);
                stteingController.update();
              },
              activeColor: AppColors.MainColor ,
            ),
            const SizedBox(width: 10),
            Text(title,style:  TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold),),
          ]),
        )
        )
    );
  }
}
