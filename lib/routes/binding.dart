import '../Operation/Controllers/sale_invoices_controller.dart';
import '../PrintFile/exported_invoices_module/exported_invoices_controller.dart';
import '../Reports/controllers/Inv_Rep_Controller.dart';
import '../Reports/controllers/invoices_archive_controller.dart';
import '../Setting/controllers/Customers_Controller.dart';
import '../Setting/controllers/abouatus_controller.dart';
import '../Setting/controllers/home_controller.dart';
import '../Setting/controllers/login_controller.dart';
import '../Setting/controllers/setting_controller.dart';
import '../Setting/controllers/sync_controller.dart';
import 'package:get/get.dart';
import '../Operation/Controllers/Pay_Out_Controller.dart';
import '../Operation/Controllers/counter_sale_approving_controller.dart';
import '../Operation/Controllers/inventory_controller.dart';
import '../Reports/controllers/Acc_Rep_Controller.dart';
import '../Reports/controllers/Account_Statement_Controller.dart';
import '../Reports/controllers/Counter_inv_archive_controller.dart';
import '../Reports/controllers/Cus_Bal_Rep_Controller.dart';
import '../Reports/controllers/accounts_archive_controller.dart';
import '../Reports/controllers/approving_rep_controller.dart';
import '../Reports/controllers/counter_inv_rep_controller.dart';
import '../Reports/controllers/invc_mov_rep_controller.dart';
import '../Reports/controllers/sto_num_controller.dart';
import '../Setting/controllers/Reports_Controller.dart';
import '../Setting/controllers/splash_controller.dart';
import '../Setting/controllers/sync_server_controller.dart';
class BindingSplash extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
  }
}
class BindingLogin extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(() => LoginController(),fenix: true);
  }
}
class BindingHome extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController(),fenix: true);
  }
}

class BindingAboutUs extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(() => AboutUsController(),fenix: true);
  }
}
class BindingSync extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SyncController>(() => SyncController(),fenix: true);
  }
}
class BindingSync_To_Server extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Sync_To_ServerController>(() => Sync_To_ServerController(),fenix: true);
  }
}
class BindingSetting extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StteingController>(() => StteingController(),fenix: true);
  }
}
class BindingCustomers extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CustomersController>(() => CustomersController(),fenix: true);
  }
}
class BindingPay_Out extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Pay_Out_Controller>(() => Pay_Out_Controller(),fenix: true);
  }
}

class BindingInv_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Inv_Rep_Controller>(() => Inv_Rep_Controller(),fenix: true);
  }
}
class BindingAcc_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Acc_Rep_Controller>(() => Acc_Rep_Controller(),fenix: true);
  }
}


class BindingSale_Invoices extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Sale_Invoices_Controller>(() => Sale_Invoices_Controller(),fenix: true);
  }
}


class BindingSto_Num extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Sto_NumController>(() => Sto_NumController(),fenix: true);
  }
}

class BindingAccount_Statement extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Account_Statement_Controller>(() => Account_Statement_Controller(),fenix: true);
  }
}


class ExportedInvoicesBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ExportedInvoicesController>(
          () => ExportedInvoicesController(),
    );
  }
}

class BindingInvoices_Archive extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Invoices_ArchiveController>(() => Invoices_ArchiveController(),fenix: true);
  }
}

class BindingAccounts_Archive extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Accounts_ArchiveController>(() => Accounts_ArchiveController(),fenix: true);
  }
}

class BindingInv_Mov_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Inv_Rep_Controller>(() => Inv_Rep_Controller(),fenix: true);
  }
}



class BindingAcc_Mov_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Acc_Rep_Controller>(() => Acc_Rep_Controller(),fenix: true);
  }
}
class BindingCus_Bal_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Cus_Bal_Rep_Controller>(() => Cus_Bal_Rep_Controller(),fenix: true);
  }
}
class BindingReports extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Reports_Controller>(() => Reports_Controller(),fenix: true);
  }
}

// class BindingIncoming_Store extends Bindings {
//   @override
//   void dependencies() {
//     Get.lazyPut<Incoming_StoreController>(() => Incoming_StoreController(),fenix: true);
//   }
// }

class BindingAddEditInventory extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InventoryController>(() => InventoryController(),fenix: true);
  }
}

class BindingInvcRep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Invc_Mov_RepController>(() => Invc_Mov_RepController(),fenix: true);
  }
}

class BindingInvc_Mov_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Invc_Mov_RepController>(() => Invc_Mov_RepController(),fenix: true);
  }
}

class BindingCounter_Sale_Approving extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Counter_Sales_Approving_Controller>(() => Counter_Sales_Approving_Controller(),fenix: true);
  }
}



class BindingApprov_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Approving_rep_controller>(() => Approving_rep_controller(),fenix: true);
  }
}

class BindingCounter_Inv_Rep extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Counter_Inv_Rep_Controller>(() => Counter_Inv_Rep_Controller(),fenix: true);
  }
}

class BindingCounter_Inv_Archive_View extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<Counter_Inv_Archive_controller>(() => Counter_Inv_Archive_controller(),fenix: true);
  }
}