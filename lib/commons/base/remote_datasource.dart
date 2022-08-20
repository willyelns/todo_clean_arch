import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import '../errors/exceptions/exceptions.dart' show ServerException;

abstract class RemoteDataSource {
  final acceptedStatusCodes = [
    HttpStatus.badRequest,
    HttpStatus.unauthorized,
    HttpStatus.notFound,
  ];

  @protected
  Future<T> handleException<T>(
    Future<T> Function() method, {
    required String errorMessage,
  }) async {
    try {
      return await method();
    } on DioError catch (e) {
      debugPrint(e.toString());
      if (e.response?.data != null &&
          e.response?.data?.isNotEmpty &&
          acceptedStatusCodes.contains(e.response?.statusCode)) {
        throw ServerException.fromJson(e.response?.data);
      }
      throw ServerException(message: errorMessage);
    } on Object catch (e) {
      debugPrint(e.toString());
      throw ServerException(message: errorMessage);
    }
  }
}
