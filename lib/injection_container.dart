import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:share_blog/features/auth/data/datasources/auth_data_source.dart';
import 'package:share_blog/features/auth/data/datasources/remote/auth_api_data_source.dart';
import 'package:share_blog/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:share_blog/features/auth/domain/repositories/auth_repository.dart';
import 'package:share_blog/features/auth/domain/usecases/login_usecase.dart';
import 'package:share_blog/features/auth/domain/usecases/logout_usecase.dart';
import 'package:share_blog/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:share_blog/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:share_blog/features/auth/presentation/bloc/auth_bloc.dart';

final serviceLocator = GetIt.instance;
Future<void> initializeDependencies() async {
  serviceLocator.registerLazySingleton(() => Dio());

  // Auth
  serviceLocator.registerFactory<AuthDataSource>(
    () => AuthApiDataSource(serviceLocator()),
  );

  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoryImpl(authDataSource: serviceLocator()),
  );

  // Auth Usecase
  serviceLocator.registerFactory(
    () => SignUpUsecase(authRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LoginUsecase(authRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => RefreshTokenUsecase(authRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LogoutUsecase(authRepository: serviceLocator()),
  );

  // Authentication bloc
  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      signUpUsecase: serviceLocator(),
      loginUsecase: serviceLocator(),
      refreshTokenUsecase: serviceLocator(),
      logoutUsecase: serviceLocator(),
    ),
  );
}
