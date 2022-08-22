import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import '../../data/models/todo_task_model.dart';

part 'todo_retrofit_data_source.g.dart';

abstract class TodoRetrofitDataSource {
  factory TodoRetrofitDataSource(Dio dio, {String? baseUrl}) =
      _TodoRetrofitDataSource;

  @GET('/tasks')
  Future<List<TodoTaskModel>> retrieveAllTasks();

  @PUT('/tasks/{id}')
  Future<void> updateTask(@Path() String id, @Body() TodoTaskModel taskModel);

  @DELETE('/tasks/{id}')
  Future<void> deleteTask(@Path() String id);

  @POST('/tasks/')
  Future<void> addTask(@Body() TodoTaskModel taskModel);
}
