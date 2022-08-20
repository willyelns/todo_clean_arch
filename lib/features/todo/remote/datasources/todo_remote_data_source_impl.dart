import '../../../../commons/errors/exceptions/server_exception.dart';
import '../../data/datasources/todo_data_source.dart';
import '../../data/models/todo_task_model.dart';
import 'todo_retrofit_data_source.dart';

class TodoRemoteDataSourceImpl implements TodoRemoteDataSource {
  const TodoRemoteDataSourceImpl({required this.todoRetrofitDataSource});

  final TodoRetrofitDataSource todoRetrofitDataSource;

  @override
  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    try {
      final list = await todoRetrofitDataSource.retrieveAllTasks();
      return list;
    } on Object {
      throw const ServerException();
    }
  }

  @override
  Future<void> updateTask(TodoTaskModel taskModel) async {
    try {
      await todoRetrofitDataSource.updateTask(taskModel.id, taskModel);
    } on Object {
      throw const ServerException();
    }
  }

  @override
  Future<void> deleteTask(TodoTaskModel taskModel) async {
    try {
      await todoRetrofitDataSource.deleteTask(taskModel.id);
    } on Object {
      throw const ServerException();
    }
  }

  @override
  Future<void> addTask(TodoTaskModel taskModel) async {
    try {
      await todoRetrofitDataSource.addTask(taskModel);
    } on Object {
      throw const ServerException();
    }
  }
}
