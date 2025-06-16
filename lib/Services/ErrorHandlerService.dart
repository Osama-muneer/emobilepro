import '../Widgets/config.dart';
import 'ToastService.dart';

class ErrorHandlerService {
  static Future<T> run<T>(
      Future<T> Function() action, {
        String Err = '',
        Function(Object error, StackTrace st)? onError,
        bool showToast = true,
      }) async {
    try {
      return await action(); // ✅ هذا هو المطلوب
    } catch (e, st) {
      printLongText("⚠️ Error: $e\nStackTrace: $st");

      if (showToast) {
        await ToastService.showError("$Err ${e.toString()}");
      }

      if (onError != null) {
        onError(e, st);
      }

      rethrow; // ❗ لازم تبقى لأنه بدونها هيرجع null و Dart ما تقبل
    }
  }
}

