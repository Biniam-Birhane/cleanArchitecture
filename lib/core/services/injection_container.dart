import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:industry/src/features/authentication/data/datasources/authentication_remote_data_source.dart';
import 'package:industry/src/features/authentication/data/repositories/authentication_repository_imp.dart';
import 'package:industry/src/features/authentication/domain/repositories/authentication_repository.dart';
import 'package:industry/src/features/authentication/domain/usecases/create_user.dart';
import 'package:industry/src/features/authentication/domain/usecases/get_user.dart';
import 'package:industry/src/features/authentication/presentation/bloc/authentication_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl
    //App logic
    ..registerFactory(() => AuthenticationBloc(
          createUser: sl(),
          getUser: sl(),
        ))

    //Usecases
    ..registerLazySingleton(() => CreateUser(sl()))
    ..registerLazySingleton(() => GetUsers(sl()))

    //Repositories
    ..registerLazySingleton<AuthenticationRepository>(
        () => AuthenticationRepositoryImp(sl()))

    //Datasource
    ..registerLazySingleton<AuthenticationRemoteDataSource>(
        () => AuthenticationRemoteDataSourceImp())

    //External dependency
    ..registerLazySingleton(Dio.new);
}
