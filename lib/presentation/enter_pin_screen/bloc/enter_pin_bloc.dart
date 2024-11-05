import 'package:equatable/equatable.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../../core/app_export.dart';
import '../models/enter_pin_model.dart';
import '../models/enter_pin_tab_model.dart';
part 'enter_pin_event.dart';
part 'enter_pin_state.dart';

/// A bloc that manages the state of a EnterPin according to the event that is dispatched to it.
class EnterPinBloc extends Bloc<EnterPinEvent, EnterPinState> {
  late IO.Socket socket;

  EnterPinBloc(super.initialState) {
    on<EnterPinInitialEvent>(_onInitialize);
    on<JoinRoomEvent>(_onJoinRoom);
    on<SocketConnectedEvent>(_onSocketConnected);
    on<RoomJoinedEvent>(_onRoomJoined);
    on<SocketErrorEvent>(_onSocketError);
  }

  void _initializeSocket() {
    socket = IO.io('https://api.quizzfly.site/rooms', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': true,
    });

    socket.onConnect((_) {
      add(SocketConnectedEvent());
    });

    socket.onError((error) {
      add(SocketErrorEvent(error.toString()));
    });

    socket.on('error', (error) {
      add(SocketErrorEvent(error.toString()));
    });
  }

  void _onInitialize(
    EnterPinInitialEvent event,
    Emitter<EnterPinState> emit,
  ) async {
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.disconnected,
    ));
    _initializeSocket();
  }

  void _onJoinRoom(
    JoinRoomEvent event,
    Emitter<EnterPinState> emit,
  ) async {
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.connecting,
    ));

    socket.emit('joinRoom', {
      'roomPin': event.pin,
      'name': event.name,
    });
  }

  void _onSocketConnected(
    SocketConnectedEvent event,
    Emitter<EnterPinState> emit,
  ) {
    emit(state.copyWith(
        isConnected: true,
        connectionStatus: ConnectionStatus.connected,
        error: null));
  }

  void _onSocketError(
    SocketErrorEvent event,
    Emitter<EnterPinState> emit,
  ) {
    emit(state.copyWith(
      error: event.error,
      connectionStatus: ConnectionStatus.error,
    ));
  }

  void _onRoomJoined(
    RoomJoinedEvent event,
    Emitter<EnterPinState> emit,
  ) {
    emit(state.copyWith(
      connectionStatus: ConnectionStatus.joined,
    ));
  }

  @override
  Future<void> close() {
    socket.dispose();
    return super.close();
  }
}
