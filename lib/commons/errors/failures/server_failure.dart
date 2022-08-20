import 'failure.dart';

class ServerFailure extends Failure {
  const ServerFailure({String? message}) : super(message);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
