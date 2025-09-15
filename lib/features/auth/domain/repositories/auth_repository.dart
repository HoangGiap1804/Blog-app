import 'package:fpdart/fpdart.dart';
import 'package:share_blog/core/error/failure.dart';
import 'package:share_blog/features/auth/domain/entities/auth_entity.dart';

abstract interface class AuthRepository {
  Future<Either<Failure, AuthEntity>> signUpWithEmail({
    required String email,
    required String password,
    required String role,
  });

  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthEntity>> refreshToken({
    required String refreshToken,
  });

  Future<Either<Failure, bool>> logout({required String accessToken});
}
