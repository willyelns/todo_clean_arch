import 'package:get/get.dart';
import 'package:to_do/features/todo/domain/entities/todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/delete_todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/retrieve_all_tasks.dart';
import 'package:to_do/features/todo/domain/usecases/update_todo_task.dart';
import 'package:to_do/features/todo/presentation/page_states/todo_state.dart';

class TodoController extends GetxController {
  TodoController({
    required RetrieveAllTasks retrieveAllTasks,
    required DeleteTodoTask deleteTodoTask,
    required UpdateTodoTask updateTodoTask,
  })  : this._retrieveAllTasks = retrieveAllTasks,
        this._deleteTodoTask = deleteTodoTask,
        this._updateTodoTask = updateTodoTask;

  // Use cases
  final RetrieveAllTasks _retrieveAllTasks;
  final DeleteTodoTask _deleteTodoTask;
  final UpdateTodoTask _updateTodoTask;

  final Rx<TodoState> _todoState = TodoState.initial.obs;
  TodoState get todoState => _todoState.value;
  void set todoState(TodoState state) => todoState = state;

  final RxList<TodoTask> _todoTasks = <TodoTask>[].obs;
  List<TodoTask> get todoTasks => _todoTasks.value;
  void set todoTasks(List<TodoTask> tasks) => _todoTasks.value = tasks;

  final Rx<String> _errorMessage = ''.obs;
  String get errorMessage => _errorMessage.value;
  void set errorMessage(String message) => errorMessage = message;

  // actions
  Future<void> retrieveAllTasks() async {
    await _loadTodoTasks();
  }

  Future<void> updateTodoTask(TodoTask task) async {
    final updateEither = await _updateTodoTask(task);
    updateEither.fold((_) async {
      await _loadTodoTasks();
    }, (failure) {
      todoState = TodoState.error;
    });
  }

  Future<void> deleteTodoTask(TodoTask task) async {
    final deleteEither = await _deleteTodoTask(task);
    deleteEither.fold((_) async {
      await _loadTodoTasks();
      todoState = TodoState.deleted;
    }, (failure) {
      todoState = TodoState.error;
    });
  }

  Future<void> _loadTodoTasks() async {
    todoState = TodoState.loading;
    final listEither = await _retrieveAllTasks();
    listEither.fold((list) {
      todoTasks = list;
      // todoTasks = _todoTasks;
      todoState = TodoState.loaded;
    }, (failure) {
      todoState = TodoState.error;
    });
  }
}
