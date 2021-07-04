import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/commons/errors/failures/failure.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repositoy.dart';
import 'package:to_do/features/todo/domain/usecases/retrieve_all_tasks.dart';

class MockTodoRepository extends Mock implements TodoRepository {}

void main() {
  late RetrieveAllTasks sut;
  late MockTodoRepository mockTodoRepository;

  setUp(() {
    mockTodoRepository = MockTodoRepository();
    sut = RetrieveAllTasksImpl(mockTodoRepository);
  });

  final id = 'id';
  final completed = false;
  final name = 'name';
  final todoTaskList = [TodoTask(id: id, completed: completed, name: name)];

  test(
    'should retrieve a list with todo tasks from the call method',
    () async {
      when(mockTodoRepository.retrieveAllTasks())
          .thenAnswer((_) async => Left(todoTaskList));

      final result = await sut.call();

      expect(result, Left(todoTaskList));

      verify(mockTodoRepository.retrieveAllTasks());

      verifyNoMoreInteractions(mockTodoRepository);
    },
  );
}
