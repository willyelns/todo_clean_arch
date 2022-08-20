import 'package:dartz/dartz.dart';

import '../errors/failures/failure.dart';

typedef UseCaseResponse<T> = Future<Either<T, Failure>>;

typedef SuccessCallback<T, R> = R Function(T data);

typedef FailureCallback<R> = R Function(Failure failure);

extension UseCaseResponseExtension<T> on UseCaseResponse {
  static UseCaseResponse<T> createSuccess<T>(T value) async =>
      Left<T, Failure>(value);

  static UseCaseResponse<T> createFailure<T>(Failure failure) async =>
      Right<T, Failure>(failure);

  Future<R?> open<R>({
    required SuccessCallback<T, R> successCallback,
    required FailureCallback<R> failureCallback,
  }) async {
    final either = await this as Either<T, Failure>;
    return either.fold<R>(successCallback, failureCallback);
  }
}
