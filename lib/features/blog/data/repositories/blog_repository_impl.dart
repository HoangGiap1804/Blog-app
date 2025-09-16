import 'dart:io';

import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/blog/data/datasources/blog_data_source.dart';
import 'package:share_blog/features/blog/data/models/author_model.dart';
import 'package:share_blog/features/blog/data/models/banner_model.dart';
import 'package:share_blog/features/blog/domain/entities/blog_entity.dart';
import 'package:share_blog/features/blog/domain/repositories/blog_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class BlogRepositoryImpl implements BlogRepository {
  final BlogDataSource blogDataSource;
  BlogRepositoryImpl({required this.blogDataSource});

  @override
  Future<Either<Failure, BlogEntity>> createBlog({
    required String title,
    required String content,
    required String status,
    required String accessToken,
    required File bannerImage,
  }) async {
    try {
      final response = await blogDataSource.createBlog(
        title,
        content,
        status,
        bannerImage,
        "Bearer $accessToken",
      );

      AuthorModel? authorModel = response.authorModel;
      BannerModel? bannerModel = response.bannerModel;

      BlogEntity blogEntity = BlogEntity(
        id: response.id,
        title: response.title,
        content: response.content,
        status: response.status,
        bannerUrl: (bannerModel != null) ? bannerModel.url : "",
        width: (bannerModel != null) ? bannerModel.width : 0,
        height: (bannerModel != null) ? bannerModel.height : 0,
        idAuth: (authorModel != null) ? authorModel.authorId : "",
        userName: (authorModel != null) ? authorModel.authorId : "",
        viewsCount: response.viewsCount,
        likesCount: response.likesCount,
        commentCount: response.commentCount,
        slug: response.slug,
        publishedAt: response.publishedAt,
        updateAt: response.updateAt,
      );

      return right(blogEntity);
    } on DioException catch (e) {
      String error = '';
      if (e.response != null) {
        final statusCode = e.response?.statusCode;
        final data = e.response?.data;
        if (statusCode == 404) {
          error = "Không tìm thấy API (404): $data";
        } else if (statusCode == 403) {
          error = "Bị từ chối truy cập (403): $data";
        } else {
          error = "Lỗi server ($statusCode): $data";
        }
      } else {
        // Trường hợp không kết nối được server
        print("Network Error: ${e.message}");
      }
      return left(Failure(message: error));
    }
  }
}
