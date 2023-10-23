import 'package:dio/dio.dart';

class DioClient with DioMixin {
  static const _url = 'https://reqres.in/api/';

  static final DioClient _instance = DioClient._internal();

  factory DioClient() => _instance;

  DioClient._internal() {
    options = BaseOptions(
      baseUrl: _url,
      connectTimeout: const Duration(milliseconds: 30000),
      sendTimeout: const Duration(milliseconds: 30000),
      receiveTimeout: const Duration(milliseconds: 15000),
    );
  }
}
