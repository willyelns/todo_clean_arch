import 'package:equatable/equatable.dart';

class CacheException extends Equatable implements Exception {
  const CacheException({this.message});

  final String? message;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
