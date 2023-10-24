import 'package:dio/dio.dart';

// we create dio client as Lazy singleton, so whenever this class
// is called, it just calls the latest instance if it already instanciated
// from other class, if there is no instanciate before, it should instanciate
// for the first time.
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

    // this is base adapter for browser/native call
    // we shouldn't use like IOHttpClientAdapter, etc.
    httpClientAdapter = HttpClientAdapter();
  }
}
