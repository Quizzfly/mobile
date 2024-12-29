import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/app_export.dart';
import '../models/reset_password_model.dart';
part 'reset_password_event.dart';
part 'reset_password_state.dart';

/// A bloc that manages the state of a ResetPassword according to the event that is dispatche
class ResetPasswordBloc extends Bloc<ResetPasswordEvent, ResetPasswordState> {
  ResetPasswordBloc(super.initialstate) {
    on<ResetPasswordInitialEvent>(_onInitialize);
  }
  _onInitialize(
    ResetPasswordInitialEvent event,
    Emitter<ResetPasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        newPasswordController: TextEditingController(),
        confirmNewPasswordController: TextEditingController(),
      ),
    );
  }
}
