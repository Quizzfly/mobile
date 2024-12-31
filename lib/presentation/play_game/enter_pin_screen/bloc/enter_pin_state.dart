part of 'enter_pin_bloc.dart';

class EnterPinState extends Equatable {
  final EnterPinModel? enterPinModelObj;
  final EnterPinTabModel? enterPinTabModelObj;
  final TextEditingController? pinController;

  const EnterPinState({
    this.enterPinModelObj,
    this.enterPinTabModelObj,
    this.pinController,
  });

  @override
  List<Object?> get props => [
        enterPinTabModelObj,
        enterPinModelObj,
        pinController,
      ];

  EnterPinState copyWith({
    EnterPinTabModel? enterPinTabModelObj,
    EnterPinModel? enterPinModelObj,
    TextEditingController? pinController,
  }) {
    return EnterPinState(
      enterPinTabModelObj: enterPinTabModelObj ?? this.enterPinTabModelObj,
      enterPinModelObj: enterPinModelObj ?? this.enterPinModelObj,
      pinController: pinController ?? this.pinController,
    );
  }
}
