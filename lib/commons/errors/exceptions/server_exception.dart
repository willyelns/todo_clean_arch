import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({this.message});

  final String? message;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
