part of 'input_nickname_bloc.dart';

/// Represents the state of InputNickname in the application.
// ignore_for_file: must_be_immutable
class InputNicknameState extends Equatable {
  InputNicknameState({this.nameController, this.inputNicknameModelObj});
  TextEditingController? nameController;
  InputNicknameModel? inputNicknameModelObj;
  @override
  List<Object?> get props => [nameController, inputNicknameModelObj];
  InputNicknameState copyWith({
    TextEditingController? nameController,
    InputNicknameModel? inputNicknameModelObj,
  }) {
    return InputNicknameState(
      nameController: nameController ?? this.nameController,
      inputNicknameModelObj:
          inputNicknameModelObj ?? this.inputNicknameModelObj,
    );
  }
}
