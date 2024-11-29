
import 'package:get_it/get_it.dart';
import 'package:task_management/data/repositories/auth_repository.dart';
import 'package:task_management/data/repositories/task_repository.dart';
import 'package:task_management/data/services/auth_service.dart';
import 'package:task_management/data/services/task_service.dart';
import 'package:task_management/presentation/auth/blocs/auth_bloc.dart';
import 'package:task_management/presentation/task/blocs/task_bloc.dart';

import 'data/services/local_storage_service.dart';

final sl = GetIt.instance;

Future initServiceLocator() async {
     /// SERVICES
  var instance = await LocalStorageService.getInstance();
  sl.registerSingleton<LocalStorageService>(instance);
  sl.registerLazySingleton<AuthService>(() => AuthService());
  sl.registerLazySingleton<TaskService>(()=>TaskService());

   /// REPOSITORIES
  sl.registerFactory<AuthRepository>(() => AuthRepositoryImpl(authService: sl()));
  sl.registerFactory<TaskRepository>(()=>TaskRepositoryImpl(taskService: sl()));


   /// BLOCS
  sl.registerLazySingleton<AuthBloc>(() => AuthBloc(authRepository: sl()));
  sl.registerLazySingleton<TaskBloc>(()=>TaskBloc(taskRepository: sl()));

}