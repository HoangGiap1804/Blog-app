import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/user/domain/enitities/user_profile_entity.dart';
import 'package:fpdart/fpdart.dart';

abstract interface class UserRepository {
  Future<Either<Failure, UserProfileEntity>> getCurrentUserProfile({
    required String accessToken,
  });
}
