import '../Operation/Views/SaleInvoices/sale_invoices_view.dart';
import '../PrintFile/exported_invoices_module/exported_invoices_view.dart';
import '../Reports/Views/Invoices_Archive/show_bif_mov.dart';
import '../Reports/Views/Invoices_Repert/inv_rep_view.dart';
import '../Reports/Views/Invoices_Repert/show_inv_view.dart';
import '../Reports/Views/Vouchers_Archive/show_acc_mov.dart';
import '../Setting/Views/Customers/view_customers.dart';
import '../Setting/Views/Home/aboutus_view.dart';
import '../Setting/Views/Home/home.dart';
import '../Setting/Views/Home/inguiry_quotation_view.dart';
import '../Setting/Views/Home/setting_view.dart';
import '../Setting/Views/Sync/sync_view.dart';
import '../Setting/Views/account/login_view.dart';
import '../Setting/Views/account/splash_screen.dart';
import '../routes/binding.dart';
import 'package:get/get.dart';
import '../Operation/Views/Approve/approve_view.dart';
import '../Operation/Views/Inventory/inventory_view.dart';
import '../Operation/Views/TreasuryVouchers/view_pay_out.dart';
import '../Reports/Views/Account_Statement/Account_Statement_View.dart';
import '../Reports/Views/Accounts_Reports/acc_rep_view.dart';
import '../Reports/Views/Accounts_Reports/show_acc_view.dart';
import '../Reports/Views/Balances_Repert/bal_rep_view.dart';
import '../Reports/Views/Balances_Repert/cust_bal_rep_view.dart';
import '../Reports/Views/Counter_Approving_Rep/counter_inv_archive_view.dart';
import '../Reports/Views/Counter_Approving_Rep/show_approv_view.dart';
import '../Reports/Views/Counter_Approving_Rep/show_counter_inv_rep.dart';
import '../Reports/Views/Inventory_Quantity/sto_num.dart';
import '../Reports/Views/Inventory_Reports/invc_mov_view.dart';
import '../Reports/Views/Inventory_Reports/invc_rep_view.dart';
import '../Reports/Views/Invoices_Archive/invoices_archive_view.dart';
import '../Reports/Views/Vouchers_Archive/accounts_archive_view.dart';
import '../Setting/Views/Home/Reports_View.dart';
import '../Setting/Views/Sync/sync_to_server.dart';
import '../Setting/controllers/setting_controller.dart';

class AppRoutes {

  static const SPLASH = Routes.SPLASH;
  static const LOGIN = Routes.LOGIN;
  static const Home = Routes.Home;
  static const AboutUs = Routes.AboutUs;
  static const AboutApp = Routes.AboutApp;
  static const Sync = Routes.Sync;
  static const Setting = Routes.Setting;
  static const View_Customers = Routes.View_Customers;
  static const View_Pay_Out = Routes.View_Pay_Out;
  static const Inv_Rep = Routes.Inv_Rep;
  static const Purchases_Invoices = Routes.Purchases_Invoices;
  static const Sale_Invoices = Routes.Sale_Invoices;
  static const Invoices_Archive = Routes.Invoices_Archive;
  static const Accounts_Archive = Routes.Accounts_Archive;
  static const Sto_NUM = Routes.Sto_NUM;
  static const Account_Statement = Routes.Account_Statement;
  static const Return_Sale_Invoices = Routes.Return_Sale_Invoices;
  static const Sale_Invoices_POS = Routes.Sale_Invoices_POS;
  static const Inv_Mov_Rep = Routes.Inv_Mov_Rep;
  static const Inquiry_Quotation = Routes.Inquiry_Quotation;
  static const Cus_Bal_Rep = Routes.Cus_Bal_Rep;
  static const Bal_Rep = Routes.Bal_Rep;
  static const SyncToServer = Routes.SyncToServer;
  static const Reports = Routes.Reports;
  static const Invc_Rep = Routes.Invc_Rep;
  static const Inventory = Routes.Inventory;
  static const Invc_Mov_Rep = Routes.Invc_Mov_Rep;
  static const Counter_Sales_Invoice = Routes.Counter_Sale_Invoice;
  static const Counter_Sale_Posting_Approving = Routes.Counter_Sale_Posting_Approving;
  static const show_approv_Rep = Routes.show_approv_Rep;
  static const show_counter_Rep = Routes.show_counter_Rep;
  static const Counter_Invoices_Archive = Routes.Counter_Invoices_Archive;

