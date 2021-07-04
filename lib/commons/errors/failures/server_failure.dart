import 'failure.dart';

class ServerFailure implements Failure {
  const ServerFailure({this.message});

  @override
  final String? message;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
