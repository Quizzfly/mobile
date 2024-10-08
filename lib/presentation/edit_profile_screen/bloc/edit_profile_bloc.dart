import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../../../data/models/selectionPopupModel/selection_popup_model.dart';
import '../models/edit_profile_model.dart';
part 'edit_profile_event.dart';
part 'edit_profile_state.dart';

/// A bloc that manages the state of a EditProfile according to the event that is dispatched to it.
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(EditProfileState initialState) : super(initialState) {
    on<EditProfileInitialEvent>(_onInitialize);
    on<TextFieldChangedEvent>(_onTextFieldChanged);
  }
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

  List<SelectionPopupModel> fillDropdownItemList1() {
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

  List<SelectionPopupModel> fillDropdownItemList2() {
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

  _onInitialize(
    EditProfileInitialEvent event,
    Emitter<EditProfileState> emit,
  ) async {
    emit(
      state.copyWith(
        usernameInputController: TextEditingController(),
        nameInputController: TextEditingController(),
        emailInputController: TextEditingController(),
        organizationInputController: TextEditingController(),
      ),
    );
    emit(
      state.copyWith(
        editProfileModelObj: state.editProfileModelObj?.copyWith(
          dropdownItemList: fillDropdownItemList(),
          dropdownItemList1: fillDropdownItemList1(),
          dropdownItemList2: fillDropdownItemList2(),
        ),
      ),
    );
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
}
