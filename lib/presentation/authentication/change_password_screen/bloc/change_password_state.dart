part of 'change_password_bloc.dart';

/// Represents the state of ChangePassword in the application.
// ignore_for_file: must_be_immutable
class ChangePasswordState extends Equatable {
  ChangePasswordState(
      {this.oldPasswordInputController,
      this.newPasswordInputController,
      this.confirmPasswordInputController,
      this.changePasswordModelObj});
  TextEditingController? oldPasswordInputController;
  TextEditingController? newPasswordInputController;
  TextEditingController? confirmPasswordInputController;
  ChangePasswordModel? changePasswordModelObj;
  @override
  List<Object?> get props => [
        oldPasswordInputController,
        newPasswordInputController,
        confirmPasswordInputController,
        changePasswordModelObj
      ];
  ChangePasswordState copyWith({
    TextEditingController? oldPasswordInputController,
    TextEditingController? newPasswordInputController,
    TextEditingController? confirmPasswordInputController,
    ChangePasswordModel? changePasswordModelObj,
  }) {
    return ChangePasswordState(
      oldPasswordInputController:
          oldPasswordInputController ?? this.oldPasswordInputController,
      newPasswordInputController:
          newPasswordInputController ?? this.newPasswordInputController,
      confirmPasswordInputController:
          confirmPasswordInputController ?? this.confirmPasswordInputController,
      changePasswordModelObj:
          changePasswordModelObj ?? this.changePasswordModelObj,
    );
  }
}
