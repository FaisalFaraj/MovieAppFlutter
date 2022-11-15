import 'dart:async';

import 'package:get_it/get_it.dart';
import 'core/services/hive/hive_service.dart';
import 'core/services/hive/hive_service_impl.dart';

import 'core/data_sources/actors/actors_remote_data_source.dart';
import 'core/data_sources/movies/movies_remote_data_source.dart';
import 'core/repositories/actors_repository/actors_repository.dart';
import 'core/repositories/movies_repository/movies_repository.dart';
import 'core/services/connectivity/connectivity_service.dart';
import 'core/services/connectivity/connectivity_service_impl.dart';
import 'core/services/http/http_service.dart';
import 'core/services/http/http_service_impl.dart';
import 'core/services/navigation/navigation_service.dart';
import 'core/services/navigation/navigation_service_impl.dart';
import 'core/utils/file_helper.dart';

GetIt locator = GetIt.instance;

/// Setup function that is run before the App is run.
///   - Sets up singletons that can be called from anywhere
/// in the app by using locator<Service>() call.
///   - Also sets up factor methods for view models.

Future<void> setupLocator() async {
  // Services

  locator.registerLazySingleton<NavigationService>(
    () => NavigationServiceImpl(),
  );

  locator.registerLazySingleton<ConnectivityService>(
    () => ConnectivityServiceImpl(),
  );

  locator.registerLazySingleton<HttpService>(() => HttpServiceImpl());

  // Data sources

  locator.registerLazySingleton<MoviesRemoteDataSource>(
    () => MoviesRemoteDataSourceImpl(),
  );

  locator.registerLazySingleton<ActorsRemoteDataSource>(
    () => ActorsRemoteDataSourceImpl(),
  );

  locator.registerLazySingleton<MoviesRepository>(() => MoviesRepositoryImpl());

  locator.registerLazySingleton<ActorsRepository>(() => ActorsRepositoryImpl());

  await _setupHive();

  // Utils
  locator.registerLazySingleton<FileHelper>(() => FileHelperImpl());
}

Future<void> _setupHive() async {
  final instance = await HiveImpl.getInstance();

  locator.registerLazySingleton<HiveService>(() => instance!);
}
