import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/like/data/sources/like_data_source.dart';
import 'package:share_blog/features/like/domain/repositories/like_repository.dart';

class LikeRepositoryImpl implements LikeRepository {
  final LikeDataSource likeDataSource;

  LikeRepositoryImpl({required this.likeDataSource});

  @override
  Future<Either<Failure, bool>> likeRespository({
    required String blogId,
    required String accessToken,
  }) async {
    try {
      final response = await likeDataSource.likeBlog(
        blogId,
        "Bearer $accessToken",
      );

      final statusCode = response.response.statusCode;
      if (statusCode == 200) {
        return right(true);
      } else if (statusCode == 400) {
        return left(Failure(message: "You already like this blog"));
      } else {
        return left(Failure(message: "Loi"));
      }
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
  Future<Either<Failure, bool>> unLikeRespository({
    required String blogId,
    required String accessToken,
  }) async {
    try {
      final response = await likeDataSource.unLikeBlog(
        blogId,
        "Bearer $accessToken",
      );

      final statusCode = response.response.statusCode;
      if (statusCode == 204) {
        return right(true);
      } else if (statusCode == 404) {
        return left(Failure(message: "Like not found"));
      } else {
        return left(Failure(message: "Loi"));
      }
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
