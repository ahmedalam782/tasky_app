import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/features/auth/domain/entities/post_login_entity.dart';
import 'package:tasky_app/features/auth/domain/entities/post_register_entity.dart';
import 'package:tasky_app/features/auth/domain/use_cases/access_token.dart';
import 'package:tasky_app/features/auth/domain/use_cases/login.dart';
import 'package:tasky_app/features/auth/domain/use_cases/logout.dart';
import 'package:tasky_app/features/auth/domain/use_cases/refresh_token.dart';
import 'package:tasky_app/features/auth/domain/use_cases/register.dart';
import 'package:tasky_app/features/auth/domain/use_cases/save_access_token.dart';
import 'package:tasky_app/features/auth/domain/use_cases/save_refresh_token.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_states.dart';

@singleton
class AuthCubit extends Cubit<AuthStates> {
  final Register _register;
  final Login _login;
  final Logout _logout;
  final AccessToken _accessToken;
  final SaveAccessToken _saveAccessToken;
  final RefreshToken _refreshToken;
  final SaveRefreshToken _saveRefreshToken;

  AuthCubit(this._register, this._login, this._logout, this._accessToken,
      this._saveAccessToken, this._refreshToken, this._saveRefreshToken)
      : super(AuthInitialStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> login(PostLoginEntity loginRequest) async {
    emit(LoginLoadingStates());
    final result = await _login(loginRequest);
    result.fold(
      (failure) {
        emit(LoginErrorStates(
          error: failure.message,
        ));
      },
      (_) {
        emit(LoginSuccessStates());
      },
    );
  }

  Future<void> register(PostRegisterEntity registerRequest) async {
    emit(RegisterLoadingStates());
    final result = await _register(registerRequest);
    result.fold(
      (failure) {
        emit(RegisterErrorStates(
          error: failure.message,
        ));
      },
      (_) {
        emit(RegisterSuccessStates());
      },
    );
  }

  Future<void> logOut() async {
    emit(LogOutLoading());
    final result = await _logout();
    result.fold(
      (failure) {
        emit(LogOutError(
          message: failure.message,
        ));
      },
      (logout) {
        emit(LogOutSuccess(
          logout: logout,
        ));
      },
    );
  }

  Future<void> getNewAccessToken() async {
    emit(AccessTokenLoading());
    final result = await _accessToken();
    result.fold(
      (failure) {
        emit(AccessTokenError(
          message: failure.message,
        ));
      },
      (token) {
        emit(AccessTokenSuccess(
          token: token,
        ));
      },
    );
  }

  Future<void> saveAccessToken(String token) async {
    emit(SaveAccessTokenLoading());
    final result = await _saveAccessToken(token);
    result.fold(
      (failure) {
        emit(SaveAccessTokenError(
          message: failure.message,
        ));
      },
      (token) {
        emit(SaveAccessTokenSuccess(
          accessToken: token,
        ));
      },
    );
  }

  Future<void> saveRefreshToken(String token) async {
    emit(SaveRefreshTokenLoading());
    final result = await _saveRefreshToken(token);
    result.fold(
      (failure) {
        emit(SaveRefreshTokenError(
          message: failure.message,
        ));
      },
      (token) {
        emit(SaveRefreshTokenSuccess(
          refreshToken: token,
        ));
      },
    );
  }

  void getRefreshToken() {
    emit(GetRefreshTokenLoading());
    final result = _refreshToken();
    result.fold(
      (failure) {
        emit(GetRefreshTokenError(
          message: failure.message,
        ));
      },
      (token) {
        emit(GetRefreshTokenSuccess(
          token: token,
        ));
      },
    );
  }
}
