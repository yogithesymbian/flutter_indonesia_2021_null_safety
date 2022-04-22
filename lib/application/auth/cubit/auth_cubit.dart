import 'package:bloc/bloc.dart';
import 'package:flutter_indonesia_2021/domain/auth/model/login_request.dart';
import 'package:flutter_indonesia_2021/domain/auth/model/login_response.dart';
import 'package:flutter_indonesia_2021/infrastructure/auth/auth_repository.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  AuthRepository _authRepository = AuthRepository();
  void signUser(LoginRequest loginRequest) async {
    emit(AuthLoading());
    try {
      final _data = await _authRepository.signUserWithEmailAndPassword(
        loginRequest: loginRequest,
      );
      _data.fold(
        (l) => emit(AuthError(l)),
        (r) => emit(AuthLoginSuccess(r)),
      );
    } catch (err) {
      emit(AuthError(err.toString()));
    }
  }
}
