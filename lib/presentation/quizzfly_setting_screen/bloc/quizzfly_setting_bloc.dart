import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../../core/app_export.dart';
import '../../../data/models/update_quizzfly_setting/put_update_quizzfly_setting_req.dart';
import '../../../data/models/update_quizzfly_setting/put_update_quizzfly_setting_resp.dart';
import '../../../data/models/upload_file/post_upload_file.dart';
import '../../../data/repository/repository.dart';
import '../models/quizzfly_setting_model.dart';
part 'quizzfly_setting_event.dart';
part 'quizzfly_setting_state.dart';

class QuizzflySettingBloc
    extends Bloc<QuizzflySettingEvent, QuizzflySettingState> {
  QuizzflySettingBloc(super.initialState) {
    on<QuizzflySettingInitialEvent>(_onInitialize);
    on<ChangeVisibilityEvent>(_onChangeVisibility);
    on<PickImageEvent>(_onPickImage);
    on<UpdateSettingsEvent>(_callUpdateQuizzflySettings);
  }
  final _repository = Repository();
  var putUpdateQuizzflySettingsResp = PutUpdateQuizzflySettingsResp();
  _onInitialize(
    QuizzflySettingInitialEvent event,
    Emitter<QuizzflySettingState> emit,
  ) async {
    // Initialize controllers with values from arguments
    final titleController = TextEditingController(text: state.title ?? '');
    final descriptionController =
        TextEditingController(text: state.description ?? '');

    final visibility = state.isPublic == true ? 'public' : 'private';

    emit(
      state.copyWith(
        titleController: titleController,
        descriptionController: descriptionController,
        visibility: visibility,
        coverImage: state.coverImage,
      ),
    );
  }

  _onChangeVisibility(
    ChangeVisibilityEvent event,
    Emitter<QuizzflySettingState> emit,
  ) {
    bool isPublic = event.value == 'public';
    emit(state.copyWith(
      visibility: event.value,
      isPublic: isPublic,
    ));
  }

  _onPickImage(
    PickImageEvent event,
    Emitter<QuizzflySettingState> emit,
  ) {
    emit(state.copyWith(
      coverImage: event.imagePath,
    ));
  }

  FutureOr<void> _callUpdateQuizzflySettings(
    UpdateSettingsEvent event,
    Emitter<QuizzflySettingState> emit,
  ) async {
    String accessToken = PrefUtils().getAccessToken();
    String? imageUrl;

    if (state.coverImage != null && state.coverImage is File) {
      UploadFileResp uploadResp = await _repository.uploadFile(
        file: state.coverImage,
        headers: {},
      );
      imageUrl = uploadResp.data?.url;
    }
    var putUpdateQuizzflySettingsReq = PutUpdateQuizzflySettingsReq(
      title: state.titleController?.text ?? '',
      description: state.descriptionController?.text ?? '',
      isPublic: state.isPublic,
      coverImage: imageUrl ?? state.coverImage,
    );

    await _repository.updateQuizzflySettings(
      headers: {'Authorization': 'Bearer $accessToken'},
      requestData: putUpdateQuizzflySettingsReq.toJson(),
      id: state.id,
    ).then((value) async {
      putUpdateQuizzflySettingsResp = value;
      _onUpdateQuizzflySettingsSuccess(value, emit);
      event.onUpdateSettingsEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onUpdateQuizzflySettingsError();
      Fluttertoast.showToast(
        msg: error.toString(),
      );
    });
  }

  void _onUpdateQuizzflySettingsSuccess(
    PutUpdateQuizzflySettingsResp resp,
    Emitter<QuizzflySettingState> emit,
  ) {
    emit(
      state.copyWith(
        coverImage: resp.data?.coverImage ?? ImageConstant.imgNotFound,
        titleController: TextEditingController(text: resp.data?.title ?? ''),
        descriptionController:
            TextEditingController(text: resp.data?.description ?? ''),
        isPublic: resp.data?.isPublic ?? false,
      ),
    );
  }

  _onUpdateQuizzflySettingsError() {}
}
