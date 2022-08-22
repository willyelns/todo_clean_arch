import 'package:dio/dio.dart';
import '../../../../commons/types/json_data.dart';
import '../../data/models/todo_task_model.dart';

class TodoJsonBinDataSource {
  TodoJsonBinDataSource({
    required Dio dio,
    required String baseUrl,
  })  : _dio = dio,
        _baseUrl = baseUrl;

  final Dio _dio;
  final String _baseUrl;

  final List<TodoTaskModel> _tempList = [];

  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    final response = await _dio.get(_baseUrl);
    final data = response.data as List<dynamic>;

    data.map((json) => _tempList.add(TodoTaskModel.fromJson(json as JsonData)));

    return _tempList;
  }

  Future<void> updateTask(String id, TodoTaskModel taskModel) async {
    final index = _tempList.indexWhere((element) => element.id == id);
    _tempList.removeAt(index);
    _tempList.insert(index, taskModel);
    return _updateServerList();
  }

  Future<void> deleteTask(String id) async {
    _tempList.removeWhere((element) => element.id == id);
    return _updateServerList();
  }

  Future<void> addTask(TodoTaskModel taskModel) async {
    _tempList.add(taskModel);
    return _updateServerList();
  }

  Future<void> _updateServerList() async {
    final jsonData = _tempList.map((task) => task.toJson()).toList();
    await _dio.put(_baseUrl, data: jsonData);
  }
}
