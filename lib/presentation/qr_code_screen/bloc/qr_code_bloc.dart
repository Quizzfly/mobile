import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/app_export.dart';
import '../models/qr_code_model.dart';
import '../models/qr_code_tab_model.dart';
part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  final _cameraController = MobileScannerController();
  late final IO.Socket _socket;
  MobileScannerController get cameraController => _cameraController;

  QrCodeBloc(super.initialState) {
    on<QrCodeInitialEvent>(_onInitialize);
    on<ScanQrCodeEvent>(_onScanQrCode);
    on<JoinRoomEvent>(_onJoinRoom);
    on<SocketConnectedEvent>(_onSocketConnected);
    on<SocketErrorEvent>(_onSocketError);
    on<RoomJoinedEvent>(_onRoomJoined);
  }

  _onInitialize(
    QrCodeInitialEvent event,
    Emitter<QrCodeState> emit,
  ) async {
    _initializeSocketConnection();
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.disconnected,
    ));
  }

  void _initializeSocketConnection() {
    _socket = IO.io('https://api.quizzfly.site/rooms', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    _socket.onConnect((_) {
      add(SocketConnectedEvent());
    });

    _socket.onError((error) {
      add(SocketErrorEvent(error.toString()));
    });

    _socket.on('error', (error) {
      add(SocketErrorEvent(error.toString()));
    });

    _socket.on('roomMembersJoin', (data) {
      add(RoomJoinedEvent(data.toString()));
    });
  }

  void _onSocketConnected(
    SocketConnectedEvent event,
    Emitter<QrCodeState> emit,
  ) {
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.connected,
      errorMessage: null,
    ));
  }

  void _onSocketError(
    SocketErrorEvent event,
    Emitter<QrCodeState> emit,
  ) {
    emit(state.copyWith(
      errorMessage: event.error,
      connectionStatus: ConnectionStatus.error,
      isJoiningRoom: false,
    ));
  }

  void _onRoomJoined(
    RoomJoinedEvent event,
    Emitter<QrCodeState> emit,
  ) {
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.joined,
      isJoiningRoom: false,
      isScanning: false,
    ));
  }

  void _onScanQrCode(ScanQrCodeEvent event, Emitter<QrCodeState> emit) {
    emit(state.copyWith(isScanning: true));
  }

  Future<void> _onJoinRoom(
      JoinRoomEvent event, Emitter<QrCodeState> emit) async {
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.connecting,
      errorMessage: null,
      isJoiningRoom: true,
    ));

    try {
      _socket.emit(
        'joinRoom',
        {'roomPin': event.roomPin, 'name': 'John Doe'},
      );
    } catch (e) {
      add(SocketErrorEvent(e.toString()));
    }
  }

  @override
  Future<void> close() {
    _cameraController.dispose();
    _socket.disconnect();
    return super.close();
  }
}
