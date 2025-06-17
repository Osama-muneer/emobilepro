import 'package:get/get.dart';

class InvoiceController extends GetxController {
  // قائمة لتخزين الفواتير (التبويبات)
  var invoices = <InvoiceDetails>[].obs;

  // المتغير الذي يخزن التبويب المحدد
  var selectedTabIndex = 0.obs;

  // دالة لإضافة فاتورة جديدة
  void addInvoice() {
    invoices.add(InvoiceDetails('فاتورة جديدة', '', 0.0));
    selectedTabIndex.value = invoices.length - 1; // تعيين التبويب المحدد على الفاتورة الجديدة
  }

  // دالة لتحديث تفاصيل فاتورة معينة
  void updateInvoice(int index, String invoiceId, String customerName, double totalAmount) {
    invoices[index] = InvoiceDetails(invoiceId, customerName, totalAmount);
  }

  // دالة لإغلاق فاتورة
  void closeTab(int index) {
    invoices.removeAt(index);
    if (selectedTabIndex.value >= invoices.length) {
      selectedTabIndex.value = invoices.length - 1; // تحديث التبويب المحدد إذا تم حذف التبويب المحدد
    }
  }

  // دالة لاختيار التبويب المحدد
  void selectTab(int index) {
    selectedTabIndex.value = index; // استخدم .value لتحديث القيمة
  }
}

class InvoiceDetails {
  String invoiceId;
  String customerName;
  double totalAmount;

  InvoiceDetails(this.invoiceId, this.customerName, this.totalAmount);
}
