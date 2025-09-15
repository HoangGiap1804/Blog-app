import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/auth/domain/entities/auth_entity.dart';
import 'package:share_blog/features/auth/domain/repositories/auth_repository.dart';

class LoginUsecase implements UseCase<AuthEntity, UserLoginParams> {
  final AuthRepository authRepository;
  LoginUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(UserLoginParams params) async {
    try {
      final response = await authRepository.login(
        email: params.email,
        password: params.password,
      );

      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserLoginParams {
  final String email;
  final String password;
  UserLoginParams({required this.email, required this.password});
}
