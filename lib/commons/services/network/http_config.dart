import 'package:dio/dio.dart';
import 'package:logger/logger.dart';

class HttpConfigService {
  HttpConfigService({
    required Logger logger,
    required String baseUrl,
    int? timeout,
  })  : _timeout = timeout,
        _logger = logger,
        _baseUrl = baseUrl;

  final int? _timeout;
  final Logger _logger;
  final String _baseUrl;
  late final Dio _dio;

  Dio get appDioInstance {
    return _createDio();
  }

  Dio _createDio() {
    _dio = Dio(
      BaseOptions(
        receiveTimeout: _timeout,
        connectTimeout: _timeout,
        sendTimeout: _timeout,
        baseUrl: _baseUrl,
      ),
    );
    _addDefaultHeaders();
    _addInterceptors();
    _logger.v('The default Interceptor was added');
    return _dio;
  }

  void _addDefaultHeaders() {
    _dio.options.headers['Content-Type'] = 'application/json';
  }

  void _addInterceptors() {
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
      ),
    );
  }
}
