import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/user/domain/enitities/user_profile_entity.dart';
import 'package:share_blog/features/user/domain/repositories/user_repository.dart';
import 'package:fpdart/src/either.dart';

class GetCurrentUserUsecase
    implements UseCase<UserProfileEntity, UserTokenParam> {
  final UserRepository userRepository;
  GetCurrentUserUsecase({required this.userRepository});
  @override
  Future<Either<Failure, UserProfileEntity>> call(UserTokenParam params) async {
    try {
      final userProfile = await userRepository.getCurrentUserProfile(
        accessToken: params.accessToken,
      );

      return userProfile;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserTokenParam {
  final String accessToken;
  UserTokenParam({required this.accessToken});
}
