import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/todo_task.dart';
import '../../domain/usecases/delete_todo_task.dart';
import '../../domain/usecases/retrieve_all_tasks.dart';
import '../../domain/usecases/update_todo_task.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(
      {required this.retrieveAllTasks,
      required this.updateTodoTask,
      required this.deleteTodoTask})
      : super(TodoInitialState());

  final RetrieveAllTasks retrieveAllTasks;
  final UpdateTodoTask updateTodoTask;
  final DeleteTodoTask deleteTodoTask;

  @override
  Stream<TodoState> mapEventToState(TodoEvent event) async* {
    if (event is TodoList) {
      yield* _mapTodoLoadedToState();
    }
    if (event is TodoUpdated) {
      yield* _mapTodoUpdatedToState(event);
    }
    if (event is TodoDeleted) {
      yield* _mapTodoDeletedToState(event);
    }
  }

  Stream<TodoState> _mapTodoLoadedToState() async* {
    yield* _listAll();
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodoLoadedState) {
      final task = event.todo;
      final updateEither = await updateTodoTask(task);
      yield* updateEither.fold((_) async* {
        yield* _listAll();
      }, (failure) async* {
        yield TodoFailureState();
      });
    }
  }

  Stream<TodoState> _mapTodoDeletedToState(TodoDeleted event) async* {
    if (state is TodoLoadedState) {
      final task = event.todo;
      final deleteEither = await deleteTodoTask(task);
      yield* deleteEither.fold((_) async* {
        yield TodoDeletedState();
        yield* _listAll();
      }, (failure) async* {
        yield TodoFailureState();
      });
    }
  }

  Stream<TodoState> _listAll() async* {
    yield TodoLoadingState();
    final either = await retrieveAllTasks();
    yield* either.fold((list) async* {
      yield TodoLoadedState(list);
    }, (failure) async* {
      yield TodoFailureState();
    });
  }
}
