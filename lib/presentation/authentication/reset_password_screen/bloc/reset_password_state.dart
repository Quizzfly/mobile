part of 'reset_password_bloc.dart';

/// Represents the state of forgotPassword in the application.
// ignore_for_file: must_be_immutable
class ResetPasswordState extends Equatable {
  ResetPasswordState(
      {this.newPasswordController,
      this.confirmNewPasswordController,
      this.resetPasswordModelObj});

  TextEditingController? newPasswordController;

  TextEditingController? confirmNewPasswordController;

  ResetPasswordModel? resetPasswordModelObj;

  @override
  List<Object?> get props => [
        newPasswordController,
        confirmNewPasswordController,
        resetPasswordModelObj
      ];
  ResetPasswordState copyWith({
    TextEditingController? newPasswordController,
    TextEditingController? confirmNewPasswordController,
    ResetPasswordModel? resetPasswordModelObj,
  }) {
    return ResetPasswordState(
      newPasswordController:
          newPasswordController ?? this.newPasswordController,
      confirmNewPasswordController:
          confirmNewPasswordController ?? this.confirmNewPasswordController,
      resetPasswordModelObj:
          resetPasswordModelObj ?? this.resetPasswordModelObj,
    );
  }
}
