import 'dart:ffi';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:to_do/commons/errors/failures/cache_failure.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/presentation/page_states/todo_state.dart';
import 'package:to_do/features/todo/presentation/stores/todo_store.dart';

import '../mocks/mocks.dart';

void main() {
  late TodoStore sut;
  late MockRetrieveAllTasks mockRetrieveAllTasks;
  late MockDeleteTodoTask mockDeleteTodoTask;
  late MockUpdateTodoTask mockUpdateTodoTask;

  setUp(() {
    mockRetrieveAllTasks = MockRetrieveAllTasks();
    mockDeleteTodoTask = MockDeleteTodoTask();
    mockUpdateTodoTask = MockUpdateTodoTask();

    sut = TodoStore(
      deleteTodoTask: mockDeleteTodoTask,
      retrieveAllTasks: mockRetrieveAllTasks,
      updateTodoTask: mockUpdateTodoTask,
    );
  });

  final idFirst = 'id-1';
  final idSecond = 'id-2';
  final completed = false;
  final name = 'name';
  final firstItem = TodoTask(id: idFirst, completed: completed, name: name);
  final secondItem = TodoTask(id: idSecond, completed: completed, name: name);
  final updatedItem = TodoTask(id: idFirst, completed: true, name: name);
  final todoTaskList = [firstItem, secondItem];

  test(
    'should has the initial list empty from the store',
    () async {
      final result = sut.todoTasks;

      expect(result, []);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );

  test(
    'should has the initial state from the store',
    () async {
      final result = sut.todoState;

      expect(result, TodoState.initial);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );

  test(
    'should has the initial errorMesasge empty from the store',
    () async {
      final result = sut.errorMessage;

      expect(result.isEmpty, true);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );

  test(
    'should return an error state when the loadTodoTasks() call fails',
    () async {
      when(mockRetrieveAllTasks())
          .thenAnswer((_) async => Right(CacheFailure()));

      await sut.loadTodoTasks();

      verify(mockRetrieveAllTasks());

      final errorMessage = sut.errorMessage;
      final stateResultAfterCall = sut.todoState;

      expect(errorMessage.isNotEmpty, true);
      expect(stateResultAfterCall, TodoState.error);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );

  test(
    'should return a list of todo tasks after the loadTodoTasks() call',
    () async {
      when(mockRetrieveAllTasks()).thenAnswer((_) async => Left(todoTaskList));

      final listResultBeforeCall = sut.todoTasks;

      final stateResultBeforeCall = sut.todoState;

      expect(listResultBeforeCall, []);
      expect(stateResultBeforeCall, TodoState.initial);

      await sut.loadTodoTasks();

      verify(mockRetrieveAllTasks());

      final listResultAfterCall = sut.todoTasks;
      final stateResultAfterCall = sut.todoState;

      expect(listResultAfterCall, todoTaskList);
      expect(stateResultAfterCall, TodoState.loaded);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );

  test(
    'should return a list with the value deleted after the deleteTodoTask() call',
    () async {
      when(mockDeleteTodoTask(firstItem)).thenAnswer((_) async => Left(Void));

      when(mockRetrieveAllTasks()).thenAnswer((_) async => Left([secondItem]));

      await sut.deleteTask(firstItem);

      verify(mockDeleteTodoTask(firstItem));
      verify(mockRetrieveAllTasks());

      final resultAfterCall = sut.todoTasks;
      final stateResultAfterCall = sut.todoState;

      expect(resultAfterCall, [secondItem]);
      expect(stateResultAfterCall, TodoState.deleted);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );

  test(
    'should return an error state when the deleteTodoTask() call fails',
    () async {
      when(mockDeleteTodoTask(firstItem))
          .thenAnswer((_) async => Right(const CacheFailure()));

      await sut.deleteTask(firstItem);

      verify(mockDeleteTodoTask(firstItem));

      final errorMessage = sut.errorMessage;
      final stateResultAfterCall = sut.todoState;

      expect(errorMessage.isNotEmpty, true);
      expect(stateResultAfterCall, TodoState.error);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );

  test(
    'should return a list with the value updated after the updateTodoTask() call',
    () async {
      when(mockUpdateTodoTask(updatedItem)).thenAnswer((_) async => Left(Void));

      when(mockRetrieveAllTasks())
          .thenAnswer((_) async => Left([updatedItem, secondItem]));

      await sut.updateTask(0, firstItem);

      verify(mockUpdateTodoTask(firstItem));
      verify(mockRetrieveAllTasks());

      final resultAfterCall = sut.todoTasks;

      expect(resultAfterCall, [updatedItem, secondItem]);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );
  test(
    'should return an error status when the updateTodoTask() fails',
    () async {
      when(mockUpdateTodoTask(updatedItem))
          .thenAnswer((_) async => Right(const CacheFailure()));

      await sut.updateTask(0, firstItem);

      verify(mockUpdateTodoTask(firstItem));

      final resultAfterCall = sut.todoState;
      final errorMessage = sut.errorMessage;

      expect(resultAfterCall, TodoState.error);
      expect(errorMessage.isNotEmpty, true);

      verifyNoMoreInteractions(mockRetrieveAllTasks);
      verifyNoMoreInteractions(mockDeleteTodoTask);
      verifyNoMoreInteractions(mockUpdateTodoTask);
    },
  );
}
