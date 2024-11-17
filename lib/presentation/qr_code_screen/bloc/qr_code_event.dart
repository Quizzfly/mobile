part of 'qr_code_bloc.dart';

/// Abstract class for all events that can be dispatched from the
///QrCode widget.
///
/// Events must be immutable and implement the [Equatable] interface.
class QrCodeEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

/// Event that is dispatched when the QrCode widget is first created.
class QrCodeInitialEvent extends QrCodeEvent {
  @override
  List<Object?> get props => [];
}
