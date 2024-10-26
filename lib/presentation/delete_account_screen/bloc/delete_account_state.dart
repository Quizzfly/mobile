part of 'delete_account_bloc.dart';

/// Represents the state of DeleteAccount in the application.
// ignore_for_file: must_be_immutable
class DeleteAccountState extends Equatable {
  DeleteAccountState(
      {this.codeInputFieldController, this.deleteAccountModelObj});
  TextEditingController? codeInputFieldController;
  DeleteAccountModel? deleteAccountModelObj;
  @override
  List<Object?> get props => [codeInputFieldController, deleteAccountModelObj];
  DeleteAccountState copyWith({
    TextEditingController? codeInputFieldController,
    DeleteAccountModel? deleteAccountModelobj,
  }) {
    return DeleteAccountState(
      codeInputFieldController:
          codeInputFieldController ?? this.codeInputFieldController,
      deleteAccountModelObj:
          deleteAccountModelObj ?? this.deleteAccountModelObj,
    );
  }
}
