import 'package:retrofit/retrofit.dart';
import 'package:to_do/features/todo/data/models/todo_task_model.dart';
import 'package:dio/dio.dart';

part 'todo_retrofit_data_source.g.dart';

@RestApi(baseUrl: "http://localhost:3000/")
abstract class TodoRetrofitDataSource {
  factory TodoRetrofitDataSource(Dio dio, {String? baseUrl}) =
      _TodoRetrofitDataSource;

  @GET("/tasks")
  Future<List<TodoTaskModel>> retrieveAllTasks();

  @PUT("/tasks/{id}")
  Future<void> updateTask(@Path() String id, @Body() TodoTaskModel taskModel);

  @DELETE("/tasks/{id}")
  Future<void> deleteTask(@Path() String id);

  @POST("/tasks/")
  Future<void> addTask(@Body() TodoTaskModel taskModel);
}
