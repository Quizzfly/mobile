import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/forgot_password_model.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

/// A bloc that manages the state of a ForgotPassword according to the event that is dispatche
class ForgotPasswordBloc extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(ForgotPasswordState initialstate) : super(initialstate) {
    on<ForgotPasswordInitialEvent>(_onInitialize);
  }
  _onInitialize(
    ForgotPasswordInitialEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        emailController: TextEditingController(),
      ),
    );
  }
}
