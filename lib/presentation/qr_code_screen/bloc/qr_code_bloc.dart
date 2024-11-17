import 'package:equatable/equatable.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../core/app_export.dart';
import '../models/qr_code_model.dart';
import '../models/qr_code_tab_model.dart';
part 'qr_code_event.dart';
part 'qr_code_state.dart';

class QrCodeBloc extends Bloc<QrCodeEvent, QrCodeState> {
  final _cameraController = MobileScannerController();
  MobileScannerController get cameraController => _cameraController;

  QrCodeBloc(super.initialState) {
    on<QrCodeInitialEvent>(_onInitialize);
  
  }

  _onInitialize(
    QrCodeInitialEvent event,
    Emitter<QrCodeState> emit,
  ) async {
    emit(state.copyWith(
    ));
  }
}
