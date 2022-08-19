import 'package:to_do/commons/errors/exceptions/exceptions.dart';
import 'package:to_do/commons/errors/failures/failures.dart';
import 'package:to_do/commons/services/network/network_info.dart';
import 'package:to_do/features/todo/data/datasources/todo_data_source.dart';
import 'package:to_do/features/todo/data/models/todo_task_model.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:dartz/dartz.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

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

  @override
  Future<Either<void, Failure>> updateTodoTask(TodoTask todoTask) async {
    if (await networkInfo.isConnected) {
      return _updateRemoteTask(todoTask);
    }
    return _updateLocalTask(todoTask);
  }

  Future<Either<void, Failure>> _updateRemoteTask(TodoTask todoTask) async {
    final model = TodoTaskModel.fromEntity(todoTask);
    try {
      final list = await remoteDataSource.updateTask(model);
      return Left(list);
    } on ServerException {
      return _updateLocalTask(model);
    } catch (e) {
      return Right(const ServerFailure());
    }
  }

  Future<Either<void, Failure>> _updateLocalTask(TodoTask todoTask) async {
    try {
      final list =
          await localDataSource.updateTask(TodoTaskModel.fromEntity(todoTask));
      return Left(list);
    } on CacheException {
      return Right(const CacheFailure());
    } catch (e) {
      return Right(const ConnectionFailure());
    }
  }

  @override
  Future<Either<void, Failure>> deleteTodoTask(TodoTask todoTask) async {
    if (await networkInfo.isConnected) {
      return _deleteRemoteTask(todoTask);
    }
    return _deleteLocalTask(todoTask);
  }

  @override
  Future<Either<void, Failure>> addTodoTask(TodoTask todoTask) async {
    if (await networkInfo.isConnected) {
      return _addRemoteTask(todoTask);
    }
    return _addLocalTask(todoTask);
  }

  Future<Either<void, Failure>> _addRemoteTask(TodoTask todoTask) async {
    final model = TodoTaskModel.fromEntity(todoTask);
    try {
      final response = await remoteDataSource.addTask(model);
      return Left(response);
    } on ServerException {
      return _addLocalTask(model);
    } catch (e) {
      return Right(const ServerFailure());
    }
  }

  Future<Either<void, Failure>> _addLocalTask(TodoTask todoTask) async {
    try {
      final response =
          await localDataSource.addTask(TodoTaskModel.fromEntity(todoTask));
      return Left(response);
    } on CacheException {
      return Right(const CacheFailure());
    } catch (e) {
      return Right(const ConnectionFailure());
    }
  }

  Future<Either<void, Failure>> _deleteRemoteTask(TodoTask todoTask) async {
    final model = TodoTaskModel.fromEntity(todoTask);
    try {
      final list = await remoteDataSource.deleteTask(model);
      return Left(list);
    } on ServerException {
      return _deleteLocalTask(model);
    } catch (e) {
      return Right(const ServerFailure());
    }
  }

  Future<Either<void, Failure>> _deleteLocalTask(TodoTask todoTask) async {
    try {
      final list =
          await localDataSource.deleteTask(TodoTaskModel.fromEntity(todoTask));
      return Left(list);
    } on CacheException {
      return Right(const CacheFailure());
    } catch (e) {
      return Right(const ConnectionFailure());
    }
  }
}
