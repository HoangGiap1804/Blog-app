import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/auth/domain/repositories/auth_repository.dart';

class LogoutUsecase implements UseCase<bool, UserLogoutParams> {
  final AuthRepository authRepository;
  LogoutUsecase({required this.authRepository});

  @override
  Future<Either<Failure, bool>> call(UserLogoutParams params) async {
    try {
      final response = await authRepository.logout(
        accessToken: params.accessToken,
      );

      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserLogoutParams {
  final String accessToken;
  UserLogoutParams({required this.accessToken});
}
