import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dw9_delivery_app/app/pages/auth/register/register_state.dart';
import 'package:dw9_delivery_app/app/repositories/auth/auth_repository.dart';

class RegisterController extends Cubit<RegisterState> {
  final AuthRepository _authrepository;

  RegisterController(this._authrepository)
      : super(const RegisterState.initial());

  Future<void> register(String name, String email, String password) async {
    try {
      emit(state.copyWith(status: RegisterStatus.register));
      await _authrepository.register(name, email, password);
      emit(state.copyWith(status: RegisterStatus.sucess));
    } catch (e) {
      log('Erro ao registrar usuário: $e' as num);
      emit(state.copyWith(status: RegisterStatus.error));
    }
  }
}
