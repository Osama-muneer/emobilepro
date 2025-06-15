import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_pos_printer_platform_image_3/flutter_pos_printer_platform_image_3.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/theme_helper.dart';
import '../../../database/setting_db.dart';
import '../../controllers/login_controller.dart';
import '../../controllers/setting_controller.dart';
import '../../models/AppPrinterDevice.dart';// Ensure your Isar model supports CRUD

class PrintersSettingsPage extends StatefulWidget {
  const PrintersSettingsPage({Key? key}) : super(key: key);
  @override
  State<PrintersSettingsPage> createState() => _PrintersSettingsPageState();
}

class _PrintersSettingsPageState extends State<PrintersSettingsPage> {
  final StteingController controller = Get.find();

  void initState() {
    controller.initPrinter();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("StrinSelect_Printer".tr,style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.redAccent,
        iconTheme: IconThemeData(color: Colors.white),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () => _showPrinterForm(),
        //   ),
        // ],
      ),
      body: GetBuilder<StteingController>(
          builder: (controller) {
        if (controller.printers.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.print, size: 100, color: Colors.grey),
                SizedBox(height: 20),
                Text('StringThere_printers_yet'.tr),
                SizedBox(height: 10),
                // Text('StringHere_printers'.tr),
              ],
            ),
          );
        }
        return ListView.builder(
          itemCount: controller.printers.length,
          itemBuilder: (context, index) {
            final printer = controller.printers[index];
            print('controller.printers[index].address');
            print(controller.printers[index].address);
            return ListTile(
              title: Text(printer.deviceName),
              // subtitle: Text(printer.typePrinter ?? '' +' - ' + (printer.address ??'')),
              subtitle: Text(printer.typePrinter ?? ''),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit,color:  Colors.cyan,),
                    onPressed: () {
                       _showPrinterForm(printer: printer);
                       controller.Get_Printers();
                       }
                  ),
                  IconButton(
                    icon: Icon(Icons.delete,color:  Colors.red,),
                    onPressed: () {
                      deletePrinter(printer.id!);
                      controller.Get_Printers();
                    },
                  ),
                ],
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.MainColor,
        onPressed: () {
          _showPrinterForm();
        },
        label: Text(
          'StringAdd'.tr,
          style: ThemeHelper().buildTextStyle(context, Colors.white,'M'),
        ),
        icon: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  void _showPrinterForm({AppPrinterDevice? printer}) {
    final isEditing = printer != null ;
    final nameController = TextEditingController(text: printer?.deviceName);
    final modelController = TextEditingController(text: printer?.vendorId);
    final macController = TextEditingController(text: printer?.productId);
    final addressController = TextEditingController(text: printer?.address);
    final portController = TextEditingController(text: printer?.port);
    final interfaceController = TextEditingController(text: printer?.typePrinter);
    // final paperSizeController = TextEditingController(text: printer?.paperSize);
  if(printer != null){
     StteingController.to.defaultPrinterType = StteingController.to.getTypePrinter(printer.typePrinter);
                      StteingController.to.selectedPrinter = printer;
  }
   
    Get.dialog(

      // context: Get.context!,
      // // builder: (context) {
      //   return 
        GetBuilder<StteingController>(
        builder: (controller) =>  AlertDialog(
          title:
          Text(isEditing ? 'StringEdit'.tr : 'StringAdd'.tr,textAlign: TextAlign.center),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(labelText: 'StringPrinter_Name'.tr),
                ),
                // DropdownButtonFormField<String>(
                //   value: printer?.vendorId,
                //   decoration: InputDecoration(labelText: 'طراز الطابعة'),
                //   items: <String>['طراز اخر'].map((String value) {
                //     return DropdownMenuItem<String>(
                //       value: value,
                //       child: Text(value),
                //     );
                //   }).toList(),
                //   onChanged: (newValue) {
                //     if (newValue != null) {
                //     macController.text = newValue;
                //     }
                //   },
                // ),
                SizedBox(height: 10),
                 DropdownButtonFormField<PrinterType>(
                    value: controller.getTypePrinter( printer?.typePrinter),
                    decoration: const InputDecoration(
                      prefixIcon: Icon(
                        Icons.print,
                        size: 20,
                      ),
                      // labelText: "Type Printer Device",
                      // labelStyle: TextStyle(fontSize: 18.0),
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                     items: <DropdownMenuItem<PrinterType>>[
                      if (Platform.isAndroid || Platform.isIOS)
                        const DropdownMenuItem(
                          value: PrinterType.bluetooth,
                          child: Text("Bluetooth"),
                        ),
                      if (Platform.isAndroid || Platform.isWindows)
                        const DropdownMenuItem(
                          value: PrinterType.usb,
                          child: Text("Usb"),
                        ),
                      const DropdownMenuItem(
                        value: PrinterType.network,
                        child: Text("WiFi"),
                      ),
                    ],
                    onChanged: ( newValue) {
                      if (newValue != null) {
   
                       interfaceController.text = controller.getTypePrinterString(newValue);
                      
                            controller.defaultPrinterType = newValue;
                            controller.selectedPrinter = null;
                            // controller.isBle = false;
                            // controller.isConnected = false;
                            controller.scan();
  }
                    },
                  ),
                SizedBox(height: 10),
                 Divider(height: 1, thickness: 1, color: Colors.grey),
                SizedBox(height: 10),// Separator
                            Text('طابعة : ${controller.selectedPrinter?.deviceName ?? "غير محدد"}'),
                SizedBox(height: 10),
                Divider(height: 1, thickness: 1, color: Colors.grey),
                Row(
                  children: [
                    OutlinedButton(
                                    onPressed: controller.selectedPrinter == null
                                        ? null
                                        : () async {

                                           // _printReceiveTest();
                                            try {
                                             controller.printTestTicket();
                                            } catch (e) {
                                              print(e);
                                            }
                                          },
                                    child:  Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                                      child: Text("StringTest".tr, textAlign: TextAlign.center,style:TextStyle(color: Colors.black)),
                                    ),
                                  ),
                    SizedBox(width: 10),
                    OutlinedButton(
                      onPressed: controller.defaultPrinterType == 'null'
                          ? null
                          : () {
                        controller.scan();
                        _showDeviceDialog();
                      } ,
                                    child:  Padding(
                                      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 18),
                                      child: Text("StringSEARCH".tr, textAlign: TextAlign.center,style:TextStyle(color: Colors.black)),
                                    ),
                                  ),
                  ],
                )
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                // 1) تأكد أولاً من تحديث القائمة
                await controller.Get_Printers();
                controller.update();
                // 2) خذ القائمة من Reactive variable وليس من الدالة
                final existing = controller.printers;
                // الآن existing من نوع List<AppPrinterDevice>

                // 2) بيانات الطابعة الجديدة أو المحدثة
                final candidate = AppPrinterDevice(
                  deviceName: nameController.text,
                  vendorId: modelController.text,
                  typePrinter: isEditing
                      ? controller.selectedPrinter!.typePrinter
                      : controller.getTypePrinterString(controller.defaultPrinterType),
                  productId: controller.selectedPrinter?.productId,
                  port: controller.selectedPrinter?.port,
                  address: controller.selectedPrinter?.address,
                    ciidL: LoginController().CIID,
                    biidL: LoginController().BIID,
                    jtidL: LoginController().JTID,
                    syidL: LoginController().SYID
                  // حقول إضافية...
                );


                // 4) فحص التكرار
                final isDuplicate = existing.any((p) {
                  if (isEditing && p.id == printer.id) return false;  // تجاهل السجل نفسه عند التعديل
                  return p.address == candidate.address;
                });
                if (isDuplicate) {
                  Fluttertoast.showToast(
                    msg: "StringThis_printer_already".tr,
                    backgroundColor: Colors.redAccent,
                  );
                  return;
                }

                // 5) الحفظ أو التعديل مرة واحدة فقط
                if (isEditing) {
                  candidate.id = printer.id;
                  await updatePrinter(candidate);
                } else {
                  await addPrinter(candidate);
                }

                // 6) إعادة تحميل القائمة وإغلاق النموذج
                await controller.Get_Printers();
                Get.back();
              },
              child: Text('StringSave'.tr, style: TextStyle(color: Colors.black)),
            ),
            // TextButton(
            //   onPressed: () async {
            //     if (isEditing && printer != 'null') {
            //       // Update existing printer
            //       final updatedPrinter = AppPrinterDevice(
            //         deviceName: nameController.text,
            //         vendorId: modelController.text,
            //          typePrinter: controller.selectedPrinter?.typePrinter ?? 'bluetooth',
            //           productId: controller.selectedPrinter?.productId,
            //         port: controller.selectedPrinter?.port,
            //         address: controller.selectedPrinter?.address,
            //         // isBle: true,
            //         // paperSize: paperSizeController.text,
            //       );
            //       updatedPrinter.id = printer.id;
            //       await updatePrinter(updatedPrinter);
            //      await controller.Get_Printers();
            //       Get.back();
            //     } else {
            //       // Create new printer
            //       final newPrinter = AppPrinterDevice(
            //         deviceName: nameController.text,
            //         vendorId: modelController.text,
            //          typePrinter:  controller.getTypePrinterString(controller.defaultPrinterType),
            //         productId: controller.selectedPrinter?.productId,
            //         port: controller.selectedPrinter?.port,
            //         address: controller.selectedPrinter?.address,
            //         ciidL: LoginController().CIID,
            //         biidL: LoginController().BIID,
            //         jtidL: LoginController().JTID,
            //         syidL: LoginController().SYID
            //         // isBle: true,
            //         // paperSize: paperSizeController.text,
            //       );
            //       await addPrinter(newPrinter);
            //       await controller.Get_Printers();
            //       Get.back();
            //     }
            //   },
            //   child: Text('StringSave'.tr,style:TextStyle(color: Colors.black)),
            // ),
            TextButton(
              onPressed: () => Get.back(),
              child: Text('StringCancel'.tr,style:TextStyle(color: Colors.black) ,),
            ),
          ],
        )));
      
  
  }

  void _showDeviceDialog() {
    final context = Get.context;
  if (context == null) return;
    showDialog(
      context: Get.context!,
      builder: (context) {
        return  GetBuilder<StteingController>(
          //init: StteingController.to, // Initialize the controller
        builder: (controller) => AlertDialog(
          // title: Text('البحث عن أجهزة '),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                // Example list of Bluetooth devices
                ...controller.devices.map(
                            (device) => ListTile(
                              title: Text('${device.deviceName}'),
                              subtitle: Platform.isAndroid && controller.defaultPrinterType == PrinterType.usb
                                  ? null
                                  : Visibility(visible: !Platform.isWindows, child: Text("${device.address}")),
                              onTap: () {
                                // do something
                                controller.selectDevice(device);
                                 Get.back(); // Close the dialog
                              },
                             
                            ),
                          )
                          .toList()
               
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.back(),
              child: Text('StringCancel'.tr),
            ),
          ],
        ));
      },
    );
  }
}