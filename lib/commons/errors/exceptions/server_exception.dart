import 'package:equatable/equatable.dart';

import '../../../../commons/types/json_data.dart';

class ServerException extends Equatable implements Exception {
  const ServerException({
    this.code,
    this.message,
    this.fields,
  });

  factory ServerException.fromJson(JsonData json) {
    final code = json['code'];
    return ServerException(
      code: code,
      message: json['message'],
      fields: json['fields'],
    );
  }

  final int? code;
  final String? message;
  final List<dynamic>? fields;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [
        code,
        message,
        fields,
      ];
}
