import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tasky_app/features/auth/data/models/login_request.dart';
import 'package:tasky_app/features/auth/data/models/register_request.dart';
import 'package:tasky_app/features/auth/domain/use_cases/login.dart';
import 'package:tasky_app/features/auth/domain/use_cases/register.dart';
import 'package:tasky_app/features/auth/presentation/view_model/cubit/auth_states.dart';

@singleton
class AuthCubit extends Cubit<AuthStates> {
  final Register _register;
  final Login _login;
  AuthCubit(this._register, this._login) : super(AuthInitialStates());

  static AuthCubit get(context) => BlocProvider.of(context);

  Future<void> login(LoginRequest loginRequest) async {
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

  Future<void> register(RegisterRequest registerRequest) async {
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
}
