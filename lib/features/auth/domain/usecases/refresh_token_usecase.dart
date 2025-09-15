import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/auth/domain/entities/auth_entity.dart';
import 'package:share_blog/features/auth/domain/repositories/auth_repository.dart';

class RefreshTokenUsecase implements UseCase<AuthEntity, UserRefreshParams> {
  final AuthRepository authRepository;
  RefreshTokenUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(UserRefreshParams params) async {
    try {
      final response = await authRepository.refreshToken(
        refreshToken: params.refreshToken,
      );

      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserRefreshParams {
  final String refreshToken;
  UserRefreshParams({required this.refreshToken});
}
