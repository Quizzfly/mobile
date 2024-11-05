import 'package:equatable/equatable.dart';
import '../../../core/app_export.dart';
import '../models/qr_code_model.dart';
import '../models/qr_code_tab_model.dart';
part 'qr_code_event.dart';
part 'qr_code_state.dart';

/// A bloc that manages the state of a QrCode according to the event that is dispatched to it.
class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  QrCodeBloc(super.initialState) {
    on<QrCodeInitialEvent>(_onInitialize);
  }
  _onInitialize(
    QrCodeInitialEvent event,
    Emitter<QrCodeState> emit,
  ) async {}
}