  static final routes = [
    GetPage(name: Routes.SPLASH , page: () =>  SplashScreen(),binding: BindingSplash()),
    GetPage(name: Routes.LOGIN , page: () =>  LoginView(),binding: BindingLogin()),

    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Home , page: () =>  HomeView(),binding: BindingHome()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.AboutUs ,  page: () =>  AboutUsView(),binding: BindingAboutUs()),
    GetPage(   transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Sync ,     page: () =>  SyncView(),binding: BindingSync()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Setting ,  page: () =>  SettingView(),binding: BindingSetting()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.View_Customers ,  page: () =>  ViewCustomers(),binding: BindingCustomers()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.View_Pay_Out ,  page: () =>  ViewPay_Out(),binding: BindingPay_Out()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Inv_Rep ,  page: () =>  Inv_Rep_View(),binding: BindingInv_Rep()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Acc_Rep ,  page: () =>  Acc_Rep_View(),binding: BindingAcc_Rep()),
    GetPage( transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Sale_Invoices ,  page: () =>  Sale_Invoices_view(),binding: BindingSale_Invoices()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Sale_Invoices_POS ,  page: () =>  Sale_Invoices_view(),binding: BindingSale_Invoices()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Sto_NUM ,  page: () =>  Sto_Num_View(),binding: BindingSto_Num()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Account_Statement ,  page: () =>  Account_Statement_View(),binding: BindingAccount_Statement()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name:  Routes.exportedInvoices,
        page: () => ExportedInvoicesView(),binding: ExportedInvoicesBinding()
    ),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Invoices_Archive ,  page: () =>  Show_Bif_Mov(),binding: BindingInvoices_Archive()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Accounts_Archive ,  page: () =>  Show_Acc_Mov(),binding: BindingAccounts_Archive()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Inv_Mov_Rep , page: () =>  Show_Inv_Rep(),binding: BindingInv_Mov_Rep()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Acc_Mov_Rep , page: () =>  Show_Acc_Rep(),binding: BindingAcc_Mov_Rep()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Inquiry_Quotation ,  page: () =>  Inquiry_Quotation_View(),binding: BindingAboutUs()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Cus_Bal_Rep ,  page: () =>  Cus_Bal_Rep_View(),binding: BindingCus_Bal_Rep()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(), name: Routes.Bal_Rep ,  page: () =>  Bal_Rep_View(),binding: BindingCus_Bal_Rep()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.SyncToServer ,  page: () =>  Sync_To_Server(),binding: BindingSync_To_Server()),
    GetPage(transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Reports ,  page: () =>  Reports_View(),binding: BindingReports()),
    GetPage(name: Routes.Inventory , page: () =>  InventoryView(),binding: BindingAddEditInventory()),
    GetPage(name: Routes.Invc_Rep , page: () =>  Invc_Rep_View(),binding: BindingInvcRep()),
    GetPage(name: Routes.Invc_Mov_Rep , page: () =>  Invc_Mov_View(),binding: BindingInvc_Mov_Rep()),

    // GetPage( transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
    //     name: Routes.Counter_Sale_Invoice ,  page: () =>  CounterSalesInvoiceView(),binding: BindingSale_Invoices()),

    GetPage( transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.show_approv_Rep ,  page: () =>  Show_Approv_View(),binding: BindingApprov_Rep()),

    GetPage( transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Counter_Sale_Posting_Approving ,  page: () =>  Approve_View(),binding: BindingCounter_Sale_Approving()),

    GetPage( transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.show_counter_Rep ,  page: () =>  Show_Counter_Inv_Rep(),binding: BindingCounter_Inv_Rep()),

    GetPage( transition: StteingController().isActivateInteractionScreens==true ? Transition.zoom: Transition.noTransition, transitionDuration: duration(),
        name: Routes.Counter_Invoices_Archive ,  page: () =>  Counter_Inv_Archive_View(),binding: BindingCounter_Inv_Archive_View()),


  ];

  static  duration() => Duration(milliseconds: 500);
}

class Routes {
  static const  exportedInvoices = "/exportedInvoices";
  static const View_Customers = '/View_Customers';
  static const View_Pay_Out = '/View_Pay_Out';
  static const SPLASH = '/splash';
  static const LOGIN = '/login';
  static const Home = '/Home';
  static const AboutUs = '/AboutUs';
  static const AboutApp = '/AboutApp';
  static const Sync = '/Sync';
  static const GET_MAT = '/GET_MAT';
  static const Setting = '/Setting';
  static const Inv_Rep = '/InvRep';
  static const Acc_Rep = '/AccRep';
  static const Purchases_Invoices = '/Purchases_Invoices';
  static const Sale_Invoices = '/Sale_Invoices';
  static const Sto_NUM = '/Sto_NUM';
  static const Account_Statement = '/Account_Statement';
  static const Return_Sale_Invoices = '/Return_Sale_Invoices';
  static const Invoices_Archive = '/Invoices_Archive';
  static const Accounts_Archive = '/Accounts_Archive';
  static const Sale_Invoices_POS = '/Sale Invoices(POS)';
  static const Inv_Mov_Rep = '/Inv_Mov_Rep';
  static const Acc_Mov_Rep = '/Acc_Mov_Rep';
  static const Inquiry_Quotation = '/Inquiry_Quotation';
  static const Cus_Bal_Rep = '/Cus_Bal_Rep';
  static const Bal_Rep = '/Bal_Rep';
  static const SyncToServer = '/SyncToServer';
  static const Reports = '/Reports';
  static const Invc_Rep = '/Invc_Rep';
  static const Invc_Mov_Rep = '/Invc_Mov_Rep';
  static const Inventory = '/Inventory';
  static const Counter_Sale_Invoice = '/Counter_Sale_Invoice';
  static const Counter_Sale_Posting_Approving = '/Counter_Sale_Posting_Approving';
  static const show_approv_Rep = '/show_approv_Rep';
  static const show_counter_Rep = '/show_counter_Rep';
  static const Counter_Invoices_Archive = '/Counter_Invoices_Archive';
}
