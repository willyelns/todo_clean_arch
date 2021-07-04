import 'package:to_do/commons/errors/exceptions/server_exception.dart';
import 'package:to_do/features/todo/data/datasources/todo_data_source.dart';
import 'package:to_do/features/todo/data/models/todo_task_model.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  @override
  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    Future.delayed(Duration(seconds: 2));
    throw ServerException();
  }
}
