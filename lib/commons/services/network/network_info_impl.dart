part of 'network_info.dart';

class NetworkInfoImpl implements NetworkInfo {
  NetworkInfoImpl({required this.connectionChecker});

  final InternetConnectionChecker connectionChecker;

  @override
  Future<bool> get isConnected => connectionChecker.hasConnection;
}
