import 'package:barcode_scan2/barcode_scan2.dart';

class BarcodeService {
  // يمكنك تطبيق سنجلتون إذا رغبت:
  static final BarcodeService _instance = BarcodeService._internal();
  factory BarcodeService() => _instance;
  BarcodeService._internal();

  /// ترجع المحتوى الممسوح أو رسالة خطأ
  Future<String> scanBarcode() async {
    try {
      var result = await BarcodeScanner.scan();
      return result.rawContent; // محتوى الباركود
    } catch (e) {
      return 'Failed to get barcode.';
    }
  }
}
