import 'package:to_do/commons/errors/exceptions/server_exception.dart';
import 'package:to_do/features/todo/data/datasources/todo_data_source.dart';
import 'package:to_do/features/todo/data/models/todo_task_model.dart';
import 'package:to_do/features/todo/remote/datasources/todo_retrofit_data_source.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  const TodoRemoteDataSourceImpl({required this.todoRetrofitDataSource});

  final TodoRetrofitDataSource todoRetrofitDataSource;

  @override
  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    try {
      final list = await todoRetrofitDataSource.retrieveAllTasks();
      return list;
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> updateTask(TodoTaskModel taskModel) async {
    try {
      todoRetrofitDataSource.updateTask(taskModel.id, taskModel);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> deleteTask(TodoTaskModel taskModel) async {
    try {
      todoRetrofitDataSource.deleteTask(taskModel.id);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<void> addTask(TodoTaskModel taskModel) async {
    try {
      todoRetrofitDataSource.addTask(taskModel);
    } catch (e) {
      throw ServerException();
    }
  }
}
