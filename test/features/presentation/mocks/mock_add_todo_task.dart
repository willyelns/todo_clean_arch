import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/add_todo_task.dart';

class MockAddTodoTask extends Mock implements AddTodoTask {
  @override
  Future<Either<void, Failure>> call(TodoTask task) {
    return super.noSuchMethod(Invocation.method(#call, null),
        returnValue: Future<Either<void, Failure>>.value(const Left(null)));
  }
}
