import 'package:to_do/features/todo/data/models/todo_task_model.dart';

abstract class TodoDataSource {
  Future<List<TodoTaskModel>> retrieveAllTasks();
  Future<void> updateTask(TodoTaskModel taskModel);
  Future<void> deleteTask(TodoTaskModel taskModel);
}

abstract class TodoRemoteDataSource extends TodoDataSource {
  @override
  Future<List<TodoTaskModel>> retrieveAllTasks();
  @override
  Future<void> updateTask(TodoTaskModel taskModel);
  @override
  Future<void> deleteTask(TodoTaskModel taskModel);
}

abstract class TodoLocalDataSource extends TodoDataSource {
  @override
  Future<List<TodoTaskModel>> retrieveAllTasks();
  @override
  Future<void> updateTask(TodoTaskModel taskModel);
  @override
  Future<void> deleteTask(TodoTaskModel taskModel);
}
