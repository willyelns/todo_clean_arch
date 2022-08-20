import 'package:dartz/dartz.dart';

import '../../../../commons/errors/exceptions/exceptions.dart';
import '../../../../commons/errors/failures/failures.dart';
import '../../../../commons/services/network/network_info.dart';
import '../../domain/entities/todo_task.dart';
import '../../domain/repositories/todo_repository.dart';
import '../datasources/todo_data_source.dart';
import '../models/todo_task_model.dart';

class TodoRepositoryImpl implements TodoRepository {
  const TodoRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });

  final NetworkInfo networkInfo;
  final TodoRemoteDataSource remoteDataSource;
  final TodoLocalDataSource localDataSource;

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
    } on Object {
      return const Right(ServerFailure());
    }
  }

  Future<Either<List<TodoTask>, Failure>> _retrieveLocalAllTasks() async {
    try {
      final list = await localDataSource.retrieveAllTasks();
      return Left(list);
    } on CacheException {
      return const Right(CacheFailure());
    } on Object {
      return const Right(ConnectionFailure());
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
    } on Object {
      return const Right(ServerFailure());
    }
  }

  Future<Either<void, Failure>> _updateLocalTask(TodoTask todoTask) async {
    try {
      final list =
          await localDataSource.updateTask(TodoTaskModel.fromEntity(todoTask));
      return Left(list);
    } on CacheException {
      return const Right(CacheFailure());
    } on Object {
      return const Right(ConnectionFailure());
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
    } on Object {
      return const Right(ServerFailure());
    }
  }

  Future<Either<void, Failure>> _addLocalTask(TodoTask todoTask) async {
    try {
      final response =
          await localDataSource.addTask(TodoTaskModel.fromEntity(todoTask));
      return Left(response);
    } on CacheException {
      return const Right(CacheFailure());
    } on Object {
      return const Right(ConnectionFailure());
    }
  }

  Future<Either<void, Failure>> _deleteRemoteTask(TodoTask todoTask) async {
    final model = TodoTaskModel.fromEntity(todoTask);
    try {
      final list = await remoteDataSource.deleteTask(model);
      return Left(list);
    } on ServerException {
      return _deleteLocalTask(model);
    } on Object {
      return const Right(ServerFailure());
    }
  }

  Future<Either<void, Failure>> _deleteLocalTask(TodoTask todoTask) async {
    try {
      final list =
          await localDataSource.deleteTask(TodoTaskModel.fromEntity(todoTask));
      return Left(list);
    } on CacheException {
      return const Right(CacheFailure());
    } on Object {
      return const Right(ConnectionFailure());
    }
  }
}
