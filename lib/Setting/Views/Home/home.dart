import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import '../../../Setting/Views/Home/setting_home_view.dart';
import '../../../Setting/Views/Sync/show_syn_log.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/login_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/config.dart';
import '../../../Setting/controllers/home_controller.dart';
import '../../../Widgets/dropdown.dart';
import '../../../Widgets/sizes_helpers.dart';
import '../../../Widgets/theme_helper.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:upgrader/upgrader.dart';
import '../../../Operation/Views/SaleInvoices/sale_invoices_view.dart';
import '../../../Reports/Views/Invoices_Repert/show_inv_view.dart';
import '../../../database/setting_db.dart';
import '../../controllers/setting_controller.dart';
import '../../models/sys_cur.dart';
import 'Indicators.dart';
import 'backupscreen.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  HomeController controller = Get.find();
  int touchedIndex = -1;
  final String imagePath = ImagePath;
  // خرائط الربط بين SSID والصورة والعنوان والإجراء
  static const Map<int, String> _imgMap = {
    601: 'Sale_Invoices.png',
    901: 'Purchases Invoices.png',
    102: 'Receipt Vouchers.png',
    103: 'Payment Vouchers.png',
    742: 'Sale_Invoices.png',
    621: 'Sale_Invoices.png',
    611: 'Return_Sale.png',
    743: 'Return_Sale.png',
    111: 'JournalVouchers.png',
    91:  'Customer.png',
    202: 'Account_Statement.png',
  };

  static const Map<int, String> _labelMap = {
    601: 'StringSalesInvoice',
    901: 'StringPurchases',
    102: 'StringReceipt',
    103: 'StringPayment',
    742: 'StringSalesInvoice',
    621: 'StringSalesInvoice',
    611: 'StringReturn_Sale_Inv',
    743: 'StringReturn_Sale_Inv',
    111: 'StringJournalVouchers_Home',
    91:  'StringCustomer_Home',
    202: 'StringAccount_Statement',
  };

  late final Map<int, VoidCallback> _actionMap = {
    601: () => controller.GoToInvoiceSales(3),
    901: () => controller.GoToInvoiceSales(1),
    102: () => controller.GoToPay_Out(1),
    103: () => controller.GoToPay_Out(2),
    742: () => controller.GoToInvoiceSales(11),
    621: () => controller.GoToInvoiceSales(5),
    611: () => controller.GoToInvoiceSales(4),
    743: () => controller.GoToInvoiceSales(12),
    111: () => controller.GoToPay_Out(15),
    91:  () {
      if (controller.UPIN_CUS != 1) {
        controller.buildShowDialogPRIV();
      } else {
        Get.toNamed('/View_Customers');
      }
    },
    202: () {
      if (controller.UPIN_ACS != 1) {
        controller.buildShowDialogPRIV();
      } else {
        Get.toNamed('/Account_Statement', arguments: 1);
      }
    },
  };

  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return STMID=='EORD' && LoginController().experimentalcopy != 1?
      Scaffold(
          appBar:controller.currentIndex == 0? buildAppBar(context):null,
          drawer: ThemeHelper().buildDrawer(context),
          body: controller.currentIndex == 0
              ? Indicators_View()
              : controller.currentIndex == 1
              ? Sale_Invoices_view()
              : controller.currentIndex == 2 ?
          Show_Inv_Rep():Setting_Home_View(),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: controller.currentIndex,
            selectedItemColor: Colors.pink,
            onTap: (index) {
              setState(() {
                controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('0');
                controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('1');
                controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('2');
                controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('4');
                controller.currentIndex = index;
              });
            },
            items: [
              /// Home
              SalomonBottomBarItem(
                icon: Icon(Icons.home_filled),
                title: Text('StringHome'.tr),
                selectedColor: Colors.redAccent,
              ),
              ///Operation
              SalomonBottomBarItem(
                icon: Icon(Icons.assignment_rounded),
                title: Text('StringOperation'.tr),
                selectedColor: Colors.redAccent,
              ),
              /// Reports
              SalomonBottomBarItem(
                icon: Icon(Icons.receipt_long),
                title: Text('StringReports'.tr),
                selectedColor: Colors.redAccent,
              ),
              /// settings
              SalomonBottomBarItem(
                icon: Icon(Icons.settings),
                title: Text('Stringsetting'.tr),
                selectedColor: Colors.redAccent,
              ),
            ],
          )
      ) :
      STMID=='REP'?
      Scaffold(
          body: controller.currentIndex == 0
              ? Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              centerTitle:  STMID=='MOB'?false:true,
              backgroundColor: AppColors.MainColor,
              iconTheme: IconThemeData(color: Colors.white),
              title: ThemeHelper().buildText(context,'StringREP', Colors.white,'L'),
            ),
            drawer: ThemeHelper().buildDrawer(context),
            body:  GetBuilder<HomeController>(
                init: HomeController(),
                builder: ((value) {
                  return  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(2.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  color: AppColors.MainColor,
                                  child: ExpansionTile(
                                    collapsedIconColor: Colors.white, iconColor: Colors.white,
                                    leading: const Icon(Icons.assignment_rounded,color: Colors.white),
                                    title: ThemeHelper().buildText(context,'StringACC', Colors.white,'L'),
                                    children: <Widget>[
                                      buildContainer('StringCus_Bal_Rep',1003,'Rep'),
                                      buildContainer('StringSuppliers_Balances_Report',1004,'Rep'),
                                      buildContainer('StringAccounts_Balances_Report',1010,'Rep'),
                                      buildContainer('String1008',1008,'Rep'),
                                      buildContainer('String1016',1016,'Rep'),
                                      buildContainer('String1018',1018,'Rep'),
                                      buildContainer('String1023',1023,'Rep'),
                                      buildContainer('String1025',1025,'Rep'),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 2.h,),
                                Container(
                                  color: AppColors.MainColor,
                                  child: ExpansionTile(
                                    iconColor: Colors.white,
                                    collapsedIconColor: Colors.white,
                                    leading: const Icon(Icons.receipt_long,
                                        color: Colors.white),
                                    title: ThemeHelper().buildText(context,'StringSalesInvoice', Colors.white,'L'),
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        child: Card(
                                          child: Container(
                                            color: Colors.white,
                                            child: ListTile(
                                              //leading: Icon(Icons.add),
                                              title:  ThemeHelper().buildText(context,'StringAccount_Statement', Colors.black,'M'),
                                              //subtitle: Text("Where You Can Register An Account"),
                                              onTap: () {
                                                // if(controller.UPIN_ACS!=1  ){
                                                //   controller.buildShowDialogPRIV();
                                                // }else{
                                                Get.toNamed('/Account_Statement',arguments: 1);
                                                // }
                                              },
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 2.h,),
                                Container(
                                  color: AppColors.MainColor,
                                  child: ExpansionTile(
                                    iconColor: Colors.white,
                                    collapsedIconColor: Colors.white,
                                    leading: const Icon(Icons.settings, color: Colors.white),
                                    title: ThemeHelper().buildText(context,'StringPurchases', Colors.white,'L'),
                                    children: <Widget>[
                                      Container(
                                        color: Colors.white,
                                        child: Card(
                                          child: Container(
                                            color: Colors.white,
                                            child: ListTile(
                                              //leading: Icon(Icons.add),
                                              title: ThemeHelper().buildText(context,'StringCustomer', Colors.black,'M'),
                                              //subtitle: Text("Where You Can Register An Account"),
                                              onTap: () {
                                                if(controller.UPIN_CUS!=1 ){
                                                  controller.buildShowDialogPRIV();
                                                }else{
                                                  Get.toNamed('/View_Customers');
                                                }
                                              },
                                            ),
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
                    ],
                  );
                })),
          )
              : controller.currentIndex == 1
              ? Setting_Home_View()
              : Setting_Home_View(),
          bottomNavigationBar: SalomonBottomBar(
            currentIndex: controller.currentIndex,
            selectedItemColor: Colors.pink,
            onTap: (index) {
              setState(() {
                controller.currentIndex = index;
              });
            },
            items: [
              /// Reports
              SalomonBottomBarItem(
                icon: Icon(Icons.home_filled),
                title: Text('StringREP'.tr),
                selectedColor: Colors.redAccent,
              ),
              ///Statistics
              SalomonBottomBarItem(
                icon: Icon(Icons.assignment_rounded),
                title: Text('StringStatistics'.tr),
                selectedColor: Colors.redAccent,
              ),
              /// settings
              SalomonBottomBarItem(
                icon: Icon(Icons.settings),
                title: Text('Stringsetting'.tr),
                selectedColor: Colors.redAccent,
              ),
            ],
          )
      ) :
      STMID=='INVC'?
      Scaffold(
        appBar: buildAppBar(context),
        drawer: ThemeHelper().buildDrawer(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Column(
                      children: [
                        InkWell(
                          child:  buildStack(context,'Inventory.png','StringInventory_Home'.tr),
                          onTap: () async {
                            controller.GoToInventory(17);
                          },
                        ),
                        InkWell(
                          onTap: (){
                            controller.GoToInventory(1);
                          },
                          child:buildStack( context,'Item_In_Voucher.png','StringItem_In_Voucher_Home'.tr),
                        ),
                      ],),
                    Column(children: [
                      InkWell(
                        child: buildStack( context,'TransferVoucher.png','StringInventoryTransferVoucher_Home'.tr),
                        onTap: (){
                          controller.GoToInventory(13);
                        },
                      ),
                      InkWell(
                        onTap: (){
                          controller.GoToInventory(3);
                        },
                        child:  buildStack( context,'Item_Out_Voucher.png','StringItem_Out_Voucher_Home'.tr),
                      ),
                    ],),
                  ],
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.MainColor,
                      child: ExpansionTile(
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        leading: const Icon(Icons.assignment_rounded,
                            color: Colors.white),
                        title:  ThemeHelper().buildText(context,'StringOperation', Colors.white,'L'),
                        children: <Widget>[
                          buildContainer('StringItem_Out_Voucher'.tr,3,'INVC'),
                          buildContainer('StringItem_In_Voucher'.tr,1,'INVC'),
                          buildContainer('StringInventoryTransferVoucher'.tr,13,'INVC'),
                          buildContainer('StringTransfer_Store_Branches'.tr,131,'INVC'),
                          buildContainer('StringTransfer_Store_Request'.tr,11,'INVC'),
                          buildContainer('StringInventory'.tr,17,'INVC'),
                          buildContainer('StringIncoming_Store'.tr,0,'INVC'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: AppColors.MainColor,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        leading: const Icon(Icons.receipt_long,
                            color: Colors.white),
                        title:  ThemeHelper().buildText(context,'StringReports', Colors.white,'L'),
                        children: <Widget>[
                          buildContainer('StringInventoryReports'.tr,0,'/Invc_Rep'),
                          buildContainer('StrinSto_Num'.tr,0,'/Sto_NUM'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: AppColors.MainColor,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        leading:
                        const Icon(Icons.settings, color: Colors.white),
                        title: ThemeHelper().buildText(context,'Stringsetting', Colors.white,'L'),
                        children: <Widget>[
                          (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
                          Container(
                            color: Colors.white,
                            child: Card(
                              child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  //leading: Icon(Icons.add),
                                  title:  ThemeHelper().buildText(context,'StringSync', Colors.black,'M'),
                                  //subtitle: Text("Where You Can Register An Account"),
                                  onTap: () {
                                    if (LoginController().experimentalcopy == 1) {
                                      Get.defaultDialog(
                                        title: 'StringMestitle'.tr,
                                        middleText: 'Stringexperimentalcopy'.tr,
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        textCancel: 'StringOK'.tr,
                                        cancelTextColor: Colors.blueAccent,
                                      );
                                    } else {
                                      Get.toNamed('/Sync');
                                    }
                                    // Get.toNamed(Routes.Changepassword);
                                  },
                                ),
                              ),
                            ),
                          ):
                          Container(),
                          buildContainer('StringSettings_APP'.tr,0,'/Setting'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ) :
      STMID=='COU'?
      Scaffold(
        appBar: buildAppBar(context),
        drawer: ThemeHelper().buildDrawer(context),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      child:  buildStack(context,'CounterSalePosting.jpg','StringCounterSalesInvoice'.tr),
                      onTap: () async {
                        controller.GoToCounterSalesInvoice(11);
                      },
                    ),
                    InkWell(
                      onTap: (){
                        controller.GoToCounterSalesInvoice(0);

                      },
                      child:buildStack( context,'Approving.jpg','StringCounterSalePosting'.tr),
                    ),
                  ],
                ),
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: AppColors.MainColor,
                      child: ExpansionTile(
                        collapsedIconColor: Colors.white,
                        iconColor: Colors.white,
                        leading: const Icon(Icons.assignment_rounded,
                            color: Colors.white),
                        title:  ThemeHelper().buildText(context,'StringOperation', Colors.white,'L'),
                        children: <Widget>[
                          buildContainer('StringCounterSalesInvoice'.tr,11,'COU'),
                          buildContainer('StringCounterSalePosting'.tr,0,'COU'),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: AppColors.MainColor,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        leading: const Icon(Icons.receipt_long,
                            color: Colors.white),
                        title:  ThemeHelper().buildText(context,'StringReports', Colors.white,'L'),
                        children: <Widget>[
                          //  buildContainer('StrinSto_Num'.tr,0,'/Sto_NUM'),
                          buildContainer('StrinInvoices_Archive'.tr,0,'/Invoices_Archive'),
                          buildContainer('StringSalesReports'.tr,0,'/InvRep'),
                          Container(
                            color: Colors.white,
                            child: Card(
                              child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  //leading: Icon(Icons.add),
                                  title: ThemeHelper().buildText(context,'StringApprovingReports', Colors.black,'M'),
                                  onTap: () {
                                    Get.toNamed('/show_approv_Rep');
                                  },
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 1.h,
                    ),
                    Container(
                      color: AppColors.MainColor,
                      child: ExpansionTile(
                        iconColor: Colors.white,
                        collapsedIconColor: Colors.white,
                        leading:
                        const Icon(Icons.settings, color: Colors.white),
                        title: ThemeHelper().buildText(context,'Stringsetting', Colors.white,'L'),
                        children: <Widget>[
                          (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
                          Container(
                            color: Colors.white,
                            child: Card(
                              child: Container(
                                color: Colors.white,
                                child: ListTile(
                                  //leading: Icon(Icons.add),
                                  title:  ThemeHelper().buildText(context,'StringSync', Colors.black,'M'),
                                  //subtitle: Text("Where You Can Register An Account"),
                                  onTap: () {
                                    if (LoginController().experimentalcopy == 1) {
                                      Get.defaultDialog(
                                        title: 'StringMestitle'.tr,
                                        middleText: 'Stringexperimentalcopy'.tr,
                                        backgroundColor: Colors.white,
                                        radius: 40,
                                        textCancel: 'StringOK'.tr,
                                        cancelTextColor: Colors.blueAccent,
                                      );
                                    } else {
                                      Get.toNamed('/Sync');
                                    }
                                    // Get.toNamed(Routes.Changepassword);
                                  },
                                ),
                              ),
                            ),
                          ):
                          Container(),
                          buildContainer('StringSettings_APP'.tr,0,'/Setting'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ) :
      GetBuilder<HomeController>(
          init: HomeController(),
          builder: ((value) {
              // عندما تكون loading == false، نعرض الدوار
              if (controller.loading.value == false) {
                return SpinKitFadingCircle(
                //  controller: AnimationController(duration: const Duration(milliseconds: 1200), vsync: ),
                  itemBuilder: (BuildContext context, int index) {
                    return DecoratedBox(
                      decoration: BoxDecoration(
                        color: index.isEven ? Colors.red : Colors.grey,
                      ),
                    );
                  },
                );
              }
            return StteingController().Standard_Form==2 ?
            Scaffold(
                appBar: buildAppBar(context),
                drawer: ThemeHelper().buildDrawer(context),
                body: UpgradeAlert(
                  child: SingleChildScrollView(
                    child: controller.currentIndex == 0
                        ? Indicators_View()
                        :controller.currentIndex == 1?
                    Column(
                      children: [
                        buildCard('StringSale_Invoices','SaleInvoices.png',3,'Invoice'),
                        buildCard('StringReturn_Sale_Invoices','ReturnSale.png',4,'Invoice'),
                        buildCard('StringPOS','SaleInvoices.png',11,'Invoice'),
                        buildCard('StringReturn_Sale_Invoices_POS','ReturnSale.png',12,'Invoice'),
                        buildCard('StringService_Bills','Service_Bills.png',5,'Invoice'),
                        buildCard('StringPurchases_Invoices','PurchasesInvoices.png',1,'Invoice'),
                        buildCard('StringReturn_Purchase','ReturnSale.png',2,'Invoice'),
                        buildCard('StringQuotations','Quotations.png',7,'Invoice'),
                        buildCard('StringCustomer_Requests','Customer_Requests.png',10,'Invoice'),
                        buildCard('StringJournalVouchers','Journal_Vouchers.png',15,'Vouchers'),
                        buildCard('StringReceipt_Vouchers','ReceiptVouchers.png',1,'Vouchers'),
                        buildCard('StringPayment_Vouchers','PaymentVouchers.png',2,'Vouchers'),
                        buildCard('StringCollection_Vouchers','ReceiptVouchers.png',3,'Vouchers'),
                      ],
                    )
                        : controller.currentIndex == 2 ?
                    Column(
                      children: [
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading:  Image.asset("${ImagePath}StatementOnline.png",width: 50.h),
                              title: ThemeHelper().buildText(context,'StringAccount_Statement', Colors.black,'M'),
                              //subtitle: Text("Where You Can Register An Account"),
                              onTap: () {
                                // if(controller.UPIN_ACS!=1  ){
                                //   controller.buildShowDialogPRIV();
                                // }else{
                                Get.toNamed('/Account_Statement',arguments: 1);
                                // }
                              },
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading:  Image.asset("${ImagePath}StatementOffline.png",width: 50.h),
                              title: ThemeHelper().buildText(context,'StringAccount_Statement_Online', Colors.black,'M'),
                              onTap: () {
                                if(controller.UPIN_ACS!=1  ){
                                  controller.buildShowDialogPRIV();
                                }else{
                                  Get.toNamed('/Account_Statement',arguments: 2);
                                }
                              },
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading:  Image.asset("${ImagePath}StatementOffline.png",width: 50.h),
                              title: ThemeHelper().buildText(context,'StringACC_STA_H', Colors.black,'M'),
                              onTap: () {
                                if(controller.UPIN_COS!=1  ){
                                  controller.buildShowDialogPRIV();
                                }else{
                                  Get.toNamed('/Account_Statement',arguments: 4);
                                }
                              },
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading:  Image.asset("${ImagePath}StatementOffline.png",width: 50.h),
                              title: ThemeHelper().buildText(context,'StringACC_COS_STA', Colors.black,'M'),
                              onTap: () {
                                if(controller.UPIN_MAIN!=1  ){
                                  controller.buildShowDialogPRIV();
                                }else{
                                  Get.toNamed('/Account_Statement',arguments: 3);
                                }
                              },
                            ),
                          ),
                        ),
                        buildCard('StrinSto_Num'.tr,'Sto_Num.png',0,'/Sto_NUM'),
                        buildCard('StrinInvoices_Archive'.tr,'Invoices_Archive.png',0,'/Invoices_Archive'),
                        buildCard('StringAccountsArchive'.tr,'AccountsArchive.png',0,'/Accounts_Archive'),
                        buildCard('StringSalesReports'.tr,'InventoryReports.png',0,'/InvRep'),
                        buildCard('StringAccounts_Report'.tr,'Accounts_Report.png',0,'/Bal_Rep'),
                      ],
                    ):
                    Column(
                      children: [
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset("${ImagePath}Customers.png",width: 50.h),
                              title:   ThemeHelper().buildText(context,'StringCustomer', Colors.black,'M'),
                              //subtitle: Text("Where You Can Register An Account"),
                              onTap: () {
                                if(controller.UPIN_CUS!=1 ){
                                  controller.buildShowDialogPRIV();
                                }else{
                                  Get.toNamed('/View_Customers');
                                }
                              },
                            ),
                          ),
                        ),
                        buildCard('StringInquiry_Quotation'.tr,'Inquiry_Quotation.png',0,'/Inquiry_Quotation'),
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset("${ImagePath}Sync.png",width: 50.h),
                              title:  ThemeHelper().buildText(context,'StringSync', Colors.black,'M'),
                              //subtitle: Text("Where You Can Register An Account"),
                              onTap: () {
                                if (LoginController().experimentalcopy == 1) {
                                  Get.defaultDialog(
                                    title: 'StringMestitle'.tr,
                                    middleText: 'Stringexperimentalcopy'.tr,
                                    backgroundColor: Colors.white,
                                    radius: 40,
                                    textCancel: 'StringOK'.tr,
                                    cancelTextColor: Colors.blueAccent,
                                  );
                                } else {
                                  Get.toNamed('/Sync');
                                }
                                // Get.toNamed(Routes.Changepassword);
                              },
                            ),
                          ),
                        ),
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset("${ImagePath}SyncArchive.png",width: 50.h),
                              title:  ThemeHelper().buildText(context,'StrinSyncArchive', Colors.black,'M'),
                              onTap: () {
                                if (LoginController().experimentalcopy == 1) {
                                  Get.defaultDialog(
                                    title: 'StringMestitle'.tr,
                                    middleText: 'Stringexperimentalcopy'.tr,
                                    backgroundColor: Colors.white,
                                    radius: 40,
                                    textCancel: 'StringOK'.tr,
                                    cancelTextColor: Colors.blueAccent,
                                  );
                                } else {
                                  Get.to(() => Show_Syn_Log());
                                }
                              },
                            ),
                          ),
                        ),
                        STMID=='MOB'?
                        buildCard('StringUploaddata'.tr,'Sync.png',0,'/SyncToServer') :Container(),
                        buildCard('StringSettings_APP'.tr,'Settings.png',0,'/Setting'),
                        Card(
                          child: Container(
                            color: Colors.white,
                            child: ListTile(
                              leading: Image.asset("${ImagePath}SyncArchive.png",width: 50.h),
                              title:  ThemeHelper().buildText(context,'StringBk_Br', Colors.black,'M'),
                              onTap: () {
                                Get.to(() => BackupScreen());
                              },
                            ),
                          ),
                        ),
                      ],
                    ),),
                ),
                bottomNavigationBar: SalomonBottomBar(
                  currentIndex: controller.currentIndex,
                  selectedItemColor: Colors.pink,
                  onTap: (index) {
                    setState(() {
                      // controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('0');
                      // controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('1');
                      // controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('2');
                      // controller.GET_BIL_MOV_M_GET_BIF_MOV_M_STATE_P('4');
                      controller.currentIndex = index;
                    });
                  },
                  items: [
                    /// Home
                    SalomonBottomBarItem(
                      icon: Icon(Icons.home_filled),
                      title: Text('StringHome'.tr),
                      selectedColor: Colors.redAccent,
                    ),
                    ///Operation
                    SalomonBottomBarItem(
                      icon: Icon(Icons.assignment_rounded),
                      title: Text('StringOperation'.tr),
                      selectedColor: Colors.redAccent,
                    ),
                    /// Reports
                    SalomonBottomBarItem(
                      icon: Icon(Icons.receipt_long),
                      title: Text('StringReports'.tr),
                      selectedColor: Colors.redAccent,
                    ),
                    /// settings
                    SalomonBottomBarItem(
                      icon: Icon(Icons.settings),
                      title: Text('Stringsetting'.tr),
                      selectedColor: Colors.redAccent,
                    ),
                  ],
                )
            ):
            Scaffold(
                appBar: buildAppBar(context),
                drawer: ThemeHelper().buildDrawer(context),
                body:  UpgradeAlert(
                  child: SingleChildScrollView(
                    child: controller.currentIndex == 0
                          ? SizedBox(
                      height: displayHeight(context) * 0.85,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           controller.FAS_ACC_USR2.isEmpty ?
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  InkWell(
                                    child: buildStack( context,'Sale_Invoices.png','StringSalesInvoice'.tr),
                                    onTap: () async {
                                      controller.GoToInvoiceSales(3);
                                    },
                                  ),
                                  InkWell(
                                    child: buildStack( context,'Purchases Invoices.png','StringPurchases'.tr),
                                    onTap: (){
                                      controller.GoToInvoiceSales(1);
                                    },
                                  ),
                                ],),
                              Column(children: [
                                InkWell(
                                  onTap: (){
                                    controller.GoToPay_Out(1);
                                  },
                                  child: buildStack( context,'Receipt Vouchers.png','StringReceipt'.tr),
                                ),
                                InkWell(
                                  onTap: (){
                                    controller.GoToPay_Out(2);
                                  },
                                  child: buildStack( context,'Payment Vouchers.png','StringPayment'.tr),
                                ),
                              ],),
                            ],
                          )
                              : GridView.builder(
                                shrinkWrap: true,
                                itemCount: controller.FAS_ACC_USR2.length,
                                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 280,
                                  childAspectRatio: 2,
                                ),
                                itemBuilder: (BuildContext context, int index) {
                                  return InkWell(
                                    child: Stack(
                                        alignment: Alignment.topCenter,
                                        children: [
                                          Image.asset(controller.FAS_ACC_USR2[index].SSID==601?"${ImagePath}Sale_Invoices.png":
                                          controller.FAS_ACC_USR2[index].SSID==901?"${ImagePath}Purchases Invoices.png":
                                          controller.FAS_ACC_USR2[index].SSID==102?"${ImagePath}Receipt Vouchers.png":
                                          controller.FAS_ACC_USR2[index].SSID==103?"${ImagePath}Payment Vouchers.png":
                                          controller.FAS_ACC_USR2[index].SSID==742?"${ImagePath}Sale_Invoices.png":
                                          controller.FAS_ACC_USR2[index].SSID==621?"${ImagePath}Sale_Invoices.png":
                                          controller.FAS_ACC_USR2[index].SSID==611?"${ImagePath}Return_Sale.png":
                                          controller.FAS_ACC_USR2[index].SSID==743?"${ImagePath}Return_Sale.png":
                                          controller.FAS_ACC_USR2[index].SSID==111?"${ImagePath}JournalVouchers.png":
                                          controller.FAS_ACC_USR2[index].SSID==91?"${ImagePath}Customer.png":
                                          controller.FAS_ACC_USR2[index].SSID==202?"${ImagePath}Account_Statement.png":
                                          "${ImagePath}Sale_Invoices.png",),
                                          Positioned(
                                            bottom:width >900 ? MediaQuery.of(context).size.height / 100:
                                            MediaQuery.of(context).size.height / 77,
                                            right: width >900 ? MediaQuery.of(context).size.height /  16.5:
                                            MediaQuery.of(context).size.height / 12.3,
                                            child: ThemeHelper().buildText(context,
                                                controller.FAS_ACC_USR2[index].SSID==601?'StringSalesInvoice':
                                                controller.FAS_ACC_USR2[index].SSID==901?'StringPurchases':
                                                controller.FAS_ACC_USR2[index].SSID==102? 'StringReceipt':
                                                controller.FAS_ACC_USR2[index].SSID==103? 'StringPayment':
                                                controller.FAS_ACC_USR2[index].SSID==742? 'StringSalesInvoice':
                                                controller.FAS_ACC_USR2[index].SSID==621? 'StringSalesInvoice':
                                                controller.FAS_ACC_USR2[index].SSID==611? 'StringReturn_Sale_Inv':
                                                controller.FAS_ACC_USR2[index].SSID==743? 'StringReturn_Sale_Inv':
                                                controller.FAS_ACC_USR2[index].SSID==111? 'StringJournalVouchers_Home':
                                                controller.FAS_ACC_USR2[index].SSID==91? 'StringCustomer_Home':
                                                controller.FAS_ACC_USR2[index].SSID==202? 'StringAccount_Statement':
                                                'StringSalesInvoice', Colors.white,'L'),
                                          ) ]),
                                    onTap: () async {
                                      if(controller.FAS_ACC_USR2[index].SSID==601){
                                        controller.GoToInvoiceSales(3);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==901){
                                        controller.GoToInvoiceSales(1);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==102){
                                        controller.GoToPay_Out(1);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==103){
                                        controller.GoToPay_Out(2);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==742){
                                        controller.GoToInvoiceSales(11);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==621){
                                        controller.GoToInvoiceSales(5);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==611){
                                        controller.GoToInvoiceSales(4);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==743){
                                        controller.GoToInvoiceSales(12);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==111){
                                        controller.GoToPay_Out(15);
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==91){
                                        if(controller.UPIN_CUS!=1 ){
                                          controller.buildShowDialogPRIV();
                                        }else{
                                          Get.toNamed('/View_Customers');
                                        }
                                      }else  if(controller.FAS_ACC_USR2[index].SSID==202){
                                        if(controller.UPIN_ACS!=1  ){
                                          controller.buildShowDialogPRIV();
                                        }else{
                                          Get.toNamed('/Account_Statement',arguments: 1);
                                        }
                                      }
                                    },
                                  );
                                },
                              ),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    color: AppColors.MainColor,
                                    child: ExpansionTile(
                                      collapsedIconColor: Colors.white,
                                      iconColor: Colors.white,
                                      leading: const Icon(Icons.assignment_rounded,
                                          color: Colors.white),
                                      title: ThemeHelper().buildText(context,'StringOperation', Colors.white,'L'),
                                      children: <Widget>[
                                        buildContainer('StringSale_Invoices'.tr,3,'Invoice'),
                                        buildContainer('StringReturn_Sale_Invoices'.tr,4,'Invoice'),
                                        buildContainer('StringPOS'.tr,11,'Invoice'),
                                        buildContainer('StringReturn_Sale_Invoices_POS'.tr,12,'Invoice'),
                                        buildContainer('StringService_Bills'.tr,5,'Invoice'),
                                        buildContainer('StringPurchases_Invoices'.tr,1,'Invoice'),
                                        buildContainer('StringReturn_Purchase'.tr,2,'Invoice'),
                                        buildContainer('StringQuotations'.tr,7,'Invoice'),
                                        buildContainer('StringCustomer_Requests'.tr,10,'Invoice'),
                                        buildContainer('StringJournalVouchers'.tr,15,'Vouchers'),
                                        buildContainer('StringReceipt_Vouchers'.tr,1,'Vouchers'),
                                        buildContainer('StringPayment_Vouchers'.tr,2,'Vouchers'),
                                        buildContainer('StringCollection_Vouchers'.tr,3,'Vouchers'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Container(
                                    color: AppColors.MainColor,
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      leading: const Icon(Icons.receipt_long,
                                          color: Colors.white),
                                      title: ThemeHelper().buildText(context,'StringReports', Colors.white,'L'),
                                      children: <Widget>[
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                //leading: Icon(Icons.add),
                                                title: ThemeHelper().buildText(context,'StringAccount_Statement', Colors.black,'M'),
                                                //subtitle: Text("Where You Can Register An Account"),
                                                onTap: () {
                                                  // if(controller.UPIN_ACS!=1  ){
                                                  //   controller.buildShowDialogPRIV();
                                                  // }else{
                                                  Get.toNamed('/Account_Statement',arguments: 1);
                                                  // }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                //leading: Icon(Icons.add),
                                                title: ThemeHelper().buildText(context,'StringAccount_Statement_Online', Colors.black,'M'),
                                                onTap: () {
                                                  if(controller.UPIN_ACS!=1  ){
                                                    controller.buildShowDialogPRIV();
                                                  }else{
                                                    Get.toNamed('/Account_Statement',arguments: 2);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                //leading: Icon(Icons.add),
                                                title: ThemeHelper().buildText(context,'StringACC_STA_H', Colors.black,'M'),
                                                onTap: () {
                                                  if(controller.UPIN_COS!=1  ){
                                                    controller.buildShowDialogPRIV();
                                                  }else{
                                                    Get.toNamed('/Account_Statement',arguments: 4);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                //leading: Icon(Icons.add),
                                                title: ThemeHelper().buildText(context,'StringACC_COS_STA', Colors.black,'M'),
                                                onTap: () {
                                                  if(controller.UPIN_MAIN!=1  ){
                                                    controller.buildShowDialogPRIV();
                                                  }else{
                                                    Get.toNamed('/Account_Statement',arguments: 3);
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        buildContainer('StrinSto_Num'.tr,0,'/Sto_NUM'),
                                        buildContainer('StrinInvoices_Archive'.tr,0,'/Invoices_Archive'),
                                        buildContainer('StringAccountsArchive'.tr,0,'/Accounts_Archive'),
                                        buildContainer('StringSalesReports'.tr,0,'/InvRep'),
                                        buildContainer('StringAccounts_Report'.tr,0,'/Bal_Rep'),
                                      ],
                                    ),
                                  ),
                                  SizedBox(height: 1.h,),
                                  Container(
                                    color: AppColors.MainColor,
                                    child: ExpansionTile(
                                      iconColor: Colors.white,
                                      collapsedIconColor: Colors.white,
                                      leading: const Icon(Icons.settings, color: Colors.white),
                                      title: ThemeHelper().buildText(context,'Stringsetting', Colors.white,'L'),
                                      children: <Widget>[
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                //leading: Icon(Icons.add),
                                                title: ThemeHelper().buildText(context,'StringCustomer', Colors.black,'M'),
                                                //subtitle: Text("Where You Can Register An Account"),
                                                onTap: () {
                                                  if(controller.UPIN_CUS!=1 ){
                                                    controller.buildShowDialogPRIV();
                                                  }else{
                                                    Get.toNamed('/View_Customers');
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ),
                                        buildContainer('StringInquiry_Quotation'.tr,0,'/Inquiry_Quotation'),
                                        (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                //leading: Icon(Icons.add),
                                                title:  ThemeHelper().buildText(context,'StringSync', Colors.black,'M'),
                                                //subtitle: Text("Where You Can Register An Account"),
                                                onTap: () {
                                                  if (LoginController().experimentalcopy == 1) {
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText: 'Stringexperimentalcopy'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor: Colors.blueAccent,
                                                    );
                                                  } else {
                                                    Get.toNamed('/Sync');
                                                  }
                                                  // Get.toNamed(Routes.Changepassword);
                                                },
                                              ),
                                            ),
                                          ),
                                        ):Container(),
                                        (TYPEPHONE=="IOS" && LoginController().experimentalcopy != 1) || TYPEPHONE=="ANDROID"?
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                title:  ThemeHelper().buildText(context,'StrinSyncArchive', Colors.black,'M'),
                                                onTap: () {
                                                  if (LoginController().experimentalcopy == 1) {
                                                    Get.defaultDialog(
                                                      title: 'StringMestitle'.tr,
                                                      middleText: 'Stringexperimentalcopy'.tr,
                                                      backgroundColor: Colors.white,
                                                      radius: 40,
                                                      textCancel: 'StringOK'.tr,
                                                      cancelTextColor: Colors.blueAccent,
                                                    );
                                                  } else {
                                                    Get.to(() => Show_Syn_Log());
                                                  }
                                                },
                                              ),
                                            ),
                                          ),
                                        ) : Container(),
                                        STMID=='MOB'?  buildContainer('StringUploaddata'.tr,0,'/SyncToServer')
                                            :Container(),
                                        buildContainer('StringSettings_APP'.tr,0,'/Setting'),
                                        Container(
                                          color: Colors.white,
                                          child: Card(
                                            child: Container(
                                              color: Colors.white,
                                              child: ListTile(
                                                title:  ThemeHelper().buildText(context,'StringBk_Br', Colors.black,'M'),
                                                onTap: () {
                                                  Get.to(() => BackupScreen());
                                                },
                                              ),
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
                        ],
                      ),
                    ) :Indicators_View(),
                  ),
                ),
                bottomNavigationBar: SalomonBottomBar(
                  currentIndex: controller.currentIndex,
                  selectedItemColor: Colors.pink,
                  onTap: (index) {
                    setState(() {
                      controller.currentIndex = index;
                      controller.update();
                    });
                  },
                  items: [
                    /// Home
                    SalomonBottomBarItem(
                      icon: Icon(Icons.home_filled),
                      title: Text('StringHome'.tr),
                      selectedColor: Colors.redAccent,
                    ),
                    ///Operation
                    SalomonBottomBarItem(
                      icon: Icon(Icons.bar_chart),
                      title: Text('StringIndicators'.tr),
                      selectedColor: Colors.redAccent,
                    ),
                  ],
                )
            );
          }));
  }

  Card buildCard(TextName,ImgName,int Num,TypeGo) {
    return Card(
      child: Container(
        color: Colors.white,
        child: ListTile(
          leading:  Image.asset("${ImagePath}${ImgName}",width: 50.h),
          title: ThemeHelper().buildText(context,TextName, Colors.black,'M'),
          //subtitle: Text("Where You Can Register An Account"),
          onTap: () {
            TypeGo=='Invoice'?
            controller.GoToInvoiceSales(Num):
            TypeGo=='Vouchers'?
            controller.GoToPay_Out(Num):
            Get.toNamed(TypeGo);
          },
        ),
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return AppBar(
      backgroundColor: AppColors.MainColor,
      title: GetBuilder<HomeController>(
          init: HomeController(),
          builder: ((controller) =>
              Stack(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('${'Stringhello'.tr} ${controller.SUNAController.text}',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 0.015 * height),
                      ),
                      Text(
                        "${controller.JTNAController.text}-${controller.BINAController.text} ",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 0.015 * height),
                      ),
                    ],),
                ],
              ))),
      elevation: 0.5,
      iconTheme: const IconThemeData(color: Colors.white),
      actions: [
        IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              ThemeHelper().buildShowDialog(context);
            }),
        if(STMID=='MOB' && ((controller.currentIndex==1
            && StteingController().Standard_Form==1) ||
    (controller.currentIndex==0 && StteingController().Standard_Form==2)) )
          GetBuilder<HomeController>(
            builder: ((controller) =>
                IconButton(
                    icon: Icon(controller.Type_chart==0?Icons.bar_chart:Icons.area_chart),
                    onPressed: () async {
                      if(controller.Type_chart==0){
                        controller.Type_chart=1;
                      }else{
                        controller.Type_chart=0;
                      }
                      controller.update();
                    }))),
        if(STMID=='MOB' && ((controller.currentIndex==1
            && StteingController().Standard_Form==1) ||
            (controller.currentIndex==0 && StteingController().Standard_Form==2)) )
          GetBuilder<HomeController>(
            builder: ((controller) =>
                IconButton(
                    icon: const Icon(Icons.filter_list),
                    onPressed: () async {
                      showFilterSheet(context);
                    }))),
      ],
    );
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

  Widget _buildFilterContent(BuildContext context) {
    return GetBuilder<HomeController>(
        init: HomeController(),
        builder: ((controller) =>
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListView(
                shrinkWrap: true,
                children: [
                  Column(children: [
                    Center(child: ThemeHelper().buildText(context,'StrinCustominquiriesby_period'.tr, Colors.black,'M')),
                    SizedBox(height: 2.h,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ThemeHelper().buildText(context,'StringFROM'.tr, Colors.black,'M'),
                        SizedBox(width: 10.h,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  controller.selectDateFromDays_F(context);
                                });
                              },
                              child: Text(
                                (controller.SelectDays_F ??
                                    (controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0])),
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 40.h,),
                        ThemeHelper().buildText(context,'StringBPID_TlableText'.tr, Colors.black,'M'),
                        SizedBox(width: 10.h,),
                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 1,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                setState(() {
                                  controller.selectDateFromDays_T(context);
                                });
                              },
                              child: Text(
                                (controller.SelectDays_T ??
                                    (controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0])),
                                style:  TextStyle(
                                    fontWeight: FontWeight.bold,fontSize: 13),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CheckboxListTile(
                            title: ThemeHelper().buildText(context,'StringDaily'.tr, Colors.black,'S'),
                            value:controller.isChecked,
                            onChanged: (newValue) {
                              setState(() {
                                controller.isChecked = newValue!;
                                controller.isChecked2 = false;
                                controller.isChecked3 = false;
                                controller.SelectDays_F = controller.selectedDatesercher.toString().split(" ")[0];
                                controller.SelectDays_T = controller.selectedDatesercher.toString().split(" ")[0];
                                controller.update();
                                // controller.GET_SUM_PAY_BIL_MOV_P();
                              });
                            },
                            activeColor: AppColors.MainColor,
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: ThemeHelper().buildText(context,'StringMonthly'.tr, Colors.black,'S'),
                            value:controller.isChecked2,
                            onChanged: (newValue) {
                              setState(() {
                                controller.isChecked2 = newValue!;
                                controller.isChecked = false;
                                controller.isChecked3 = false;
                                final startOfMonth = DateTime(controller.now.year, controller.now.month, 1);
                                final endOfMonth = DateTime(controller.now.year, controller.now.month + 1, 0);
                                controller.SelectDays_F = controller.formatter2.format(startOfMonth).toString().split(" ")[0];
                                controller.SelectDays_T = controller.formatter2.format(endOfMonth).toString().split(" ")[0];
                                controller.update();
                                // controller.GET_SUM_PAY_BIL_MOV_P();
                              });
                            },
                            activeColor: AppColors.MainColor,
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                        Expanded(
                          child: CheckboxListTile(
                            title: ThemeHelper().buildText(context,'StringYearly'.tr, Colors.black,'S'),
                            value:controller.isChecked3,
                            onChanged: (newValue) {
                              setState(() {
                                controller.isChecked3 = newValue!;
                                controller.isChecked = false;
                                controller.isChecked2 = false;
                                final startOfYear = DateTime(controller.now.year, 1, 1);
                                final endOfYear = DateTime(controller.now.year + 1, 1, 0);
                                controller.SelectDays_F = controller.formatter2.format(startOfYear).toString().split(" ")[0];
                                controller.SelectDays_T = controller.formatter2.format(endOfYear).toString().split(" ")[0];
                                controller.update();
                                // controller.GET_SUM_PAY_BIL_MOV_P();
                              });
                            },
                            activeColor: AppColors.MainColor,
                            controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: DropdownSYS_CURBuilder()
                        ),
                      ],
                    ),
                  ])
                ],
              ),
            ))
    );
  }

  FutureBuilder<List<Sys_Cur_Local>> DropdownSYS_CURBuilder() {
    return FutureBuilder<List<Sys_Cur_Local>>(
        future: GET_SYS_CUR(),
        builder: (BuildContext context,
            AsyncSnapshot<List<Sys_Cur_Local>> snapshot) {
          if (!snapshot.hasData) {
            return Dropdown(josnStatus: josnStatus, GETSTRING: '',);
          }
          return DropdownButtonFormField2(
            decoration: ThemeHelper().InputDecorationDropDown(" ${'StringSCIDlableText'.tr}"),
            isExpanded: true,
            hint: ThemeHelper().buildText(context,'StringChi_currency', Colors.grey,'S'),
            value: controller.SelectDataSCID,
            style: const TextStyle(
                fontFamily: 'Hacen',
                color: Colors.black),
            items: snapshot.data!
                .map((item) => DropdownMenuItem<String>(
              value: item.SCID.toString(),
              child: Text(
                "${item.SCNA_D.toString()}",
                style:  ThemeHelper().buildTextStyle(context, Colors.black,'M'),
              ),
            )).toList().obs,
            onChanged: (value) {
              controller.SelectDataSCID = value.toString();
              controller.update();
            },
          );
        });
  }

  Container buildContainer(TextName,int Num,TypeGo) {
    return Container(
      color: Colors.white,
      child: Card(
        child: Container(
          color: Colors.white,
          child: ListTile(
            //leading: const Icon(Icons.add),
            title: ThemeHelper().buildText(context,TextName, Colors.black,'M'),
            //subtitle: Text("Where You Can Register An Account"),
            onTap: () {
              TypeGo=='Invoice'?
              controller.GoToInvoiceSales(Num):
              TypeGo=='Vouchers'?
              controller.GoToPay_Out(Num):
              TypeGo== 'Rep'?
              controller.GoToRopert(Num) :
              TypeGo== 'INVC'?
              controller.GoToInventory(Num):
              TypeGo== 'COU'?
              controller.GoToCounterSalesInvoice(Num):
              Get.toNamed(TypeGo);
            },
          ),
        ),
      ),
    );

  }

  Stack buildStack(BuildContext context,Img,TextName) {
    return Stack(children: [
      SizedBox(
        height: STMID=='COU' ? MediaQuery.of(context).size.height / 5 : MediaQuery.of(context).size.height / 8,
        child: Image.asset(
          "${ImagePath}${Img}",
        ),
      ),
      Positioned(
        bottom:STMID=='COU' ? MediaQuery.of(context).size.height / 45 :MediaQuery.of(context).size.height / 76,
        right: STMID=='INVC' ? MediaQuery.of(context).size.height / 19 :
        STMID=='COU' ?MediaQuery.of(context).size.height / 38 : MediaQuery.of(context).size.height / 30,
        child: ThemeHelper().buildText(context,TextName, Colors.white,'M')
        ,
      ),
    ]);
  }

}
