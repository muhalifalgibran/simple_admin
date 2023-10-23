import 'package:dio/dio.dart';

class DioClient with DioMixin {
  static const _url = 'https://reqres.in/api/';

  static DioClient get instance => DioClient._();

  DioClient._() {
    options = BaseOptions(
      baseUrl: _url,
      connectTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 15000),
    );
  }

  static DioClient init() {
    return DioClient._();
  }
}
