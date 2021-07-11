import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/commons/services/network/network_info.dart';
import 'package:to_do/features/todo/data/datasources/todo_data_source.dart';
import 'package:to_do/features/todo/data/repositories/todo_repositories_impl.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repositoy.dart';
import 'package:to_do/features/todo/domain/usecases/delete_todo_task.dart';
import 'package:to_do/features/todo/domain/usecases/retrieve_all_tasks.dart';
import 'package:to_do/features/todo/domain/usecases/update_todo_task.dart';
import 'package:to_do/features/todo/local/datasources/todo_local_datasource.dart';
import 'package:to_do/features/todo/presentation/getx/controllers/todo_controller.dart';
import 'package:to_do/features/todo/remote/datasources/todo_remote_data_source_impl.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    //* Commons
    Get.lazyPut(() => InternetConnectionChecker());
    Get.lazyPut<NetworkInfo>(
      () => NetworkInfoImpl(
        connectionChecker: Get.find<InternetConnectionChecker>(),
      ),
    );
    //* Domain
    Get.lazyPut<RetrieveAllTasks>(
      () => RetrieveAllTasksImpl(
        Get.find<TodoRepository>(),
      ),
    );
    Get.lazyPut<UpdateTodoTask>(
      () => UpdateTodoTaskImpl(
        Get.find<TodoRepository>(),
      ),
    );
    Get.lazyPut<DeleteTodoTask>(
      () => DeleteTodoTaskImpl(
        Get.find<TodoRepository>(),
      ),
    );
    //* Data
    Get.lazyPut<TodoRemoteDataSource>(
      () => TodoRemoteDataSourceImpl(),
    );
    Get.lazyPut<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(),
    );
    Get.lazyPut<TodoRepository>(
      () => TodoRepositoryImpl(
        networkInfo: Get.find<NetworkInfo>(),
        remoteDataSource: Get.find<TodoRemoteDataSource>(),
        localDataSource: Get.find<TodoLocalDataSource>(),
      ),
    );
    //* Controllers - Presentation
    Get.lazyPut<TodoController>(
      () => TodoController(
        retrieveAllTasks: Get.find<RetrieveAllTasks>(),
        deleteTodoTask: Get.find<DeleteTodoTask>(),
        updateTodoTask: Get.find<UpdateTodoTask>(),
      ),
    );
  }
}
