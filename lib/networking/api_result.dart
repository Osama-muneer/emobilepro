import 'package:dio/dio.dart';
import 'package:get/get_utils/get_utils.dart';
import '../Widgets/snack_bar.dart';
import 'enums_networking.dart';

class ApiResult {
  String message;
  int code;
  ApiCallStatus apiCallStatus;
  Response? response;

  ApiResult({
    this.message = '',
    this.code = 0,
    this.apiCallStatus = ApiCallStatus.holding,
    this.response,
  });

  factory ApiResult.success({
    required Response response,
    ApiCallStatus apiCallStatus = ApiCallStatus.success,
    String message = "Request send and receive successfully",
    int code = 200,
  }) {
    return ApiResult(
      message: message.tr,
      code: code,
      apiCallStatus: apiCallStatus,
      response: response,
    );
  }

  factory ApiResult.error({
    Response? response,
    ApiCallStatus apiCallStatus = ApiCallStatus.error,
    String message = "Request not successfully",
    int code = 404,
  }) {
    return ApiResult(
      message: message.tr,
      code: code,
      apiCallStatus: apiCallStatus,
      response: response,
    );
  }

  void handelRequest({
    required Function(ApiResult apiResult) success,
    Function(ApiResult apiResult)? error,
  }) async {
    if (apiCallStatus == ApiCallStatus.success) {
      await success(this);
    } else {
      if (error != null) {
        error(this);
      } else {
        CustomSnackBar.showCustomErrorSnackBar(
          message: message,
        );
      }
    }
  }

  ApiCallStatus checkEmpty({required List data}) {
    if (data.isEmpty) {
      return ApiCallStatus.empty;
    }

    return ApiCallStatus.success;
  }
}
