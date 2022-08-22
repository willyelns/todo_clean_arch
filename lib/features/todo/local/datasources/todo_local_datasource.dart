import '../../../../commons/errors/exceptions/cache_exception.dart';
import '../../data/datasources/todo_data_source.dart';
import '../../data/models/todo_task_model.dart';

class TodoLocalDataSourceImpl implements TodoLocalDataSource {
  List<TodoTaskModel> mockData = [
    TodoTaskModel(id: '0', completed: false, name: 'primeira task'),
    TodoTaskModel(id: '1', completed: false, name: 'segunda task'),
    TodoTaskModel(id: '2', completed: true, name: 'terceira task'),
    TodoTaskModel(id: '3', completed: false, name: 'quarta task'),
    TodoTaskModel(id: '4', completed: true, name: 'quinta task'),
  ];

  @override
  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    try {
      await Future.delayed(const Duration(milliseconds: 500));
      return mockData;
    } on Object {
      throw const CacheException();
    }
  }

  @override
  Future<void> updateTask(TodoTaskModel taskModel) async {
    try {
      final index =
          mockData.indexWhere((element) => element.id == taskModel.id);
      mockData.removeAt(index);
      mockData.insert(index, taskModel);
    } on Object {
      throw const CacheException();
    }
  }

  @override
  Future<void> deleteTask(TodoTaskModel taskModel) async {
    try {
      mockData.removeWhere((element) => element == taskModel);
    } on Object {
      throw const CacheException();
    }
  }

  @override
  Future<void> addTask(TodoTaskModel taskModel) async {
    try {
      mockData.add(taskModel);
    } on Object {
      throw const CacheException();
    }
  }
}
