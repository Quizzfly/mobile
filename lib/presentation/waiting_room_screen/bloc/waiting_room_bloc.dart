import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/waiting_room_model.dart';
part 'waiting_room_event.dart';
part 'waiting_room_state.dart';

/// A bloc that manages the state of a WaitingRoom according to the event that is dispatched to it.
class WaitingRoomBloc extends Bloc<WaitingRoomEvent, WaitingRoomState> {
  WaitingRoomBloc(WaitingRoomState initialState) : super(initialState) {
    on<WaitingRoomInitialEvent>(_onInitialize);
  }
  _onInitialize(
    WaitingRoomInitialEvent event,
    Emitter<WaitingRoomState> emit,
  ) async {
    emit(
      state.copyWith(
        nameController: TextEditingController(),
      ),
    );
  }
}
