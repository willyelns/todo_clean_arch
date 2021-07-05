import 'failure.dart';

class CacheFailure implements Failure {
  const CacheFailure({this.message});

  @override
  final String? message;

  @override
  bool? get stringify => true;

  @override
  List<Object?> get props => [message];
}
