import 'dart:io';

import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class BlogRepository {
  Future<Either<Failure, BlogEntity>> createBlog({
    required String title,
    required String content,
    required String status,
    required String accessToken,
    required File bannerImage,
  });

  Future<Either<Failure, BlogEntity>> getBlogBySlug({
    required String slug,
    required String accessToken,
  });

  Future<Either<Failure, List<BlogEntity>>> getListBlog({
    required int limit,
    required int offset,
    required String accessToken,
  });
}
