import 'package:bloc/bloc.dart';

import 'package:equatable/equatable.dart';
import 'package:share_blog/features/auth/domain/entities/auth_entity.dart';
import 'package:share_blog/features/auth/domain/usecases/login_usecase.dart';
import 'package:share_blog/features/auth/domain/usecases/logout_usecase.dart';
import 'package:share_blog/features/auth/domain/usecases/refresh_token_usecase.dart';
import 'package:share_blog/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:share_blog/services/token/token_storage.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final SignUpUsecase _signUpUsecase;
  final LoginUsecase _loginUsecase;
  final RefreshTokenUsecase _refreshTokenUsecase;
  final LogoutUsecase _logoutUsecase;

  AuthBloc({
    required SignUpUsecase signUpUsecase,
    required LoginUsecase loginUsecase,
    required RefreshTokenUsecase refreshTokenUsecase,
    required LogoutUsecase logoutUsecase,
  }) : _signUpUsecase = signUpUsecase,
       _loginUsecase = loginUsecase,
       _refreshTokenUsecase = refreshTokenUsecase,
       _logoutUsecase = logoutUsecase,
       super(AuthInitial()) {
    on<AuthSignUp>((event, emit) async {
      emit(AuthLoading());

      final res = await _signUpUsecase.call(
        UserSignUpParams(
          email: event.email,
          password: event.password,
          role: event.role,
        ),
      );

      res.fold(
        (failure) => emit(AuthSignUpFailure(message: failure.message)),
        (success) => emit(AuthSignUpSuccess(user: success)),
      );
    });

    on<AuthLogin>((event, emit) async {
      emit(AuthLoading());
      final res = await _loginUsecase.call(
        UserLoginParams(email: event.email, password: event.password),
      );

      final result = res.fold((failure) {
        emit(AuthLoginFailure(message: failure.message));
        return null;
      }, (success) => success);

      if (result != null) {
        if ((result.accessToken ?? "").isNotEmpty) {
          await TokenStorage.saveAccessToken(result.accessToken!);
        }

        if ((result.refreshToken ?? "").isNotEmpty) {
          await TokenStorage.saveRefreshToken(result.refreshToken!);
        }

        emit(AuthLoginSuccess(user: result));
      }
    });

    on<AuthRefreshToken>((event, emit) async {
      emit(AuthLoading());

      final res = await _refreshTokenUsecase.call(
        UserRefreshParams(refreshToken: event.refreshToken),
      );

      res.fold(
        (failure) => emit(AuthRefreshFailure(message: failure.message)),
        (success) =>
            emit(AuthRefreshSuccess(accessToken: success.accessToken ?? "")),
      );
    });

    on<AuthLogout>((event, emit) async {
      emit(AuthLoading());

      final res = await _logoutUsecase.call(
        UserLogoutParams(accessToken: event.accessToken),
      );

      final result = res.fold(
        (failure) {
          emit(AuthLogoutFailure());
          return null;
        },
        (success) {
          emit(AuthLogoutSuccess());
          return success;
        },
      );

      if (result != null && result) {
        await TokenStorage.clear();
        print("xoa thanh cong");
      }
    });
  }
}
