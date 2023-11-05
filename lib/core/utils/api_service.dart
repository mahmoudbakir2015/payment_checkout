import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:payment_checkout/constants/strings/api_keys.dart';
import '../../constants/strings/constansts.dart';

class DioHelper {
  static Dio? dio;

  static init({bool isBaseUrl = true}) {
    dio = Dio(
      BaseOptions(
          baseUrl: Constant.baseUrl,
          receiveDataWhenStatusError: true,
          connectTimeout: const Duration(seconds: 10),
          receiveTimeout: const Duration(seconds: 10),
          headers: {
            // "Authorization": 'Bearer ${CacheHelper.getData(key: "Token")}',
            "Authorization": 'Bearer ${ApiKeys.stripeSecretKey}',
            // "lang": CacheHelper.getData(key: "lang") == "ar_EG" ? "ar" : "en",
          }),
    );
  }

  static Future<Response> postData({
    required String endPoint,
    required dynamic data,
    String? contentType,
  }) {
    return dio!.post(
      endPoint,
      data: data,
      options: Options(
        contentType: contentType,
        headers: {},
      ),
    );
  }

  static Future<Response> getData({
    required String endPoint,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
  }) {
    return dio!.get(endPoint, queryParameters: queryParameters, data: data);
  }

  static Future<Response> putData({
    required String url,
    required Map<String, dynamic> data,
  }) {
    return dio!.put(url, queryParameters: data);
  }

  static Future<Response> requestData({
    required String url,
    required Map<String, dynamic> data,
  }) {
    return dio!.request(url, queryParameters: data);
  }
}

class ErrorInterceptor extends Interceptor {
  @override
  Future onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      log("statusCode == 401");
    } else if (err.response?.statusCode == 403) {
      log("statusCode == 403");
    } else {
      log("statusCode == 500${err.response?.statusCode!}");
    }
    return super.onError(err, handler);
  }
}
