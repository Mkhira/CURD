import 'package:curd/domain/use_case/login_use_case.dart';
import 'package:curd/view/login/login_cubit.dart';
import 'package:curd/view/register/register_cuibt_cubit.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import 'data/app_api.dart';
import 'data/data_source/reomte_data_source.dart';
import 'data/dio_factory.dart';
import 'data/repository/repository.dart';
import 'domain/use_case/register_use_case.dart';

final injector = GetIt.instance;

Future setUpInjector() async {
  //Infrastructure
  injector.registerLazySingleton<Dio>(() => Dio());
  injector.registerLazySingleton<DioFactory>(() => DioFactory());
  final dio = await injector<DioFactory>().getDio();

  injector.registerLazySingleton<AppServiceClient>(() => AppServiceClient(dio));
  injector.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImplementer(injector()));
  injector.registerLazySingleton<Repository>(() => RepositoryImpl(injector()));
  injector.registerLazySingleton<RegisterUseCase>(() => RegisterUseCase(injector()));
  injector.registerLazySingleton<LoginUseCase>(() => LoginUseCase(injector()));

  injector.registerLazySingleton<RegisterCubit>(() => RegisterCubit(injector()));
  injector.registerLazySingleton<LoginCubit>(() => LoginCubit(injector()));
}
