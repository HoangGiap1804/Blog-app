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
import 'package:share_blog/features/blog/data/datasources/blog_data_source.dart';
import 'package:share_blog/features/blog/data/datasources/remote/blog_api_data_source.dart';
import 'package:share_blog/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:share_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:share_blog/features/blog/domain/usecases/create_blog_usecase.dart';
import 'package:share_blog/features/blog/domain/usecases/get_blog_by_slug_usecase.dart';
import 'package:share_blog/features/blog/domain/usecases/get_list_blog_usecase.dart';
import 'package:share_blog/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:share_blog/features/user/data/data_sources/remote/user_api_data_source.dart';
import 'package:share_blog/features/user/data/data_sources/user_data_source.dart';
import 'package:share_blog/features/user/data/repositories/user_repository_impl.dart';
import 'package:share_blog/features/user/domain/repositories/user_repository.dart';
import 'package:share_blog/features/user/domain/usecases/get_current_user_usecase.dart';
import 'package:share_blog/features/user/presentation/bloc/user_bloc.dart';

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

  // Blog
  serviceLocator.registerFactory<BlogDataSource>(
    () => BlogApiDataSource(serviceLocator()),
  );
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(blogDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => CreateBlogUsecase(blogRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetBlogBySlugUsecase(blogRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetListBlogUsecase(blogRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      createBlogUsecase: serviceLocator(),
      getBlogBySlugUsecase: serviceLocator(),
      getListBlogUsecase: serviceLocator(),
    ),
  );

  // User
  serviceLocator.registerFactory<UserDataSource>(
    () => UserApiDataSource(serviceLocator()),
  );
  serviceLocator.registerFactory<UserRepository>(
    () => UserRepositoryImpl(userDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetCurrentUserUsecase(userRepository: serviceLocator()),
  );
  serviceLocator.registerLazySingleton(
    () => UserBloc(getCurrentUserUsecase: serviceLocator()),
  );
}
