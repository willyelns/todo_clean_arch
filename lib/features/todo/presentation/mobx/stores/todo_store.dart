import 'package:flutter/foundation.dart';
import 'package:mobx/mobx.dart';
import '../../../../../commons/types/use_case_response.dart';

import '../../../domain/entities/todo_task.dart';
import '../../../domain/usecases/add_todo_task.dart';
import '../../../domain/usecases/delete_todo_task.dart';
import '../../../domain/usecases/retrieve_all_tasks.dart';
import '../../../domain/usecases/update_todo_task.dart';
import '../../page_states/todo_state.dart';
import 'add_todo_form_store.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStoreBase with _$TodoStore;

abstract class _TodoStoreBase with Store {
  _TodoStoreBase({
    required RetrieveAllTasks retrieveAllTasks,
    required UpdateTodoTask updateTodoTask,
    required DeleteTodoTask deleteTodoTask,
    required AddTodoTask addTodoTask,
    required this.addTodoFormStore,
  })  : _retrieveAllTasks = retrieveAllTasks,
        _updateTodoTask = updateTodoTask,
        _addTodoTask = addTodoTask,
        _deleteTodoTask = deleteTodoTask;

  // Use cases
  final RetrieveAllTasks _retrieveAllTasks;
  final UpdateTodoTask _updateTodoTask;
  final DeleteTodoTask _deleteTodoTask;
  final AddTodoTask _addTodoTask;

  // Store
  final AddTodoFormStore addTodoFormStore;

  List<TodoTask> _todoTasks = <TodoTask>[];

  // Observables
  @observable
  List<TodoTask> todoTasks = [];
  @observable
  TodoState todoState = TodoState.initial;

  @computed
  TodoState get currentState => todoState;

  @computed
  String get errorMessage => todoState == TodoState.error
      ? 'This could not be completed, be try again later'
      : '';

  int get _lastTodoId {
    if (_todoTasks.isNotEmpty) {
      final lastItem = _todoTasks.last;
      return int.tryParse(lastItem.id) ?? 0;
    }
    return 0;
  }

  // Action methods
  @action
  Future<void> retrieveAllTasks() async {
    await _loadTodoTasks();
  }

  @action
  Future<void> addTodoTask() async {
    if (currentState != TodoState.loading) {
      todoState = TodoState.loading;
      final task = _createTaskToAdd();
      final addEither = await _addTodoTask(task);
      await addEither.fold((_) async {
        await _loadTodoTasks();
        todoState = TodoState.added;
        debugPrint('Store list: $todoTasks');
      }, (failure) {
        todoState = TodoState.error;
      });
    }
  }

  @action
  Future<void> updateTodoTask(TodoTask task) async {
    final updateEither = _updateTodoTask(task);
    await await updateEither.open(successCallback: (_) async {
      await _loadTodoTasks();
    }, failureCallback: (failure) {
      todoState = TodoState.error;
    });
  }

  @action
  Future<void> deleteTodoTask(TodoTask task) async {
    final deleteEither = _deleteTodoTask(task);
    await await deleteEither.open(successCallback: (_) async {
      await _loadTodoTasks();
      todoState = TodoState.deleted;
    }, failureCallback: (failure) {
      todoState = TodoState.error;
    });
  }

  TodoTask _createTaskToAdd() {
    final name = addTodoFormStore.name;
    final description = addTodoFormStore.description;
    final id = _lastTodoId + 1;
    final task = TodoTask(
      id: id.toString(),
      completed: false,
      name: name,
      description: description,
    );
    return task;
  }

  Future<void> _loadTodoTasks() async {
    todoState = TodoState.loading;
    final listEither = _retrieveAllTasks();
    await listEither.open(successCallback: (list) {
      _todoTasks = list;
      todoTasks = _todoTasks;
      todoState = TodoState.loaded;
    }, failureCallback: (failure) {
      todoState = TodoState.error;
    });
  }
}
