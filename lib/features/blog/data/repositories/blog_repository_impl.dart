import 'dart:io';

import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/blog/data/datasources/blog_data_source.dart';
import 'package:share_blog/features/blog/data/models/author_model.dart';
import 'package:share_blog/features/blog/data/models/banner_model.dart';
import 'package:share_blog/features/blog/data/models/blog_model.dart';
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

      if (response.blogModel == null) {
        return left(Failure(message: "Blog null"));
      }

      return right(response.blogModel!.toEntity());
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

  @override
  Future<Either<Failure, BlogEntity>> getBlogBySlug({
    required String slug,
    required String accessToken,
  }) async {
    try {
      final response = await blogDataSource.getBlogBySlug(
        slug,
        "Bearer $accessToken",
      );
      if (response.blogModel == null) {
        return left(Failure(message: "Blog null"));
      }

      return right(response.blogModel!.toEntity());
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

  @override
  Future<Either<Failure, List<BlogEntity>>> getListBlog({
    required int limit,
    required int offset,
    required String accessToken,
  }) async {
    try {
      final response = await blogDataSource.getListBlog(
        limit,
        offset,
        "Bearer $accessToken",
      );

      List<BlogEntity> listBlog = [];

      for (BlogModel blog in response.listBlog) {
        listBlog.add(blog.toEntity());
      }

      return right(listBlog);
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
