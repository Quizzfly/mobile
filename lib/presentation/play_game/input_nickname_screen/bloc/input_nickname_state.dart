part of 'input_nickname_bloc.dart';

/// Represents the state of InputNickname in the application.
// ignore_for_file: must_be_immutable
class InputNicknameState extends Equatable {
  InputNicknameState(
      {this.nameController,
      this.inputNicknameModelObj,
      this.isConnected = false,
      this.error,
      this.connectionStatus = ConnectionStatus.disconnected,
      this.roomId,
      this.roomPin});
  TextEditingController? nameController;
  InputNicknameModel? inputNicknameModelObj;
  final bool isConnected;
  final String? error;
  final ConnectionStatus connectionStatus;
  final String? roomId;
  final String? roomPin;
  @override
  List<Object?> get props => [
        nameController,
        inputNicknameModelObj,
        isConnected,
        error,
        connectionStatus,
        roomId,
        roomPin
      ];
  InputNicknameState copyWith({
    TextEditingController? nameController,
    InputNicknameModel? inputNicknameModelObj,
    bool? isConnected,
    String? error,
    ConnectionStatus? connectionStatus,
    String? roomId,
    String? roomPin,
  }) {
    return InputNicknameState(
      nameController: nameController ?? this.nameController,
      inputNicknameModelObj:
          inputNicknameModelObj ?? this.inputNicknameModelObj,
      isConnected: isConnected ?? this.isConnected,
      error: error ?? this.error,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      roomId: roomId ?? this.roomId,
      roomPin: roomPin ?? this.roomPin,
    );
  }
}

enum ConnectionStatus {
  connecting,
  disconnected,
  error,
  joined,
}
