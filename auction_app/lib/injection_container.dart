// ignore_for_file: import_of_legacy_library_into_null_safe

import 'package:auction_app/feature/data/homepage_datasource.dart';
import 'package:auction_app/feature/domain/usecases/homepage_usecase.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:auction_app/core/network/network_info.dart';
import 'package:auction_app/core/repository/homepage_repository_impl.dart';
import 'package:auction_app/feature/domain/repository/homepage_repository.dart';
import 'package:auction_app/utils/config/constant_config.dart';
import 'package:auction_app/utils/config/flavor_config.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc

  // Use cases

  sl.registerLazySingleton(() => HomePageUseCase(homepageRepository: sl()));

  // Repository
  sl.registerLazySingleton<HomepageRepository>(() =>
      HomePageRepositoryImpl(loginRemoteDataSource: sl(), networkInfo: sl()));

  // Data sources
  sl.registerLazySingleton<HomePageRemoteDataSource>(
      () => LoginRemoteDataSourceImpl(dio: sl(), constantConfig: sl()));

  //! Core

  /**
   * ! Core
   */
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External

  sl.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = FlavorConfig.instance!.values.baseUrl;
    // dio.interceptors.add(DioLoggingInterceptor());
    return dio;
  });

  sl.registerLazySingleton(() => ConstantConfig());
  sl.registerLazySingleton(() => DataConnectionChecker());
}
