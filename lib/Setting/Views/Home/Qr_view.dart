import 'dart:convert';
import 'package:barcode_scan2/barcode_scan2.dart';
import '../../../Widgets/config.dart';
import '../../../Widgets/dimensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../Setting/controllers/setting_controller.dart';
import '../../../Widgets/colors.dart';
import '../../../Widgets/theme_helper.dart';

class Qr_View extends StatefulWidget {
  @override
  State<Qr_View> createState() => _Qr_ViewState();
}

class _Qr_ViewState extends State<Qr_View> {
  final StteingController controller = Get.find();
  String _scanBarcode = 'Unknown';
  String dex = '';

  Future<void> scanQR() async {
    String barcodeScanRes;

    try {
      var result = await BarcodeScanner.scan();
      barcodeScanRes = result.rawContent;
      print(barcodeScanRes);
    } catch (e) {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      try {
        final decodedBytes = base64Decode(barcodeScanRes);
        dex = decodedBytes.toString(); // raw bytes
        _scanBarcode = utf8.decode(decodedBytes); // UTF-8 string
        print(dex);
        print(_scanBarcode);
      } catch (e) {
        _scanBarcode = 'Invalid Base64';
        dex = '';
        print('Error decoding: $e');
      }
    });
  }

  // Future<void> scanQR() async {
  //   String barcodeScanRes;
  //
  //   try {
  //     barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
  //         '#ff6666', 'Cancel', true, ScanMode.QR);
  //     print(barcodeScanRes);
  //   } on PlatformException {
  //     barcodeScanRes = 'Failed to get platform version.';
  //   }
  //
  //   if (!mounted) return;
  //
  //   setState(() {
  //     dex= base64Decode(barcodeScanRes).toString();
  //     _scanBarcode = utf8.decode(base64Decode(barcodeScanRes));
  //     print(dex);
  //     print(_scanBarcode);
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ThemeHelper().MainAppBar('Stringsetting'.tr),
      body: GetBuilder<StteingController>(
          init: StteingController(),
          builder: ((value) { if (controller.QR_INF.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "${ImagePath}no_data.png",
                    height: Dimensions.height60,
                  ),
                  Text('StringNoData'.tr,
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize:  Dimensions.fonAppBar),
                  ),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: controller.QR_INF.length,
            itemBuilder: (BuildContext context, int index) =>
                Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: Dimensions.height85,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${'StringAMDMD'.tr}:",
                                style: TextStyle(color: Colors.black87, fontSize: Dimensions.fonText, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: Dimensions.height5),
                              Text( controller.QR_INF[index].QICN.toString(),
                                style: TextStyle(color: Colors.black, fontSize: Dimensions.fonText),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${'StringAMDMD'.tr}:",
                                style: TextStyle(color: Colors.black87, fontSize: Dimensions.fonText, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: Dimensions.height5),
                              Text( controller.QR_INF[index].QICN.toString(),
                                style: TextStyle(color: Colors.black, fontSize: Dimensions.fonText),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${'StringAMDMD'.tr}:",
                                style: TextStyle(color: Colors.black87, fontSize: Dimensions.fonText, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: Dimensions.height5),
                              Text( controller.QR_INF[index].QICN.toString(),
                                style: TextStyle(color: Colors.black, fontSize: Dimensions.fonText),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height15),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text(
                                "${'StringAMDMD'.tr}:",
                                style: TextStyle(color: Colors.black87, fontSize: Dimensions.fonText, fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: Dimensions.height5),
                              Text( controller.QR_INF[index].QICN.toString(),
                                style: TextStyle(color: Colors.black, fontSize: Dimensions.fonText),
                              ),
                            ],
                          ),
                          SizedBox(height: Dimensions.height15),
                        ],
                      ),
                    ),
                  ],
                ),
          );
          })),
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: AppColors.MainColor,
        onPressed: () {
          controller.GET_QIID_P();
          scanQR();
        },
        label: Text('StringAdd'.tr,style: TextStyle( color: Colors.white)),
        icon: const Icon(Icons.qr_code,color: Colors.white,),
      ),
    );
  }

}



