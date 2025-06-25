import 'package:share_plus/share_plus.dart';

Future<void> sharePdf(String path, { String? msg }) async {
  // 1. حضّر قائمة الملفات كمثال واحد أو أكثر
  final params = ShareParams(
    text: msg ?? '',
    files: [ XFile(path, mimeType: 'application/pdf') ],
    // sharePositionOrigin: Rect ارتفاع وموضع المشاركة اختياري
  );

  // 2. نفّذ المشاركة
  final result = await SharePlus.instance.share(params);

  // 3. (اختياري) تعامُل مع نتيجة المشاركة
  if (result.status == ShareResultStatus.success) {
    print('تمّ مشاركة الملف بنجاح');
  } else if (result.status == ShareResultStatus.dismissed) {
    print('تمّ إغلاق نافذة المشاركة بدون إرسال');
  }
}
