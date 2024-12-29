// input_nickname_bloc.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../../../core/app_export.dart';
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

    // Create a completer to handle the join room response
    final completer = Completer<void>();

    void participantJoinedListener(data) {
      PrefUtils().setParticipantId(data['new_participant']['id']);
      PrefUtils().setNickname(state.nameController?.text ?? '');
      _socketService.socket.off('participantJoined', participantJoinedListener);

      // Complete successfully when participant joins
      if (!completer.isCompleted) {
        completer.complete();
        emit(state.copyWith(
          connectionStatus: ConnectionStatus.joined,
        ));
      }
    }

    void errorListener(dynamic error) {
      _socketService.socket.off('exception', errorListener);
      _socketService.socket.off('participantJoined', participantJoinedListener);

      // Complete with error
      if (!completer.isCompleted) {
        completer.completeError(error);
        add(SocketErrorEvent(error['message'].toString()));
      }
    }

    // Set up listeners
    _socketService.socket.on('participantJoined', participantJoinedListener);
    _socketService.socket.on('exception', errorListener);

    // Emit join room event
    _socketService.socket.emit('joinRoom', {
      'room_pin': state.roomPin,
      'nick_name': state.nameController?.text,
    });

    try {
      // Wait for either success or error
      await completer.future.timeout(
        const Duration(seconds: 10),
        onTimeout: () {
          throw {'message': 'Connection timeout'};
        },
      );
    } catch (error) {
      // Handle timeout or other errors
      _socketService.socket.off('exception', errorListener);
      _socketService.socket.off('participantJoined', participantJoinedListener);

      if (!completer.isCompleted) {
        add(SocketErrorEvent(
            error is Map ? error['message'].toString() : 'Connection failed'));
      }
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
