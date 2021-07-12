import 'package:to_do/commons/errors/exceptions/cache_exception.dart';
import 'package:to_do/features/todo/data/datasources/todo_data_source.dart';
import 'package:to_do/features/todo/data/models/todo_task_model.dart';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  List<TodoTaskModel> mockData = [
    TodoTaskModel(id: "0", completed: false, name: "primeira task"),
    TodoTaskModel(id: "1", completed: false, name: "segunda task"),
    TodoTaskModel(id: "2", completed: true, name: "terceira task"),
    TodoTaskModel(id: "3", completed: false, name: "quarta task"),
    TodoTaskModel(id: "4", completed: true, name: "quinta task"),
  ];

  @override
  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    try {
      await Future.delayed(Duration(seconds: 1));
      return mockData;
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> updateTask(TodoTaskModel taskModel) async {
    try {
      final index =
          mockData.indexWhere((element) => element.id == taskModel.id);
      mockData.removeAt(index);
      mockData.insert(index, taskModel);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> deleteTask(TodoTaskModel taskModel) async {
    try {
      mockData.removeWhere((element) => element == taskModel);
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> addTask(TodoTaskModel taskModel) async {
    try {
      final where = mockData.length - 1;
      mockData.insert(where, taskModel);
    } catch (e) {
      throw CacheException();
    }
  }
}
