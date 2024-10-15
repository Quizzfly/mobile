import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/my_user/get_my_user_resp.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../../../data/models/update_profile/patch_update_profile_req.dart';
import '../../../data/models/upload_file/post_upload_file.dart';
import '../../../data/repository/repository.dart';
import '../models/edit_profile_model.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

/// A bloc that manages the state of a EditProfile according to the event that is dispatched to it.
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(EditProfileState initialState) : super(initialState) {
    on<EditProfileInitialEvent>(_onInitialize);
    on<TextFieldChangedEvent>(_onTextFieldChanged);
    on<CreateLGetUserEvent>(_callGetMyUser);
    on<ImagePickedEvent>(_onImagePicked);
    on<UpdateProfileEvent>(_onUpdateProfile);
  }

  final _repository = Repository();
  var getMyUserResp = GetMyUserResp();
  List<SelectionPopupModel> fillDropdownItemList() {
    return [
      SelectionPopupModel(
        id: 1,
        title: "Item One",
        isSelected: true,
      ),
      SelectionPopupModel(
        id: 2,
        title: "Item Two",
      ),
      SelectionPopupModel(
        id: 3,
        title: "Item Three",
      )
    ];
  }
  // In your EditProfileBloc

  void _onInitialize(
    EditProfileInitialEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    try {
      add(CreateLGetUserEvent(onCreateLoginEventSuccess: () {
        print('User data fetched successfully');
      }));
      // Update state with the fetched data
      emit(state.copyWith(
        usernameInputController: TextEditingController(),
        nameInputController: TextEditingController(),
        emailInputController: TextEditingController(),
      ));
      emit(state.copyWith(
          editProfileModelObj: state.editProfileModelObj?.copyWith(
        dropdownItemList: fillDropdownItemList(),
      )));
    } catch (e) {
      print('Error initializing profile data: $e');
    }
  }

  _onTextFieldChanged(
    TextFieldChangedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    // Enable save button if all fields are filled
    bool isButtonEnabled = event.username.isNotEmpty ||
        event.name.isNotEmpty ||
        event.email.isNotEmpty;

    emit(state.copyWith(isSaveButtonEnabled: isButtonEnabled));
  }

  FutureOr<void> _callGetMyUser(
    CreateLGetUserEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    String accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjFhN2M3MzM2LWZhNTYtNDg2YS05OTZlLTE2ZDNlZDliMzE4OSIsInJvbGUiOiJVU0VSIiwic2Vzc2lvbklkIjoiNzNmNzcyMmUtNWJmNS00Yjg1LTk4ODMtN2FlZjU3MWI1NmE2IiwiaWF0IjoxNzI4ODM1OTQ0LCJleHAiOjE3Mjg5MjIzNDR9.K0LUk8i5lJyoM81nnLB5RjHOmfeQbR37CbA8zD0yNJ8";
    // Retrieve access token from SharedPreferences
    await _repository.getMyUser(
      headers: {'Authorization': 'Bearer $accessToken'},
    ).then((value) async {
      getMyUserResp = value;
      _onGetMyUserSuccess(value, emit);
      event.onCreateLoginEventSuccess?.call();
    }).onError((error, stackTrace) {
      _onGetMyUserError();
      event.onCreateLoginEventError?.call();
    });
  }

  void _onGetMyUserSuccess(
    GetMyUserResp resp,
    Emitter<EditProfileState> emit,
  ) {
    emit(state.copyWith(
      usernameInputController:
          TextEditingController(text: resp.data?.userInfo?.username ?? ''),
      nameInputController:
          TextEditingController(text: resp.data?.userInfo?.name ?? ''),
      emailInputController: TextEditingController(text: resp.data?.email ?? ''),
      imageFile: resp.data?.userInfo?.avatar,
    ));
  }

  void _onGetMyUserError() {}

  void _onImagePicked(
    ImagePickedEvent event,
    Emitter<EditProfileState> emit,
  ) {
    emit(state.copyWith(
      imageFile: event.imageFile,
      isSaveButtonEnabled: true,
    ));
  }

  FutureOr<void> _onUpdateProfile(
    UpdateProfileEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    String accessToken = await PrefUtils().getAccessToken();
    String? avatarUrl;

    if (state.imageFile != null && state.imageFile is File) {
      UploadFileResp uploadResp = await _repository.uploadFile(
        file: state.imageFile,
        headers: {},
      );
      avatarUrl = uploadResp.data?.url;
    }

    final req = PatchUpdateProfileReq(
      name: state.nameInputController?.text,
      avatar: avatarUrl ?? state.imageFile,
    );
    await _repository.updateProfile(
      requestData: req,
      headers: {'Authorization': 'Bearer $accessToken'},
    ).then((value) async {
      getMyUserResp = value;
      _onGetMyUserSuccess(value, emit);
      event.onSuccess?.call();
    }).onError((error, stackTrace) {
      _onGetMyUserError();
      event.onError?.call();
    });
  }
}
