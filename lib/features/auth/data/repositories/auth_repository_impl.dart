import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/auth/data/datasources/auth_data_source.dart';
import 'package:share_blog/features/auth/data/models/auth_response_model.dart';
import 'package:share_blog/features/auth/domain/entities/auth_entity.dart';
import 'package:share_blog/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource authDataSource;
  AuthRepositoryImpl({required this.authDataSource});

  @override
  Future<Either<Failure, AuthEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String role,
  }) async {
    try {
      AuthResponseModel authResponseModel = await authDataSource
          .signUpWithEmail({
            "email": email,
            "password": password,
            "role": role,
          });

      final authModel = authResponseModel.user;

      if (authModel == null) {
        return left(Failure(message: "User null"));
      }

      return right(
        AuthEntity(
          email: authModel.email,
          username: authModel.username,
          role: authModel.role,
          accessToken: authResponseModel.accessToken,
        ),
      );
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
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      AuthResponseModel authResponseModel = await authDataSource.login({
        "email": email,
        "password": password,
      });

      final authModel = authResponseModel.user;

      if (authModel == null) {
        return left(Failure(message: "User null"));
      }

      return right(
        AuthEntity(
          email: authModel.email,
          username: authModel.username,
          role: authModel.role,
          accessToken: authResponseModel.accessToken,
          refreshToken: authResponseModel.refreshToken,
        ),
      );
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
  Future<Either<Failure, AuthEntity>> refreshToken({
    required String refreshToken,
  }) async {
    try {
      AuthResponseModel authResponseModel = await authDataSource.refreshToken({
        "refreshToken": refreshToken,
      });

      String? accessToken = authResponseModel.accessToken;
      if (accessToken == null) {
        return left(Failure(message: "Access token null"));
      }

      return right(AuthEntity(accessToken: accessToken));
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
  Future<Either<Failure, bool>> logout({required String accessToken}) async {
    try {
      final res = await authDataSource.logout("Bearer $accessToken");

      if (res.response.statusCode == 204) {
        return right(true);
      } else {
        return left(Failure(message: "User can not logout"));
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
