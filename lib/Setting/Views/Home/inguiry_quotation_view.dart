import 'package:barcode_scan2/barcode_scan2.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/abouatus_controller.dart';

class Inquiry_Quotation_View extends StatefulWidget {
  const Inquiry_Quotation_View({Key? key}) : super(key: key);
  @override
  State<Inquiry_Quotation_View> createState() => _Inquiry_Quotation_ViewState();
}

class _Inquiry_Quotation_ViewState extends State<Inquiry_Quotation_View> {
  static const Color grey_5 = Color(0xFFf2f2f2);
  final AboutUsController controller = Get.find();
  String _scanBarcode = 'Unknown';

  scanBarcodeNormal() async {
    String barcodeScanRes;

    try {
      var result = await BarcodeScanner.scan();
      barcodeScanRes = result.rawContent;
    } catch (e) {
      barcodeScanRes = 'Failed to get barcode.';
    }

    _scanBarcode = barcodeScanRes;
    controller.TEXTController.text = barcodeScanRes;
    controller.GET_MAT_UNI_B_P(barcodeScanRes.toString());
  }

  // scanBarcodeNormal() async {
  //   String barcodeScanRes;
  //   // Platform messages may fail, so we use a try/catch PlatformException.
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode('#ff6666', 'Cancel', true, ScanMode.BARCODE);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //   _scanBarcode = barcodeScanRes;
  //   controller.TEXTController.text = barcodeScanRes;
  //   controller.GET_MAT_UNI_B_P(barcodeScanRes.toString());
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        backgroundColor: AppColors.MainColor,
        iconTheme: IconThemeData(color: Colors.white),
        actions: [
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.cleaning_services,color: Colors.white),
                onPressed: () {
                  controller.clear();
                  controller.update();
                },
              ),
            ],
          )
        ],
        title: Text('StringInquiry_Quotation'.tr,
            style: TextStyle(
                fontSize: Dimensions.fonAppBar,
                color: AppColors.textColor,
                fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body:GetBuilder<AboutUsController>(
        init: AboutUsController(),
        builder: (value) {
          return Padding(
            padding: EdgeInsets.only(top: 8, left: Dimensions.width10, right: Dimensions.width10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: controller.TEXTController,
                        style: TextStyle(fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                          labelText: 'اسم الصنف-الباركود-رقم الصنف',
                          labelStyle: TextStyle(color: Colors.black45),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(Dimensions.width15),
                            borderSide: BorderSide(color: Colors.grey.shade500),
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(Dimensions.height15)),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search_rounded, size: Dimensions.iconSize40),
                      onPressed: () async {
                        controller.GET_MAT_UNI_B_P(controller.TEXTController.text);
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.calendar_view_day, size: Dimensions.iconSize40),
                      onPressed: () async {
                        scanBarcodeNormal();
                      },
                    ),
                  ],
                ),
                controller.MAT_PRI.isNotEmpty
                    ? Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: controller.MAT_PRI.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(Dimensions.width10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${'الصنف'}:",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.height5),
                                  Text(
                                    controller.MAT_PRI[index].MINA_D.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${'الوحدة'}:",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.height5),
                                  Text(
                                    controller.MAT_PRI[index].MUNA_D.toString(),
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              controller.UPIN_PRI == 1
                                  ? Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${'السعر'}:",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.height5),
                                  Text(
                                    " ${controller.formatter.format(controller.MAT_PRI[index].MPCO).toString()} ${controller.MAT_PRI[index].SCSY}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              )
                                  : Container(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "${'سعر البيع1'}:",
                                    style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: Dimensions.height5),
                                  Text(
                                    " ${controller.formatter.format(controller.MAT_PRI[index].MPS1).toString()} ${controller.MAT_PRI[index].SCSY}",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Dimensions.fonText,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}
