part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSignUpSuccess extends AuthState {
  final AuthEntity user;
  const AuthSignUpSuccess({required this.user});
}

final class AuthSignUpFailure extends AuthState {
  final String message;

  const AuthSignUpFailure({required this.message});
}

final class AuthLoginSuccess extends AuthState {
  final AuthEntity user;
  const AuthLoginSuccess({required this.user});
}

final class AuthLoginFailure extends AuthState {
  final String message;

  const AuthLoginFailure({required this.message});
}

final class AuthRefreshSuccess extends AuthState {
  final String accessToken;

  const AuthRefreshSuccess({required this.accessToken});
}

final class AuthRefreshFailure extends AuthState {
  final String message;

  const AuthRefreshFailure({required this.message});
}

final class AuthLogoutSuccess extends AuthState {}

final class AuthLogoutFailure extends AuthState {}
