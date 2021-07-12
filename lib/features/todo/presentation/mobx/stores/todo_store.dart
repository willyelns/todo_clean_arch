import 'package:mobx/mobx.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/add_todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/delete_todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/retrieve_all_tasks.dart';
import 'package:to_do/features/todo/domain/usecases/update_todo_task.dart';
import 'package:to_do/features/todo/presentation/mobx/stores/add_todo_form_store.dart';
import 'package:to_do/features/todo/presentation/page_states/todo_state.dart';

part 'todo_store.g.dart';

class TodoStore = _TodoStoreBase with _$TodoStore;

abstract class _TodoStoreBase with Store {
  _TodoStoreBase({
    required RetrieveAllTasks retrieveAllTasks,
    required UpdateTodoTask updateTodoTask,
    required DeleteTodoTask deleteTodoTask,
    required AddTodoTask addTodoTask,
    required this.addTodoFormStore,
  })  : this._retrieveAllTasks = retrieveAllTasks,
        this._updateTodoTask = updateTodoTask,
        this._addTodoTask = addTodoTask,
        this._deleteTodoTask = deleteTodoTask;

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
      addEither.fold((_) async {
        await _loadTodoTasks();
        todoState = TodoState.added;
        print('Store list: $todoTasks');
      }, (failure) {
        todoState = TodoState.error;
      });
    }
  }

  @action
  Future<void> updateTodoTask(TodoTask task) async {
    final updateEither = await _updateTodoTask(task);
    updateEither.fold((_) async {
      await _loadTodoTasks();
    }, (failure) {
      todoState = TodoState.error;
    });
  }

  @action
  Future<void> deleteTodoTask(TodoTask task) async {
    final deleteEither = await _deleteTodoTask(task);
    deleteEither.fold((_) async {
      await _loadTodoTasks();
      todoState = TodoState.deleted;
    }, (failure) {
      todoState = TodoState.error;
    });
  }

  TodoTask _createTaskToAdd() {
    final name = addTodoFormStore.name;
    final description = addTodoFormStore.description;
    final lastId = int.parse(_todoTasks.last.id);
    final id = lastId + 1;
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
    final listEither = await _retrieveAllTasks();
    listEither.fold((list) {
      _todoTasks = list;
      todoTasks = _todoTasks;
      todoState = TodoState.loaded;
    }, (failure) {
      todoState = TodoState.error;
    });
  }
}
