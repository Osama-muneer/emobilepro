import 'package:share_plus/share_plus.dart';

Future<void> sharePdf(String path, { String? msg }) async {
  final params = ShareParams(
    files: [ XFile(path, mimeType: 'application/pdf') ],
    text: (msg != null && msg.trim().isNotEmpty) ? msg : null,
  );

  final result = await SharePlus.instance.share(params);

  if (result.status == ShareResultStatus.success) {
    print('تمّ مشاركة الملف بنجاح');
  } else if (result.status == ShareResultStatus.dismissed) {
    print('تمّ إغلاق نافذة المشاركة بدون إرسال');
  }
}

