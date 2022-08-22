import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/todo_task.dart';
import '../../domain/usecases/add_todo_task.dart';
import '../../domain/usecases/delete_todo_task.dart';
import '../../domain/usecases/retrieve_all_tasks.dart';
import '../../domain/usecases/update_todo_task.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  TodoBloc(
      {required RetrieveAllTasks retrieveAllTasks,
      required UpdateTodoTask updateTodoTask,
      required DeleteTodoTask deleteTodoTask,
      required AddTodoTask addTodoTask})
      : _addTodoTask = addTodoTask,
        _deleteTodoTask = deleteTodoTask,
        _retrieveAllTasks = retrieveAllTasks,
        _updateTodoTask = updateTodoTask,
        super(TodoInitialState());

  final RetrieveAllTasks _retrieveAllTasks;
  final UpdateTodoTask _updateTodoTask;
  final DeleteTodoTask _deleteTodoTask;
  final AddTodoTask _addTodoTask;

  List<TodoTask> _todoTasks = [];

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
    if (event is TodoAdd) {
      yield* _mapTodoAddToState(event);
    }
  }

  Stream<TodoState> _mapTodoLoadedToState() async* {
    yield* _listAll();
  }

  Stream<TodoState> _mapTodoUpdatedToState(TodoUpdated event) async* {
    if (state is TodoLoadedState) {
      final task = event.todo;
      final updateEither = await _updateTodoTask(task);
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
      final deleteEither = await _deleteTodoTask(task);
      yield* deleteEither.fold((_) async* {
        yield TodoDeletedState();
        yield* _listAll();
      }, (failure) async* {
        yield TodoFailureState();
      });
    }
  }

  Stream<TodoState> _mapTodoAddToState(TodoAdd event) async* {
    if (state is TodoLoadedState) {
      final name = event.name;
      final description = event.description;
      final task = _createTask(name, description);
      final addedEither = await _addTodoTask(task);
      yield* addedEither.fold((_) async* {
        yield TodoAddedState();
        yield* _listAll();
      }, (failure) async* {
        yield TodoFailureState();
      });
    }
  }

  TodoTask _createTask(String name, String? description) {
    // ignore: omit_local_variable_types
    int id = 0;
    if (_todoTasks.isNotEmpty) {
      final lastItem = _todoTasks.last;
      final stringId = lastItem.id;
      final lastId = int.tryParse(stringId) ?? 0;
      id = lastId + 1;
    }

    return TodoTask(
      name: name,
      description: description,
      id: id.toString(),
      completed: false,
    );
  }

  Stream<TodoState> _listAll() async* {
    yield TodoLoadingState();
    final either = await _retrieveAllTasks();
    yield* either.fold((list) async* {
      _todoTasks = list;
      yield TodoLoadedState(list);
    }, (failure) async* {
      yield TodoFailureState();
    });
  }
}
