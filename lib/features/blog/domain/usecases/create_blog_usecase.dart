import 'dart:io';

import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/src/either.dart';

class CreateBlogUsecase implements UseCase<BlogEntity, UserCreateBlogParams> {
  final BlogRepository blogRepository;
  CreateBlogUsecase({required this.blogRepository});

  @override
  Future<Either<Failure, BlogEntity>> call(UserCreateBlogParams params) async {
    try {
      final res = await blogRepository.createBlog(
        title: params.title,
        content: params.content,
        status: params.status,
        accessToken: params.accessToken,
        bannerImage: params.bannerImge,
      );

      return res;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserCreateBlogParams {
  final String title;
  final String content;
  final String status;
  final String accessToken;
  final File bannerImge;
  UserCreateBlogParams({
    required this.title,
    required this.content,
    required this.status,
    required this.accessToken,
    required this.bannerImge,
  });
}
