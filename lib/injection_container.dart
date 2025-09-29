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
import 'package:share_blog/features/comment/data/datasources/comment_data_source.dart';
import 'package:share_blog/features/comment/data/datasources/remote/comment_api_data_source.dart';
import 'package:share_blog/features/comment/data/repositories/comment_repository_impl.dart';
import 'package:share_blog/features/comment/domain/repositories/comment_repository.dart';
import 'package:share_blog/features/comment/domain/usecases/create_comment_usecase.dart';
import 'package:share_blog/features/comment/domain/usecases/delete_comment_usecase.dart';
import 'package:share_blog/features/comment/domain/usecases/get_list_comments_usecase.dart';
import 'package:share_blog/features/comment/presentation/bloc/comment_bloc.dart';
import 'package:share_blog/features/like/data/repositories/like_repository_impl.dart';
import 'package:share_blog/features/like/data/sources/like_data_source.dart';
import 'package:share_blog/features/like/data/sources/remote/like_api_data_source.dart';
import 'package:share_blog/features/like/domain/repositories/like_repository.dart';
import 'package:share_blog/features/like/domain/usecases/like_blog_usecase.dart';
import 'package:share_blog/features/like/domain/usecases/unlike_blog_usecase.dart';
import 'package:share_blog/features/like/presentation/bloc/like_bloc.dart';
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

  // Comment
  serviceLocator.registerFactory<CommentDataSource>(
    () => CommentApiDataSource(serviceLocator()),
  );
  serviceLocator.registerFactory<CommentRepository>(
    () => CommentRepositoryImpl(commentDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => CreateCommentUsecase(commentRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => GetListCommentsUsecase(commentRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => DeleteCommentUsecase(commentRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => CommentBloc(
      commentUsecase: serviceLocator(),
      getListCommentsUsecase: serviceLocator(),
      deleteCommentUsecase: serviceLocator(),
    ),
  );

  // Like
  serviceLocator.registerFactory<LikeDataSource>(
    () => LikeApiDataSource(serviceLocator()),
  );
  serviceLocator.registerFactory<LikeRepository>(
    () => LikeRepositoryImpl(likeDataSource: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => LikeBlogUsecase(likeRepository: serviceLocator()),
  );
  serviceLocator.registerFactory(
    () => UnlikeBlogUsecase(likeRepository: serviceLocator()),
  );

  serviceLocator.registerLazySingleton(
    () => LikeBloc(
      likeBlogUsecase: serviceLocator(),
      unlikeBlogUsecase: serviceLocator(),
    ),
  );
}
