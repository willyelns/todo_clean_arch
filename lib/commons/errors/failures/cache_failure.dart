import 'failure.dart';

class CacheFailure extends Failure {
  const CacheFailure({String? message}) : super(message);

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
