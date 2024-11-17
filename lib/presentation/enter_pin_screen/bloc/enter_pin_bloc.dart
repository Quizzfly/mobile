import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/enter_pin_model.dart';
import '../models/enter_pin_tab_model.dart';
part 'enter_pin_event.dart';
part 'enter_pin_state.dart';

class EnterPinBloc extends Bloc<EnterPinEvent, EnterPinState> {
  EnterPinBloc(super.initialState) {
    on<EnterPinInitialEvent>(_onInitialize);
  }
  void _onInitialize(
    EnterPinInitialEvent event,
    Emitter<EnterPinState> emit,
  ) async {
    emit(state.copyWith(pinController: TextEditingController()));
  }
}
