import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';

/// A bloc that manages the state of a Login according to the event that is dispatche
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(LoginState initialstate) : super(initialstate) {
    on<LoginInitialEvent>(_onInitialize);
  }
  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    emit(
      state.copyWith(
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
      ),
    );
  }
}
