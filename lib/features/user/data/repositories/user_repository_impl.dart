import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/user/data/data_sources/user_data_source.dart';
import 'package:share_blog/features/user/data/models/user_profile_model.dart';
import 'package:share_blog/features/user/data/models/user_response_model.dart';
import 'package:share_blog/features/user/domain/enitities/user_profile_entity.dart';
import 'package:share_blog/features/user/domain/repositories/user_repository.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/src/either.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  UserRepositoryImpl({required this.userDataSource});

  @override
  Future<Either<Failure, UserProfileEntity>> getCurrentUserProfile({
    required String accessToken,
  }) async {
    try {
      UserResponseModel userResponse = await userDataSource
          .getCurrentUserProfile("Bearer $accessToken");

      UserProfileModel userProfileModel = userResponse.user;

      final socialLinks = userProfileModel.socialLinksModel;
      print(userProfileModel.toJson());
      final userProfile = UserProfileEntity(
        id: userProfileModel.id,
        username: userProfileModel.username,
        role: userProfileModel.role,
        email: userProfileModel.email,
        firstName: userProfileModel.firstName,
        lastName: userProfileModel.lastName,
        webSite: (socialLinks != null) ? socialLinks.website : null,
        facebook: (socialLinks != null) ? socialLinks.facebook : null,
        instagram: (socialLinks != null) ? socialLinks.instagram : null,
        x: (socialLinks != null) ? socialLinks.x : null,
        youtube: (socialLinks != null) ? socialLinks.youtube : null,
      );

      return right(userProfile);
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
