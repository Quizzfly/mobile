import 'package:flutter/material.dart';
import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/input_nickname_model.dart';
part 'input_nickname_event.dart';
part 'input_nickname_state.dart';

/// A bloc that manages the state of a InputNickname according to the event that is dispatched to it.
class InputNicknameBloc extends Bloc<InputNicknameEvent, InputNicknameState> {
  InputNicknameBloc(InputNicknameState initialState) : super(initialState) {
    on<InputNicknameInitialEvent>(_onInitialize);
  }
  _onInitialize(
    InputNicknameInitialEvent event,
    Emitter<InputNicknameState> emit,
  ) async {
    emit(
      state.copyWith(
        nameController: TextEditingController(),
      ),
    );
  }
}
