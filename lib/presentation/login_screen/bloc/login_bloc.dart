import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/my_user/get_my_user_resp.dart';
import '../../../data/models/login/post_login_resp.dart';
import '../../../core/app_export.dart';
import '../../../data/models/login/post_login_req.dart';
import '../../../data/repository/repository.dart';
import '../models/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';

/// A bloc that manages the state of a Login according to the event that is dispatche
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialstate) {
    on<LoginInitialEvent>(_onInitialize);
    on<CreateLoginEvent>(_callLogin);
    on<FetchMeEvent>(_callGetMyUser);
  }

  final _repository = Repository();

  var postLoginResp = PostLoginResp();

  var getMyUserResp = GetMyUserResp();
  _onInitialize(
    LoginInitialEvent event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(
        state.copyWith(
          emailController: TextEditingController(),
          passwordController: TextEditingController(),
        ),
      );
    } catch (e) {}
  }

  ///Calls [{{baseUrl}}/api/v1/auth/login] with the provided event and emits the state.
  ///
  /// The [CreateLoginEvent] parameter is used for handling event data
  /// The [emit] parameter is used for emitting the state
  ///
  /// Throws an error if an error occurs during the API call process.
  FutureOr<void> _callLogin(
    CreateLoginEvent event,
    Emitter<LoginState> emit,
  ) async {
    var postLoginReq = PostLoginReq(
      email: state.emailController?.text ?? '',
      password: state.passwordController?.text ?? '',
    );
    await _repository.login(
      headers: {},
      requestData: postLoginReq.toJson(),
    ).then((value) async {
      postLoginResp = value;
      _onLoginSuccess(value, emit);
      event.onCreateLoginEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onLoginError();
      event.onCreateLoginEventError?.call();
    });
  }

  void _onLoginSuccess(
    PostLoginResp resp,
    Emitter<LoginState> emit,
  ) async {
    PrefUtils().setAccessToken(resp.data?.accessToken ?? '');
    PrefUtils().setRefreshToken(resp.data?.refreshToken ?? '');
    await _callGetMyUser(FetchMeEvent(), emit);

    emit(
      state.copyWith(
        loginModelObj: state.loginModelObj?.copyWith(),
      ),
    );
  }

  void _onLoginError() {}

  FutureOr<void> _callGetMyUser(
    FetchMeEvent event,
    Emitter<LoginState> emit,
  ) async {
    String accessToken = await PrefUtils().getAccessToken();
    // Retrieve access token from SharedPreferences
    await _repository.getMyUser(
      headers: {'Authorization': 'Bearer $accessToken'},
    ).then((value) async {
      getMyUserResp = value;
      _onGetUsersMeSuccess(value, emit);
    }).onError((error, stackTrace) {
      _onGetMyUserError();
    });
  }

  void _onGetUsersMeSuccess(
    GetMyUserResp resp,
    Emitter<LoginState> emit,
  ) {
    PrefUtils().setUsername(resp.data?.userInfo?.username ?? '');
    PrefUtils().setName(resp.data?.userInfo?.name ?? '');
    PrefUtils().setAvatar(resp.data?.userInfo?.avatar ?? '');
    emit(
      state.copyWith(
        loginModelObj: state.loginModelObj?.copyWith(),
      ),
    );
  }

  void _onGetMyUserError() {}
}
