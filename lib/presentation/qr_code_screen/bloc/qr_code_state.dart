part of 'qr_code_bloc.dart';

class QrCodeState extends Equatable {
  QrCodeState({
    this.qrCodeTabModelObj,
    this.qrCodeModelObj,
    this.roomPin,
    this.isScanning = true,
    this.isJoiningRoom = false,
    this.errorMessage,
    this.connectionStatus = ConnectionStatus.disconnected,
  });

  final QrCodeModel? qrCodeModelObj;
  final QrCodeTabModel? qrCodeTabModelObj;
  final String? roomPin;
  final bool isScanning;
  final bool isJoiningRoom;
  final String? errorMessage;
  final ConnectionStatus connectionStatus;

  @override
  List<Object?> get props => [
        qrCodeTabModelObj,
        qrCodeModelObj,
        roomPin,
        isScanning,
        isJoiningRoom,
        errorMessage,
        connectionStatus,
      ];

  QrCodeState copyWith({
    QrCodeTabModel? qrCodeTabModelObj,
    QrCodeModel? qrCodeModelObj,
    String? roomPin,
    bool? isScanning,
    bool? isJoiningRoom,
    String? errorMessage,
    ConnectionStatus? connectionStatus,
  }) {
    return QrCodeState(
      qrCodeTabModelObj: qrCodeTabModelObj ?? this.qrCodeTabModelObj,
      qrCodeModelObj: qrCodeModelObj ?? this.qrCodeModelObj,
      roomPin: roomPin ?? this.roomPin,
      isScanning: isScanning ?? this.isScanning,
      isJoiningRoom: isJoiningRoom ?? this.isJoiningRoom,
      errorMessage: errorMessage ?? this.errorMessage,
      connectionStatus: connectionStatus ?? this.connectionStatus,
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
