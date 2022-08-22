import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:logger/logger.dart';

import 'commons/services/network/http_config.dart';
import 'commons/services/network/network_info.dart';
import 'features/todo/data/datasources/todo_data_source.dart';
import 'features/todo/data/repositories/todo_repositories_impl.dart';
import 'features/todo/domain/repositories/todo_repository.dart';
import 'features/todo/domain/usecases/add_todo_task.dart';
import 'features/todo/domain/usecases/delete_todo_task.dart';
import 'features/todo/domain/usecases/retrieve_all_tasks.dart';
import 'features/todo/domain/usecases/update_todo_task.dart';
import 'features/todo/local/datasources/todo_local_datasource.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
import 'features/todo/presentation/mobx/stores/add_todo_form_store.dart';
import 'features/todo/presentation/mobx/stores/todo_store.dart';
import 'features/todo/remote/datasources/todo_json_bin_data_source.dart';
import 'features/todo/remote/datasources/todo_remote_data_source_impl.dart';
import 'features/todo/remote/datasources/todo_retrofit_data_source.dart';

final serviceLocator = GetIt.instance;

void init() {
  //* commons
  serviceLocator.registerLazySingleton(() => Logger());
  const baseUrl = 'https://api.jsonbin.io/v3/b/62ff8caf5c146d63ca761bd0';
  final httpConfigService = HttpConfigService(
    baseUrl: baseUrl,
    logger: serviceLocator(),
  );
  serviceLocator.registerLazySingleton(() => httpConfigService);
  serviceLocator.registerLazySingleton(() => httpConfigService.appDioInstance);
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
  serviceLocator.registerLazySingleton<AddTodoTask>(
    () => AddTodoTaskImpl(
      serviceLocator(),
    ),
  );
  //* Data
  serviceLocator.registerLazySingleton<TodoJsonBinDataSource>(
    () => TodoJsonBinDataSource(
      baseUrl: baseUrl,
      dio: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoRetrofitDataSource>(
    () => TodoRetrofitDataSource(
      serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoRemoteDataSource>(
    () => TodoRemoteDataSourceImpl(
      todoRetrofitDataSource: serviceLocator(),
    ),
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
      addTodoTask: serviceLocator(),
    ),
  );
  serviceLocator.registerLazySingleton<TodoStore>(
    () => TodoStore(
      retrieveAllTasks: serviceLocator(),
      updateTodoTask: serviceLocator(),
      deleteTodoTask: serviceLocator(),
      addTodoFormStore: serviceLocator(),
      addTodoTask: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton<AddTodoFormStore>(
    () => AddTodoFormStore(),
  );
}
