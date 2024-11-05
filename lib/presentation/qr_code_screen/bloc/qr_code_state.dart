part of 'qr_code_bloc.dart';

/// Represents the state of QrCode in the application.
// ignore_for_file: must_be_immutable
class QrCodeState extends Equatable {
  QrCodeState({this.qrCodeTabModelObj, this.qrCodeModelObj});
  QrCodeModel? qrCodeModelObj;
  QrCodeTabModel? qrCodeTabModelObj;
  @override
  List<Object?> get props => [qrCodeTabModelObj, qrCodeModelObj];
  QrCodeState copyWith({
    QrCodeTabModel? qrCodeTabModelObj,
    QrCodeModel? qrCodeModelObj,
  }) {
    return QrCodeState(
      qrCodeTabModelObj: qrCodeTabModelObj ?? this.qrCodeTabModelObj,
      qrCodeModelObj: qrCodeModelObj ?? this.qrCodeModelObj,
    );
  }
}
