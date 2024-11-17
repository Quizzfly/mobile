part of 'qr_code_bloc.dart';

class QrCodeState extends Equatable {
  QrCodeState(
      {this.qrCodeTabModelObj,
      this.qrCodeModelObj,
      this.isScanning = true,
      this.roomPin,
      this.mobileScannerController});

  final QrCodeModel? qrCodeModelObj;
  final QrCodeTabModel? qrCodeTabModelObj;
  final String? roomPin;
  final bool isScanning;
  final MobileScannerController? mobileScannerController;

  @override
  List<Object?> get props => [
        qrCodeTabModelObj,
        qrCodeModelObj,
        roomPin,
        isScanning,
        mobileScannerController
      ];

  QrCodeState copyWith({
    QrCodeTabModel? qrCodeTabModelObj,
    QrCodeModel? qrCodeModelObj,
    String? roomPin,
    bool? isScanning,
    MobileScannerController? mobileScannerController
  }) {
    return QrCodeState(
      qrCodeTabModelObj: qrCodeTabModelObj ?? this.qrCodeTabModelObj,
      qrCodeModelObj: qrCodeModelObj ?? this.qrCodeModelObj,
      roomPin: roomPin ?? this.roomPin,
      isScanning: isScanning ?? this.isScanning,
      mobileScannerController : mobileScannerController ?? this.mobileScannerController
    );
  }
}
