import 'package:mobx/mobx.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/delete_todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/retrieve_all_tasks.dart';
import 'package:to_do/features/todo/domain/usecases/update_todo_task.dart';

part 'todo_store.g.dart';

enum TodoState { initial, loading, loaded, error, deleted }

class TodoStore = _TodoStoreBase with _$TodoStore;

abstract class _TodoStoreBase with Store {
  _TodoStoreBase({
    required this.retrieveAllTasks,
    required this.updateTodoTask,
    required this.deleteTodoTask,
  });

  // Use cases
  final RetrieveAllTasks retrieveAllTasks;
  final UpdateTodoTask updateTodoTask;
  final DeleteTodoTask deleteTodoTask;

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

  // Action methods
  @action
  Future<void> loadTodoTasks() async {
    await _listAll();
  }

  @action
  Future<void> addTodoTask(TodoTask task) async {
    _todoTasks.add(task);
    todoTasks = _todoTasks;
  }

  @action
  Future<void> updateTask(int index, TodoTask task) async {
    final updateEither = await updateTodoTask(task);
    updateEither.fold((_) async {
      await _listAll();
    }, (failure) {
      todoState = TodoState.error;
    });
  }

  @action
  Future<void> deleteTask(TodoTask task) async {
    final deleteEither = await deleteTodoTask(task);
    deleteEither.fold((_) async {
      await _listAll();
      todoState = TodoState.deleted;
    }, (failure) {
      todoState = TodoState.error;
    });
  }

  Future<void> _listAll() async {
    todoState = TodoState.loading;
    final listEither = await retrieveAllTasks();
    listEither.fold((list) {
      _todoTasks = list;
      todoTasks = _todoTasks;
      todoState = TodoState.loaded;
    }, (failure) {
      todoState = TodoState.error;
    });
  }
}
