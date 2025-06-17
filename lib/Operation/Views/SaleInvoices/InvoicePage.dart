import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../Controllers/InvoiceController.dart';
import 'package:getwidget/getwidget.dart';  // استيراد مكتبة GetWidget

class InvoicePage extends StatelessWidget {
  final InvoiceController invoiceController = Get.put(InvoiceController());

  // تحكم في الحقول عبر TextEditingController
  final List<TextEditingController> invoiceIdControllers = [];
  final List<TextEditingController> customerNameControllers = [];
  final List<TextEditingController> totalAmountControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة فواتير جديدة'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              // زر الإضافة
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // عند الضغط على الزر، يتم إضافة فاتورة جديدة
                  invoiceController.addInvoice();
                },
              ),
              // تبويبات
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: invoiceController.invoices.length,
                  separatorBuilder: (_, __) => SizedBox(width: 4),
                  itemBuilder: (context, index) {
                    final isSelected = invoiceController.selectedTabIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        // تحديد التبويب عند النقر عليه
                        invoiceController.selectTab(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.folder_open, size: 18),
                            SizedBox(width: 4),
                            Text(invoiceController.invoices[index].invoiceId),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                // عند الضغط على زر الإغلاق، سيتم حذف التبويب
                                invoiceController.closeTab(index);
                              },
                              child: Icon(Icons.close, size: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              // عرض تفاصيل الفاتورة في التبويب المحدد
              return ListView.builder(
                shrinkWrap: true,  // التأكد من أن ListView لا يتسع بشكل غير مناسب
                itemCount: invoiceController.invoices.length,
                itemBuilder: (context, index) {
                  // تحكم في الحقول
                  if (invoiceIdControllers.length <= index) {
                    invoiceIdControllers.add(TextEditingController());
                    customerNameControllers.add(TextEditingController());
                    totalAmountControllers.add(TextEditingController());
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GFAccordion(
                      title: invoiceController.invoices[index].invoiceId, // اسم الفاتورة
                      contentChild: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // حقل رقم الفاتورة
                            TextField(
                              controller: invoiceIdControllers[index],
                              decoration: InputDecoration(labelText: 'رقم الفاتورة'),
                              onChanged: (value) {
                                invoiceController.updateInvoice(index, value, customerNameControllers[index].text, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                              },
                            ),
                            // حقل اسم العميل
                            TextField(
                              controller: customerNameControllers[index],
                              decoration: InputDecoration(labelText: 'اسم العميل'),
                              onChanged: (value) {
                                invoiceController.updateInvoice(index, invoiceIdControllers[index].text, value, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                              },
                            ),
                            // حقل إجمالي الفاتورة
                            TextField(
                              controller: totalAmountControllers[index],
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(labelText: 'إجمالي الفاتورة'),
                              onChanged: (value) {
                                invoiceController.updateInvoice(index, invoiceIdControllers[index].text, customerNameControllers[index].text, double.tryParse(value) ?? 0.0);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}

class InvoicePage4 extends StatelessWidget {
  final InvoiceController invoiceController = Get.put(InvoiceController());

  // تحكم في الحقول عبر TextEditingController
  final List<TextEditingController> invoiceIdControllers = [];
  final List<TextEditingController> customerNameControllers = [];
  final List<TextEditingController> totalAmountControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة فواتير جديدة'),
      ),
      body: Column(
        children: [
          Row(
            children: [
              // زر الإضافة
              IconButton(
                icon: Icon(Icons.add),
                onPressed: () {
                  // عند الضغط على الزر، يتم إضافة فاتورة جديدة
                  invoiceController.addInvoice();
                },
              ),
              // تبويبات
              Expanded(
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: invoiceController.invoices.length,
                  separatorBuilder: (_, __) => SizedBox(width: 4),
                  itemBuilder: (context, index) {
                    final isSelected = invoiceController.selectedTabIndex.value == index;
                    return GestureDetector(
                      onTap: () {
                        // تحديد التبويب عند النقر عليه
                        invoiceController.selectTab(index);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected ? Colors.blue : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.folder_open, size: 18),
                            SizedBox(width: 4),
                            Text(invoiceController.invoices[index].invoiceId),
                            SizedBox(width: 4),
                            GestureDetector(
                              onTap: () {
                                // عند الضغط على زر الإغلاق، سيتم حذف التبويب
                                invoiceController.closeTab(index);
                              },
                              child: Icon(Icons.close, size: 16),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
          Expanded(
            child: Obx(() {
              // عرض تفاصيل الفاتورة في التبويب المحدد
              return Column(
                children: [
                  Text("فاتورة: ${invoiceController.invoices[invoiceController.selectedTabIndex.value].invoiceId}"),
                  ListView.builder(
                    shrinkWrap: true,  // التأكد من أن ListView لا يتسع بشكل غير مناسب
                    itemCount: invoiceController.invoices.length,
                    itemBuilder: (context, index) {
                      // تحكم في الحقول
                      if (invoiceIdControllers.length <= index) {
                        invoiceIdControllers.add(TextEditingController());
                        customerNameControllers.add(TextEditingController());
                        totalAmountControllers.add(TextEditingController());
                      }

                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // حقل رقم الفاتورة
                                TextField(
                                  controller: invoiceIdControllers[index],
                                  decoration: InputDecoration(labelText: 'رقم الفاتورة'),
                                  onChanged: (value) {
                                    invoiceController.updateInvoice(index, value, customerNameControllers[index].text, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                                  },
                                ),
                                // حقل اسم العميل
                                TextField(
                                  controller: customerNameControllers[index],
                                  decoration: InputDecoration(labelText: 'اسم العميل'),
                                  onChanged: (value) {
                                    invoiceController.updateInvoice(index, invoiceIdControllers[index].text, value, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                                  },
                                ),
                                // حقل إجمالي الفاتورة
                                TextField(
                                  controller: totalAmountControllers[index],
                                  keyboardType: TextInputType.number,
                                  decoration: InputDecoration(labelText: 'إجمالي الفاتورة'),
                                  onChanged: (value) {
                                    invoiceController.updateInvoice(index, invoiceIdControllers[index].text, customerNameControllers[index].text, double.tryParse(value) ?? 0.0);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              );
            }),
          ),
        ],
      ),
    );
  }
}

class InvoicePage3 extends StatelessWidget {
  final InvoiceController invoiceController = Get.put(InvoiceController());

  // تحكم في الحقول عبر TextEditingController
  final List<TextEditingController> invoiceIdControllers = [];
  final List<TextEditingController> customerNameControllers = [];
  final List<TextEditingController> totalAmountControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة فاتورة جديدة'),
      ),
      body: Obx(() {
        return SingleChildScrollView(
          child: Column(

            children: List.generate(invoiceController.invoices.length, (index) {
              // إذا كانت هذه فاتورة جديدة، يمكننا تخصيص controllers لها
              if (invoiceIdControllers.length <= index) {
                invoiceIdControllers.add(TextEditingController());
                customerNameControllers.add(TextEditingController());
                totalAmountControllers.add(TextEditingController());
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // حقل رقم الفاتورة
                        TextField(
                          controller: invoiceIdControllers[index],
                          decoration: InputDecoration(labelText: 'رقم الفاتورة'),
                          onChanged: (value) {
                            // تحديث الفاتورة
                            invoiceController.updateInvoice(index, value, customerNameControllers[index].text, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                          },
                        ),
                        // حقل اسم العميل
                        TextField(
                          controller: customerNameControllers[index],
                          decoration: InputDecoration(labelText: 'اسم العميل'),
                          onChanged: (value) {
                            // تحديث الفاتورة
                            invoiceController.updateInvoice(index, invoiceIdControllers[index].text, value, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                          },
                        ),
                        // حقل إجمالي الفاتورة
                        TextField(
                          controller: totalAmountControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'إجمالي الفاتورة'),
                          onChanged: (value) {
                            // تحديث الفاتورة
                            invoiceController.updateInvoice(index, invoiceIdControllers[index].text, customerNameControllers[index].text, double.tryParse(value) ?? 0.0);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}

class InvoicePage2 extends StatelessWidget {
  final InvoiceController invoiceController = Get.put(InvoiceController());

  // تحكم في الحقول عبر TextEditingController
  final List<TextEditingController> invoiceIdControllers = [];
  final List<TextEditingController> customerNameControllers = [];
  final List<TextEditingController> totalAmountControllers = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('إضافة فواتير جديدة'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              // عند الضغط على الزر، يتم إضافة فاتورة جديدة
              invoiceController.addInvoice();
            },
          ),
        ],
      ),
      body: Obx(() {
        // عرض الفواتير المفتوحة باستخدام Row أو Column
        return SingleChildScrollView(
          child: Column(
            children: List.generate(invoiceController.invoices.length, (index) {
              // إذا كانت هذه فاتورة جديدة، يمكننا تخصيص controllers لها
              if (invoiceIdControllers.length <= index) {
                invoiceIdControllers.add(TextEditingController());
                customerNameControllers.add(TextEditingController());
                totalAmountControllers.add(TextEditingController());
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // حقل رقم الفاتورة
                        TextField(
                          controller: invoiceIdControllers[index],
                          decoration: InputDecoration(labelText: 'رقم الفاتورة'),
                          onChanged: (value) {
                            // تحديث الفاتورة
                            invoiceController.updateInvoice(index, value, customerNameControllers[index].text, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                          },
                        ),
                        // حقل اسم العميل
                        TextField(
                          controller: customerNameControllers[index],
                          decoration: InputDecoration(labelText: 'اسم العميل'),
                          onChanged: (value) {
                            // تحديث الفاتورة
                            invoiceController.updateInvoice(index, invoiceIdControllers[index].text, value, double.tryParse(totalAmountControllers[index].text) ?? 0.0);
                          },
                        ),
                        // حقل إجمالي الفاتورة
                        TextField(
                          controller: totalAmountControllers[index],
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(labelText: 'إجمالي الفاتورة'),
                          onChanged: (value) {
                            // تحديث الفاتورة
                            invoiceController.updateInvoice(index, invoiceIdControllers[index].text, customerNameControllers[index].text, double.tryParse(value) ?? 0.0);
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      }),
    );
  }
}


