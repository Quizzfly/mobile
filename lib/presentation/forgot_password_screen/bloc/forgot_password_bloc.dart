import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/forgot_password/post_forgot_password_resp.dart';
import 'package:quizzfly_application_flutter/data/repository/repository.dart';
import '../../../core/app_export.dart';
import '../../../data/models/forgot_password/post_forgot_password_req.dart';
import '../models/forgot_password_model.dart';
part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

/// A bloc that manages the state of a ForgotPassword according to the event that is dispatche
class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc(ForgotPasswordState initialstate) : super(initialstate) {
    on<ForgotPasswordInitialEvent>(_onInitialize);
    on<CreateForgotPasswordEvent>(_callPostAuthForgotPassword);
  }
  final _repository = Repository();
  var postForgotPasswordResp = PostForgotPasswordResp();

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

  FutureOr<void> _callPostAuthForgotPassword(
    CreateForgotPasswordEvent event,
    Emitter<ForgotPasswordState> emit,
  ) async {
    var postForgotPasswordReq = PostForgotPasswordReq(
      email: state.emailController?.text ?? '',
    );
    await _repository.postAuthForgotPassword(
      headers: {},
      requestData: postForgotPasswordReq.toJson(),
    ).then((value) async {
      postForgotPasswordResp = value;
      onPostForgotPasswordSuccess(value, emit);
      event.onCreateForgotPasswordEventSuccess?.call();
    }).onError((error, stackTrace) {
      onPostForgotPasswordError();
      event.onCreateForgotPasswordEventError?.call();
    });
  }

  void onPostForgotPasswordSuccess(
    PostForgotPasswordResp resp,
    Emitter<ForgotPasswordState> emit,
  ) {}
  void onPostForgotPasswordError() {}
}
