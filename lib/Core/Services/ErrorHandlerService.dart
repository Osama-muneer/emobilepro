import '../../Widgets/config.dart';
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
      printLongText("⚠️ Error: $e \n StackTrace: $st");

      if (showToast) {
        try {
          await ToastService.showError("$Err ${e.toString()}");
        } catch (toastError) {
          printLongText("⚠️ Error showing toast: $toastError");
        }
      }

      if (onError != null) {
        onError(e, st);
      }

      rethrow; // ❗ لازم تبقى لأنه بدونها هيرجع null و Dart ما تقبل
    }
  }
}

