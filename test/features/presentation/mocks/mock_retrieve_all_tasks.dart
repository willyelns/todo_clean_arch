import 'package:dartz/dartz.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/retrieve_all_tasks.dart';

class MockRetrieveAllTasks extends Mock implements RetrieveAllTasks {
  @override
  Future<Either<List<TodoTask>, Failure>> call() {
    return super.noSuchMethod(Invocation.method(#call, null),
        returnValue: Future<Either<List<TodoTask>, Failure>>.value(Left([])));
  }
}
