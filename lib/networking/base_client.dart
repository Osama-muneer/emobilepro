import 'dart:async';
import 'package:dio/dio.dart';
import 'api_interceptors.dart';
import 'api_result.dart';
import 'enums_networking.dart';

class DioHelper {
  late Dio _dio;

  dioInit() {
    _dio = Dio(
      BaseOptions(
        baseUrl: 'ApiConstants.baseUrl',
        responseType: ResponseType.json,
        contentType: "application/json",
        receiveDataWhenStatusError: true,
        validateStatus: (status) {
          return status! < 500;
        },
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          "Authorization" : "Basic e\$\$Upr@OU_R"
        },
      ),
    );
    _dio.interceptors.add(ApiInterceptors());
  }

  /// perform safe api request
  Future<ApiResult> safeApiCall(
    String url,
    RequestType requestType, {
    bool addToken = false,
    Map<String, dynamic>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    try {
      print('safeApiCall');
      print(url);
      print(requestType);
      print(addToken);
      print(headers);
      print(queryParameters);
      print(body);
      dioInit();
      // if (await ConnectivityNetwork.checkConnectivityNetwork()) {
      //   print("HAS INTERNT");
      // add token in request
      // if (addToken) {
      //   String? token = await SharedPref.getString(SharedPref.token);
      //   headers = {"Authorization": "Bearer $token"};
      // }

      // 1) try to perform http request
      late Response response;
      if (requestType == RequestType.get) {
        response = await _dio.get(
          url,
          queryParameters: queryParameters,
          options: Options(headers: headers),
          data: body,
        );
      } else if (requestType == RequestType.post) {
        response = await _dio.post(
          url,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
         print('response');
         print(response);
      } else if (requestType == RequestType.put) {
        response = await _dio.put(
          url,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      } else {
        response = await _dio.delete(
          url,
          data: body,
          queryParameters: queryParameters,
          options: Options(headers: headers),
        );
      }

      // print("response.data : ${response.statusCode}");
      if (response.statusCode == 200) {
        // 2) return response (api done successfully)
        return ApiResult.success(
            response: response, apiCallStatus: ApiCallStatus.success,message: response.data['message']);
      } else {
        return ApiResult.error(
          message: response.data['message'],
          apiCallStatus: ApiCallStatus.networkError,
        );
      }
      // } else {
      //   return ApiResult.error(
      //     message: StringsConstants.networkError,
      //     apiCallStatus: ApiCallStatus.networkError,
      //   );
      // }
    } on DioException catch (error) {
      // dio error (api reach the server but not performed successfully
      return ApiResult.error(
          message: "",
          response: error.response,
          apiCallStatus: ApiCallStatus.error);
    } catch (e) {
      return ApiResult.error(
        message: e.toString(),
        response: null,
        apiCallStatus: ApiCallStatus.error,
      );
    }
  }

  // Future<Map<String, dynamic>> addTokenToRequest() async {
  //   String? token = await SharedPref.getString(SharedPref.token);
  //   return {"Authorization": "Bearer $token"};
  // }
}
