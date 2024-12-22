import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/models/my_user/get_my_user_resp.dart';
import '../../../../data/models/login/post_login_resp.dart';
import '../../../../core/app_export.dart';
import '../../../../data/models/login/post_login_req.dart';
import '../../../../data/models/login_google/post_login_google_req.dart';
import '../../../../data/repository/repository.dart';
import '../models/login_model.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc(super.initialState) {
    on<LoginInitialEvent>(_onInitialize);
    on<CreateLoginEvent>(_callLogin);
    on<CreateLoginGoogleEvent>(_callLoginWithGoogle);
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

  FutureOr<void> _callLoginWithGoogle(
    CreateLoginGoogleEvent event,
    Emitter<LoginState> emit,
  ) async {
    var postLoginGoogleReq = PostLoginGoogleReq(
      accessToken: event.accessToken,
    );
    await _repository.loginWithGoogle(
      headers: {},
      requestData: postLoginGoogleReq.toJson(),
    ).then((value) async {
      postLoginResp = value;
      _onLoginSuccess(value, emit);
      event.onCreateLoginEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onLoginError();
      event.onCreateLoginEventError?.call();
    });
  }

  Future<void> _onLoginSuccess(
    PostLoginResp resp,
    Emitter<LoginState> emit,
  ) async {
    PrefUtils().setAccessToken(resp.data?.accessToken ?? '');
    PrefUtils().setRefreshToken(resp.data?.refreshToken ?? '');

    emit(state.copyWith(
      loginModelObj: state.loginModelObj?.copyWith(),
    ));
    add(FetchMeEvent());
  }

  void _onLoginError() {}

  FutureOr<void> _callGetMyUser(
    FetchMeEvent event,
    Emitter<LoginState> emit,
  ) async {
    String accessToken = PrefUtils().getAccessToken();
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
    PrefUtils().setUserId(resp.data?.id ?? '');
    emit(
      state.copyWith(
        loginModelObj: state.loginModelObj?.copyWith(),
      ),
    );
  }

  void _onGetMyUserError() {}
}
