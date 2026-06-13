import 'package:dio/dio.dart';

class ApiService {
  static final Dio dio = Dio();

  static Future<Response> request({
    required String method,
    required String url,
    Map<String, dynamic>? body,
    Map<String, dynamic>? headers,
  }) async {
    return await dio.request(
      url,
      data: body,
      options: Options(
        method: method,
        headers: headers,
      ),
    );
  }
}