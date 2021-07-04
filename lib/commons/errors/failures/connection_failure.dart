import 'failure.dart';

class ConnectionFailure implements Failure {
  const ConnectionFailure({this.message});

  @override
  final String? message;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
