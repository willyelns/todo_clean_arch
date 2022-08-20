import 'package:internet_connection_checker/internet_connection_checker.dart';

part 'network_info_impl.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}
