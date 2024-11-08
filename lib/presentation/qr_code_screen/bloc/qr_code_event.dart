part of 'qr_code_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///QrCode widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class QrCodeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the QrCode widget is first created.
class QrCodeInitialEvent extends QrCodeEvent {
  @override
  List<Object?> get props => [];
}

class ScanQrCodeEvent extends QrCodeEvent {}

class JoinRoomEvent extends QrCodeEvent {
  final String roomPin;

  JoinRoomEvent(this.roomPin);

  @override
  List<Object> get props => [roomPin];
}

class SocketConnectedEvent extends QrCodeEvent {
  @override
  List<Object?> get props => [];
}

class SocketErrorEvent extends QrCodeEvent {
  final String error;

  SocketErrorEvent(this.error);
}

class RoomJoinedEvent extends QrCodeEvent {
  final String message;
  
  RoomJoinedEvent(this.message);
}
