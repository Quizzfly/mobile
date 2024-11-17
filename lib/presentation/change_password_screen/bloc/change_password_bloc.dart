import 'dart:async';

import "package:flutter/material.dart";
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/change_password/post_change_password_req.dart';
import '../../../data/models/change_password/post_change_password_resp.dart';
import '../../../data/repository/repository.dart';
import '../models/change_password_model.dart';
part 'change_password_event.dart';
part 'change_password_state.dart';

/// A bloc that manages the state of a ChangePassword according to the event that is dispatched to it.
class ChangePasswordBloc
    extends Bloc<ChangePasswordEvent, ChangePasswordState> {
  ChangePasswordBloc(super.initialState) {
    on<ChangePasswordInitialEvent>(_onInitialize);
    on<CreateChangePasswordEvent>(_callChangePassword);
  }
  final _repository = Repository();
  var postChangePasswordResp = PostChangePasswordResp();
  _onInitialize(
    ChangePasswordInitialEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    emit(
      state.copyWith(
        oldPasswordInputController: TextEditingController(),
        newPasswordInputController: TextEditingController(),
        confirmPasswordInputController: TextEditingController(),
      ),
    );
  }

  FutureOr<void> _callChangePassword(
    CreateChangePasswordEvent event,
    Emitter<ChangePasswordState> emit,
  ) async {
    var postChangePasswordReq = PostChangePasswordReq(
      oldPassword: state.oldPasswordInputController?.text ?? '',
      newPassword: state.newPasswordInputController?.text ?? '',
      confirmNewPassword: state.confirmPasswordInputController?.text ?? '',
    );
    String accessToken = PrefUtils().getAccessToken();
    await _repository.changePassword(
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $accessToken'
      },
      requestData: postChangePasswordReq.toJson(),
    ).then((value) async {
      postChangePasswordResp = value;
      _onChangePasswordSuccess(value, emit);
      event.onCreateChangePasswordEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onChangePasswordError();
    });
  }

  void _onChangePasswordSuccess(
    PostChangePasswordResp resp,
    Emitter<ChangePasswordState> emit,
  ) {}
  void _onChangePasswordError() {}
}
