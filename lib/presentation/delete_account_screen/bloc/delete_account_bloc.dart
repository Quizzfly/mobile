import 'dart:async';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:quizzfly_application_flutter/data/repository/repository.dart';
import '../../../core/app_export.dart';
import '../../../data/models/delete_user/post_request_delete_user_req.dart';
import '../../../data/models/delete_user/post_request_delete_user_resp.dart';
import '../../../data/models/logout/post_logout_resp.dart';
import '../../../data/models/verify_delete_user/delete_verify_delete_user_resp.dart';
import '../models/delete_account_model.dart';
part 'delete_account_event.dart';
part 'delete_account_state.dart';

/// A bloc that manages the state of a DeleteAccount according to the event that is dispatched to it.
class DeleteAccountBloc extends Bloc<DeleteAccountEvent, DeleteAccountState> {
  DeleteAccountBloc(super.initialState) {
    on<DeleteAccountInitialEvent>(_onInitialize);
    on<CreateRequestDeleteEvent>(_callRequestDeleteUser);
    on<DeleteVerifyDeleteEvent>(_callVerifyDeleteUser);
    on<CreateLogoutEvent>(_callLogoutPost);
  }

  final _repository = Repository();
  var postRequestDeleteUserResp = PostRequestDeleteUserResp();
  var deleteVerifyDeleteUserResp = DeleteVerifyDeleteUserResp();
  final String accessToken = PrefUtils().getAccessToken();
  _onInitialize(
    DeleteAccountInitialEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    emit(
      state.copyWith(
        codeInputFieldController: TextEditingController(),
      ),
    );
  }

  FutureOr<void> _callRequestDeleteUser(
    CreateRequestDeleteEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    var postRequestDeleteUserReq = PostRequestDeleteUserReq();
    await _repository.requestDeleteUser(
      headers: {'Authorization': 'Bearer $accessToken '},
      requestData: postRequestDeleteUserReq.toJson(),
    ).then((value) async {
      postRequestDeleteUserResp = value;
      _onRequestDeleteUserSuccess(value, emit);
      event.onCreateRequestDeleteEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onRequestDeleteUserError();
    });
  }

  void _onRequestDeleteUserSuccess(
    PostRequestDeleteUserResp resp,
    Emitter<DeleteAccountState> emit,
  ) {}
  void _onRequestDeleteUserError() {}

  FutureOr<void> _callVerifyDeleteUser(
    DeleteVerifyDeleteEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    var queryParams = <String, dynamic>{
      'code': state.codeInputFieldController?.text ?? ''
    };
    await _repository.verifyDeleteUser(
      headers: {'Authorization': 'Bearer $accessToken '},
      queryParams: queryParams,
    ).then((value) async {
      deleteVerifyDeleteUserResp = value;
      _onVerifyDeleteUserSuccess(value, emit);
      event.onDeleteVerifyDeleteEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onVerifyDeleteUserError();
    });
  }

  void _onVerifyDeleteUserSuccess(
    DeleteVerifyDeleteUserResp resp,
    Emitter<DeleteAccountState> emit,
  ) {}
  void _onVerifyDeleteUserError() {}

  FutureOr<void> _callLogoutPost(
    CreateLogoutEvent event,
    Emitter<DeleteAccountState> emit,
  ) async {
    try {
      bool success = await _repository.logoutPost(
        headers: {'Authorization': 'Bearer $accessToken '},
      );
      if (success) {
        event.onCreateLogoutEventSuccess?.call();
      } else {
        event.onCreateLogoutEventError?.call();
      }
    } catch (error) {
      event.onCreateLogoutEventError?.call();
    }
  }

  void onLogoutPostSuccess(
    PostLogoutResp resp,
    Emitter<DeleteAccountState> emit,
  ) {}
  void onLogoutPostError() {}
}
