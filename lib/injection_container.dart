import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:to_do/features/todo/domain/usecases/update_todo_task.dart';
import 'package:to_do/features/todo/presentation/stores/todo_store.dart';

import 'commons/services/network/network_info.dart';
import 'features/todo/data/datasources/todo_data_source.dart';
import 'features/todo/data/repositories/todo_repositories_impl.dart';
import 'features/todo/domain/repositories/todo_repositoy.dart';
import 'features/todo/domain/usecases/delete_todo_task.dart';
import 'features/todo/domain/usecases/retrieve_all_tasks.dart';
import 'features/todo/local/datasources/todo_local_datasource.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/getx/controllers/todo_controller.dart';
import 'features/todo/remote/datasources/todo_remote_data_source_impl.dart';

final serviceLocator = GetIt.instance;

void init() {
  //* commons
  serviceLocator.registerLazySingleton(() => InternetConnectionChecker());
  serviceLocator.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(
      connectionChecker: serviceLocator(),
    ),
  );

  //* Domain
  serviceLocator.registerLazySingleton<RetrieveAllTasks>(
    () => RetrieveAllTasksImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<UpdateTodoTask>(
    () => UpdateTodoTaskImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<DeleteTodoTask>(
    () => DeleteTodoTaskImpl(
      serviceLocator(),
    ),
  );
  //* Data
  serviceLocator.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<TodoLocalDataSource>(
    () => TodoLocalDataSourceImpl(),
  );
  serviceLocator.registerLazySingleton<TodoRepository>(
    () => TodoRepositoryImpl(
      networkInfo: serviceLocator(),
      remoteDataSource: serviceLocator(),
      localDataSource: serviceLocator(),
    ),
  );

  //* Presentation
  serviceLocator.registerLazySingleton<TodoBloc>(
    () => TodoBloc(
      retrieveAllTasks: serviceLocator(),
      updateTodoTask: serviceLocator(),
      deleteTodoTask: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoStore>(
    () => TodoStore(
      retrieveAllTasks: serviceLocator(),
      updateTodoTask: serviceLocator(),
      deleteTodoTask: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoController>(
    () => TodoController(
      retrieveAllTasks: serviceLocator<RetrieveAllTasks>(),
      deleteTodoTask: serviceLocator<DeleteTodoTask>(),
      updateTodoTask: serviceLocator<UpdateTodoTask>(),
    ),
  );
}
