import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';

class MockTodoRepository extends Mock implements TodoRepository {
  @override
  Future<Either<List<TodoTask>, Failure>> retrieveAllTasks() {
    return super.noSuchMethod(Invocation.method(#retrieveAllTasks, null),
        returnValue:
            Future<Either<List<TodoTask>, Failure>>.value(const Left([])));
  }

  @override
  Future<Either<void, Failure>> updateTodoTask(TodoTask todoTask) {
    return super.noSuchMethod(Invocation.method(#updateTodoTask, null),
        returnValue: Future<Either<void, Failure>>.value(const Left(null)));
  }

  @override
  Future<Either<void, Failure>> deleteTodoTask(TodoTask todoTask) {
    return super.noSuchMethod(Invocation.method(#deleteTodoTask, null),
        returnValue: Future<Either<void, Failure>>.value(const Left(null)));
  }
}
