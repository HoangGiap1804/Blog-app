import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/comment/data/datasources/comment_data_source.dart';
import 'package:share_blog/features/comment/data/models/comment_model.dart';
import 'package:share_blog/features/comment/domain/entities/comment_entity.dart';
import 'package:share_blog/features/comment/domain/repositories/comment_repository.dart';

class CommentRepositoryImpl implements CommentRepository {
  CommentDataSource commentDataSource;

  CommentRepositoryImpl({required this.commentDataSource});

  @override
  Future<Either<Failure, CommentEntity>> createComment({
    required String blogId,
    required String accessToken,
    required String comment,
  }) async {
    try {
      final commentResponse = await commentDataSource.createComment(
        blogId,
        "Bearer $accessToken",
        {"comment": comment},
      );
      final commentModel = commentResponse.comment;

      final commentEntity = CommentEntity(
        commentId: commentModel.commentId,
        blogId: commentModel.blogId,
        userId: commentModel.userId,
        commnent: commentModel.commnent,
      );

      return right(commentEntity);
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
  Future<Either<Failure, List<CommentEntity>>> getListCommentOfBlog({
    required String blogId,
    required String accessToken,
  }) async {
    try {
      final commentResponse = await commentDataSource.getListCommentOfBlog(
        blogId,
        "Bearer $accessToken",
      );

      List<CommentEntity> listComments = [];

      for (CommentModel commentModel in commentResponse.comments) {
        final commentEntity = CommentEntity(
          commentId: commentModel.commentId,
          blogId: commentModel.blogId,
          userId: commentModel.userId,
          commnent: commentModel.commnent,
        );
        listComments.add(commentEntity);
      }

      return right(listComments);
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
  Future<Either<Failure, bool>> deleteComment({
    required String commentId,
    required String accessToken,
  }) async {
    try {
      final response = await commentDataSource.deleteComment(
        commentId,
        "Bearer $accessToken",
      );

      final statusCode = response.response.statusCode;
      if (statusCode == 204)
        return right(true);
      else
        return right(false);
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
