part of 'waiting_room_bloc.dart';

/// Represents the state of WaitingRoom in the application.
// ignore_for_file: must_be_immutable
class WaitingRoomState extends Equatable {
  WaitingRoomState(
      {this.nameController,
      this.inputNicknameModelObj,
      this.connectionStatus = ConnectionStatus.disconnected,
      this.error});
  TextEditingController? nameController;
  WaitingRoomModel? inputNicknameModelObj;
  final ConnectionStatus? connectionStatus;
  final String? error;
  @override
  List<Object?> get props =>
      [nameController, inputNicknameModelObj, connectionStatus, error];
  WaitingRoomState copyWith({
    TextEditingController? nameController,
    WaitingRoomModel? inputNicknameModelObj,
    ConnectionStatus? connectionStatus,
    String? error,
  }) {
    return WaitingRoomState(
      nameController: nameController ?? this.nameController,
      inputNicknameModelObj:
          inputNicknameModelObj ?? this.inputNicknameModelObj,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      error: error ?? this.error,
    );
  }
}

enum ConnectionStatus {
  disconnected,
  connecting,
  connected,
  quizStarted,
  error,
}
