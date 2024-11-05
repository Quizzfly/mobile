part of 'enter_pin_bloc.dart';

class EnterPinState extends Equatable {
  final EnterPinModel? enterPinModelObj;
  final EnterPinTabModel? enterPinTabModelObj;
  final bool isConnected;
  final String? error;
  final ConnectionStatus connectionStatus;
  final String? roomId;

  EnterPinState({
    this.enterPinModelObj,
    this.enterPinTabModelObj,
    this.isConnected = false,
    this.error,
    this.connectionStatus = ConnectionStatus.disconnected,
    this.roomId,
  });

  @override
  List<Object?> get props => [
        enterPinTabModelObj,
        enterPinModelObj,
        isConnected,
        error,
        connectionStatus,
        roomId,
      ];

  EnterPinState copyWith({
    EnterPinTabModel? enterPinTabModelObj,
    EnterPinModel? enterPinModelObj,
    bool? isConnected,
    String? error,
    ConnectionStatus? connectionStatus,
    String? roomId,
  }) {
    return EnterPinState(
      enterPinTabModelObj: enterPinTabModelObj ?? this.enterPinTabModelObj,
      enterPinModelObj: enterPinModelObj ?? this.enterPinModelObj,
      isConnected: isConnected ?? this.isConnected,
      error: error,
      connectionStatus: connectionStatus ?? this.connectionStatus,
      roomId: roomId ?? this.roomId,
    );
  }
}

enum ConnectionStatus {
  connecting,
  connected,
  disconnected,
  error,
  joined,
}