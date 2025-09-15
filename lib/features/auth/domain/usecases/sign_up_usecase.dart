import 'package:fpdart/src/either.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/core/usecases/usecase.dart';
import 'package:share_blog/features/auth/domain/entities/auth_entity.dart';
import 'package:share_blog/features/auth/domain/repositories/auth_repository.dart';

class SignUpUsecase implements UseCase<AuthEntity, UserSignUpParams> {
  final AuthRepository authRepository;
  SignUpUsecase({required this.authRepository});

  @override
  Future<Either<Failure, AuthEntity>> call(UserSignUpParams params) async {
    try {
      final response = await authRepository.signUpWithEmail(
        email: params.email,
        password: params.password,
        role: params.role,
      );

      return response;
    } catch (e) {
      return left(Failure(message: e.toString()));
    }
  }
}

class UserSignUpParams {
  final String email;
  final String password;
  final String role;
  UserSignUpParams({
    required this.email,
    required this.password,
    required this.role,
  });
}
