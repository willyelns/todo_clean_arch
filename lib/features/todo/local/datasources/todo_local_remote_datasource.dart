import 'package:to_do/commons/errors/exceptions/cache_exception.dart';
import 'package:to_do/features/todo/data/datasources/todo_data_source.dart';
import 'package:to_do/features/todo/data/models/todo_task_model.dart';

final mockData = [
  TodoTaskModel(id: "0", completed: false, name: "primeira task"),
  TodoTaskModel(id: "1", completed: false, name: "segunda task"),
  TodoTaskModel(id: "2", completed: true, name: "terceira task"),
  TodoTaskModel(id: "3", completed: false, name: "quarta task"),
  TodoTaskModel(id: "4", completed: true, name: "quinta task"),
];

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  @override
  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    try {
      Future.delayed(Duration(seconds: 1));
      return mockData;
    } catch (e) {
      throw CacheException();
    }
  }
}
