import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';

class DioClient with DioMixin {
  static const _url = 'https://reqres.in/api/';

  // instanciate
  static final DioClient _instance = DioClient._internal();

  // factory constructor to return the single instance
  factory DioClient() => _instance;

  // call as singleton
  DioClient._internal() {
    options = BaseOptions(
      baseUrl: _url,
      connectTimeout: const Duration(milliseconds: 30000),
    );

    httpClientAdapter = HttpClientAdapter();
  }
}
