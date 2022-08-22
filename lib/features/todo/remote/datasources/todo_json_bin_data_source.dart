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

  final List<TodoTaskModel> _cachedList = [];

  Future<List<TodoTaskModel>> retrieveAllTasks() async {
    final response = await _dio.get(_baseUrl);
    final data = response.data as List<dynamic>;

    final serverList =
        data.map((json) => TodoTaskModel.fromJson(json as JsonData)).toList();
    _cachedList.clear();
    _cachedList.addAll(serverList);

    return _cachedList;
  }

  Future<void> updateTask(String id, TodoTaskModel taskModel) async {
    final index = _cachedList.indexWhere((element) => element.id == id);
    _cachedList.removeAt(index);
    _cachedList.insert(index, taskModel);
    return _updateServerList();
  }

  Future<void> deleteTask(String id) async {
    _cachedList.removeWhere((element) => element.id == id);
    return _updateServerList();
  }

  Future<void> addTask(TodoTaskModel taskModel) async {
    _cachedList.add(taskModel);
    return _updateServerList();
  }

  Future<void> _updateServerList() async {
    final jsonData = _cachedList.map((task) => task.toJson()).toList();
    await _dio.put(_baseUrl, data: jsonData);
  }
}
