import 'package:to_do/features/todo/data/models/todo_task_model.dart';

abstract class TodoDataSource {
  Future<List<TodoTaskModel>> retrieveAllTasks();
}

abstract class TodoRemoteDataSource extends TodoDataSource {
  @override
  Future<List<TodoTaskModel>> retrieveAllTasks();
}

abstract class TodoLocalDataSource extends TodoDataSource {
  @override
  Future<List<TodoTaskModel>> retrieveAllTasks();
}
