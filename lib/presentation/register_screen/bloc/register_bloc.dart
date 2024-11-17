import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/register/post_register_resp.dart';
import '../../../core/app_export.dart';
import '../../../data/models/register/post_register_req.dart';
import '../../../data/repository/repository.dart';
import '../models/register_model.dart';
part 'register_event.dart';
part 'register_state.dart';

/// A bloc that manages the state of a Register according to the event that is disp
class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  RegisterBloc(super.initialState) {
    on<RegisterInitialEvent>(_onInitialize);
    on<CreateRegisterEvent>(_callRegister);
  }
  _onInitialize(
    RegisterInitialEvent event,
    Emitter<RegisterState> emit,
  ) async {
    emit(
      state.copyWith(
        nameController: TextEditingController(),
        emailController: TextEditingController(),
        passwordController: TextEditingController(),
        confirmPasswordController: TextEditingController(),
      ),
    );
  }

  final _repository = Repository();

  var postRegisterResp = PostRegisterResp();

  /// Calls [{{baseUrl}}/api/v1/auth/register] with the provided event and emits the state.
  ///
  /// The [CreateRegisterEvent] parameter is used for handling event data
  /// The [emit] parameter is used for emitting the state
  ///
  /// Throws an error if an error occurs during the API call process.
  FutureOr<void> _callRegister(
    CreateRegisterEvent event,
    Emitter<RegisterState> emit,
  ) async {
    var postRegisterReq = PostRegisterReq(
      name: state.nameController?.text ?? '',
      email: state.emailController?.text ?? '',
      password: state.passwordController?.text ?? '',
      confirmPassword: state.confirmPasswordController?.text ?? '',
    );
    await _repository.register(
      headers: {},
      requestData: postRegisterReq.toJson(),
    ).then((value) async {
      postRegisterResp = value;
      _onRegisterSuccess(value, emit);
      event.onCreateRegisterEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onRegisterError();
      event.onCreateRegisterEventError?.call();
    });
  }

  void _onRegisterSuccess(
    PostRegisterResp resp,
    Emitter<RegisterState> emit,
  ) {}
  void _onRegisterError() {}
}
