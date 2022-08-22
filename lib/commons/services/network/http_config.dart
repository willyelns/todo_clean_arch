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
    _dio.options.headers['X-Bin-Meta'] = false;
    _dio.options.headers['X-Master-Key'] =
        r'$2b$10$m9D6DPfB9mTuM5wFZFQ4Wu6NobDidn.WXZI8aY8ae3LD7Nk.hMsFe';
    _dio.options.headers['X-Access-Key'] =
        r'$2b$10$aH4PQJmtXVmMS8Zoh2la2ugGcnBDUs7OWUd0kUsEMnAtmMrxsJg1q';
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
