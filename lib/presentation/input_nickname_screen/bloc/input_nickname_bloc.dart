// input_nickname_bloc.dart
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/input_nickname_model.dart';
part 'input_nickname_event.dart';
part 'input_nickname_state.dart';

class InputNicknameBloc extends Bloc<InputNicknameEvent, InputNicknameState> {
  final SocketService _socketService = SocketService();

  InputNicknameBloc(super.initialState) {
    on<InputNicknameInitialEvent>(_onInitialize);
    on<JoinRoomEvent>(_onJoinRoom);
    on<SocketErrorEvent>(_onSocketError);
  }

  _onInitialize(
    InputNicknameInitialEvent event,
    Emitter<InputNicknameState> emit,
  ) async {
    emit(
      state.copyWith(
        nameController: TextEditingController(),
        connectionStatus: ConnectionStatus.disconnected,
      ),
    );
    _socketService.initializeSocket();
  }

  void _onJoinRoom(
    JoinRoomEvent event,
    Emitter<InputNicknameState> emit,
  ) async {
    emit(state.copyWith(
        connectionStatus: ConnectionStatus.connecting, error: null));
    PrefUtils().setRoomPin(state.roomPin ?? '');

    _socketService.socket.emit('joinRoom', {
      'roomPin': state.roomPin,
      'name': state.nameController?.text,
    });

    _socketService.socket.on('exception', (error) {
      add(SocketErrorEvent(error['message'].toString()));
    });

    if (state.error == null) {
      PrefUtils().setNickname(state.nameController?.text ?? '');
      emit(state.copyWith(
        connectionStatus: ConnectionStatus.joined,
      ));
    }
  }

  void _onSocketError(
    SocketErrorEvent event,
    Emitter<InputNicknameState> emit,
  ) {
    emit(state.copyWith(
      error: event.error,
      connectionStatus: ConnectionStatus.error,
    ));
  }
}
