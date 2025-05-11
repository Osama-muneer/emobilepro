import '../Setting/controllers/home_controller.dart';
import 'package:get/get.dart';
import '../Operation/Controllers/Pay_Out_Controller.dart';
import '../Operation/Controllers/sale_invoices_controller.dart';
import '../Reports/controllers/Inv_Rep_Controller.dart';
import '../Setting/controllers/Customers_Controller.dart';
import '../Setting/controllers/setting_controller.dart';

Future<void> init()async{
  Get.lazyPut(()=>HomeController(),fenix: true);
  Get.lazyPut(()=>Sale_Invoices_Controller(),fenix: true);
  Get.lazyPut(()=>StteingController(),fenix: true);
  Get.lazyPut(()=>Inv_Rep_Controller(),fenix: true);
  Get.lazyPut(()=>CustomersController(),fenix: true);
  Get.lazyPut(()=>Pay_Out_Controller(),fenix: true);
}