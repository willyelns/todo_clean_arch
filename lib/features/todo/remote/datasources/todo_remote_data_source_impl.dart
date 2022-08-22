import '../../../../commons/base/remote_datasource.dart';
import '../../data/datasources/todo_data_source.dart';
import '../../data/models/todo_task_model.dart';
import 'todo_json_bin_data_source.dart';
// import 'todo_retrofit_data_source.dart';

class TodoRemoteDataSourceImpl extends RemoteDataSource
    implements TodoRemoteDataSource {
  TodoRemoteDataSourceImpl({required this.todoRetrofitDataSource});

  // final TodoRetrofitDataSource todoRetrofitDataSource;
  final TodoJsonBinDataSource todoRetrofitDataSource;

  @override
  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    return handleException(
      todoRetrofitDataSource.retrieveAllTasks,
      errorMessage: 'Failed to retrieve all tasks',
    );
  }

  @override
  Future<void> updateTask(TodoTaskModel taskModel) async {
    return handleException(
      () => todoRetrofitDataSource.updateTask(taskModel.id, taskModel),
      errorMessage: 'Error updating task',
    );
  }

  @override
  Future<void> deleteTask(TodoTaskModel taskModel) async {
    return handleException(
      () => todoRetrofitDataSource.deleteTask(taskModel.id),
      errorMessage: 'Error deleting task',
    );
  }

  @override
  Future<void> addTask(TodoTaskModel taskModel) async {
    return handleException(
      () => todoRetrofitDataSource.addTask(taskModel),
      errorMessage: 'Error to adding task',
    );
  }
}
