import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import 'commons/services/network/network_info.dart';
import 'features/todo/data/datasources/todo_data_source.dart';
import 'features/todo/data/repositories/todo_repositories_impl.dart';
import 'features/todo/domain/repositories/todo_repositoy.dart';
import 'features/todo/domain/usecases/retrieve_all_tasks.dart';
import 'features/todo/local/datasources/todo_local_remote_datasource.dart';
import 'features/todo/presentation/bloc/todo_bloc.dart';
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
    ),
  );
}
