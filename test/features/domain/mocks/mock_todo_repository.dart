import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repositoy.dart';

class MockTodoRepository extends Mock implements TodoRepository {
  Future<Either<List<TodoTask>, Failure>> retrieveAllTasks() {
    return super.noSuchMethod(Invocation.method(#retrieveAllTasks, null),
        returnValue: Future<Either<List<TodoTask>, Failure>>.value(Left([])));
  }

  Future<Either<void, Failure>> updateTodoTask(TodoTask todoTask) {
    return super.noSuchMethod(Invocation.method(#updateTodoTask, null),
        returnValue: Future<Either<void, Failure>>.value(Left(Void)));
  }

  Future<Either<void, Failure>> deleteTodoTask(TodoTask todoTask) {
    return super.noSuchMethod(Invocation.method(#deleteTodoTask, null),
        returnValue: Future<Either<void, Failure>>.value(Left(Void)));
  }
}
