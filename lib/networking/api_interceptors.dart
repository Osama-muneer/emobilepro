import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class ApiInterceptors extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    Logger().i(
        "onRequest : URL : ${options.baseUrl}${options.path} \n Headers : ${options.headers} \n Data : ${options.data} \n Method : ${options.method}");
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    Logger().d("onResponse : ${response.statusCode} \n ${response.data}");
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('⛔ onError : ${err.type}: ${err.message}');
    print('⛔ Error details: ${err.response?.data}');
    super.onError(err, handler);
    Logger().e("onError : ${err}");
  }
}
