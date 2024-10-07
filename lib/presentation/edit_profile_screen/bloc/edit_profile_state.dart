part of 'edit_profile_bloc.dart';

/// Represents the state of EditProfile in the application.
// ignore_for_file: must_be_immutable
class EditProfileState extends Equatable {
  EditProfileState(
      {this.usernameInputController,
      this.nameInputController,
      this.emailInputController,
      this.organizationInputController,
      this.selectedDropDownValue,
      this.selectedDropDownValue1,
      this.selectedDropDownValue2,
      this.editProfileModelObj,
      this.isSaveButtonEnabled = false});
  TextEditingController? usernameInputController;
  TextEditingController? nameInputController;
  TextEditingController? emailInputController;
  TextEditingController? organizationInputController;
  SelectionPopupModel? selectedDropDownValue;
  SelectionPopupModel? selectedDropDownValue1;
  SelectionPopupModel? selectedDropDownValue2;
  EditProfileModel? editProfileModelObj;
  bool? isSaveButtonEnabled;


  @override
  List<Object?> get props => [
        usernameInputController,
        nameInputController,
        emailInputController,
        organizationInputController,
        selectedDropDownValue,
        selectedDropDownValue1,
        selectedDropDownValue2,
        editProfileModelObj,
        isSaveButtonEnabled
      ];
  EditProfileState copyWith({
    TextEditingController? usernameInputController,
    TextEditingController? nameInputController,
    TextEditingController? emailInputController,
    TextEditingController? organizationInputController,
    SelectionPopupModel? selectedDropDownValue,
    SelectionPopupModel? selectedDropDownValue1,
    SelectionPopupModel? selectedDropDownValue2,
    EditProfileModel? editProfileModelObj,
    bool? isSaveButtonEnabled,

  }) {
    return EditProfileState(
      usernameInputController:
          usernameInputController ?? this.usernameInputController,
      nameInputController: nameInputController ?? this.nameInputController,
      emailInputController: emailInputController ?? this.emailInputController,
      organizationInputController:
          organizationInputController ?? this.organizationInputController,
      selectedDropDownValue:
          selectedDropDownValue ?? this.selectedDropDownValue,
      selectedDropDownValue1:
          selectedDropDownValue1 ?? this.selectedDropDownValue1,
      selectedDropDownValue2:
          selectedDropDownValue2 ?? this.selectedDropDownValue2,
      editProfileModelObj: editProfileModelObj ?? this.editProfileModelObj,
      isSaveButtonEnabled: isSaveButtonEnabled ?? this.isSaveButtonEnabled,
    );
  }
}
