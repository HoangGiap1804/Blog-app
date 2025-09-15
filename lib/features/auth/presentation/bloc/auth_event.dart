part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

final class AuthSignUp extends AuthEvent {
  final String email;
  final String password;
  final String role;
  const AuthSignUp({
    required this.email,
    required this.role,
    required this.password,
  });
}

final class AuthLogin extends AuthEvent {
  final String email;
  final String password;
  const AuthLogin({required this.email, required this.password});
}

final class AuthRefreshToken extends AuthEvent {
  final String refreshToken;
  const AuthRefreshToken({required this.refreshToken});
}

final class AuthLogout extends AuthEvent {
  final String accessToken;
  const AuthLogout({required this.accessToken});
}
