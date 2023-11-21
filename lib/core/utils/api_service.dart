import 'package:dio/dio.dart';

class ApiService {
  final Dio dio = Dio();

  Future<Response> post({
    required body,
    required String url,
    String? token,
    Map<String, String>? headers,
    String? contentType,
  }) async {
    var response = await dio.post(url,
        data: body,
        options: Options(
          contentType: contentType,
          headers: headers ?? {'Authorization': "Bearer $token"},
        ));

    return response;
  }

  Future<Response> getData({
    required String url,
    String? token,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? data,
    String? contentType,
  }) async {
    var response = await dio.get(url,
        queryParameters: queryParameters,
        data: data,
        options: Options(
          contentType: contentType,
          headers: headers ?? {'Authorization': "Bearer $token"},
        ));
    return response;
  }
}
