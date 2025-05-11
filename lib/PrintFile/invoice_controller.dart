import 'dart:convert';
import 'dart:typed_data';

import 'package:get/get.dart';


class InvoiceController extends GetxController {
  static Future<String> zatcaQrData({
    required String nameSaller,
    required String taxNumber,
    required String invoiceTotalAmount,
    String? invoiceDate,
    required String invoiceTaxAmount,
  }) async {
    //  String nameSaller = 'sakher almahdi';
    // String taxNumber = '123124123';
    invoiceDate ??= DateTime.now().toIso8601String();
    // String invoiceTotalAmount =
    //     orderDetails.totalPrice?.toStringAsFixed(2) ?? "0.0";
    // String invoiceTaxAmount = orderDetails.tax?.toStringAsFixed(2) ?? "0.0";

    BytesBuilder bytesBuilder = BytesBuilder();

    //salar name
    bytesBuilder.addByte(1);
    List<int> sellerNameBytes = utf8.encode(nameSaller);
    bytesBuilder.addByte(sellerNameBytes.length);
    bytesBuilder.add(sellerNameBytes);

    //taxNumber
    bytesBuilder.addByte(2);
    List<int> taxNumberBytes = utf8.encode(taxNumber);
    bytesBuilder.addByte(taxNumberBytes.length);
    bytesBuilder.add(taxNumberBytes);

    //invoiceDate
    bytesBuilder.addByte(3);
    List<int> invoiceDateBytes = utf8.encode(invoiceDate);
    bytesBuilder.addByte(invoiceDateBytes.length);
    bytesBuilder.add(invoiceDateBytes);

    //invoiceTotalAmount
    bytesBuilder.addByte(4);
    List<int> invoiceTotalAmountBytes = utf8.encode(invoiceTotalAmount);
    bytesBuilder.addByte(invoiceTotalAmountBytes.length);
    bytesBuilder.add(invoiceTotalAmountBytes);

    //invoiceTaxAmount
    bytesBuilder.addByte(5);
    List<int> invoiceTaxAmountBytes = utf8.encode(invoiceTaxAmount);
    bytesBuilder.addByte(invoiceTaxAmountBytes.length);
    bytesBuilder.add(invoiceTaxAmountBytes);

    Uint8List qrCodeAsBytes = bytesBuilder.toBytes();
    final Base64Encoder base64encoder = Base64Encoder();
    String qrData = base64encoder.convert(qrCodeAsBytes);

    return qrData;
  }


}
