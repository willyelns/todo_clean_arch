import 'package:to_do/commons/errors/exceptions/exceptions.dart';
import 'package:to_do/commons/errors/failures/failures.dart';
import 'package:to_do/commons/services/network/network_info.dart';
import 'package:to_do/features/todo/data/datasources/todo_data_source.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repositoy.dart';

class TodoRepositoryImpl implements TodoRepository {
  final NetworkInfo networkInfo;
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;

  const TodoRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<List<TodoTask>, Failure>> retrieveAllTasks() async {
    if (await networkInfo.isConnected) {
      return _retrieveRemoteAllTasks();
    }
    return _retrieveLocalAllTasks();
  }

  Future<Either<List<TodoTask>, Failure>> _retrieveRemoteAllTasks() async {
    try {
      final list = await remoteDataSource.retrieveAllTasks();
      return Left(list);
    } on ServerException {
      return _retrieveLocalAllTasks();
    } catch (e) {
      return Right(const ServerFailure());
    }
  }

  Future<Either<List<TodoTask>, Failure>> _retrieveLocalAllTasks() async {
    try {
      final list = await localDataSource.retrieveAllTasks();
      return Left(list);
    } on CacheException {
      return Right(const CacheFailure());
    } catch (e) {
      return Right(const ConnectionFailure());
    }
  }
}
