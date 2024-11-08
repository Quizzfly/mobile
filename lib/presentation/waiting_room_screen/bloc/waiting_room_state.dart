part of 'waiting_room_bloc.dart';

/// Represents the state of WaitingRoom in the application.
// ignore_for_file: must_be_immutable
class WaitingRoomState extends Equatable {
  WaitingRoomState({this.nameController, this.inputNicknameModelObj});
  TextEditingController? nameController;
  WaitingRoomModel? inputNicknameModelObj;
  @override
  List<Object?> get props => [nameController, inputNicknameModelObj];
  WaitingRoomState copyWith({
    TextEditingController? nameController,
    WaitingRoomModel? inputNicknameModelObj,
  }) {
    return WaitingRoomState(
      nameController: nameController ?? this.nameController,
      inputNicknameModelObj:
          inputNicknameModelObj ?? this.inputNicknameModelObj,
    );
  }
}
