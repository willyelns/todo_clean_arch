import 'failure.dart';

class ConnectionFailure extends Failure {
  const ConnectionFailure({String? message}) : super(message);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
