import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/enter_pin_bloc.dart';
import 'models/enter_pin_tab_model.dart';

class EnterPinTabPage extends StatefulWidget {
  const EnterPinTabPage({super.key});

  @override
  EnterPinTabPageState createState() => EnterPinTabPageState();

  static Widget builder(BuildContext context) {
    return BlocProvider<EnterPinBloc>(
      create: (context) => EnterPinBloc(EnterPinState(
        enterPinTabModelObj: EnterPinTabModel(),
      ))
        ..add(EnterPinInitialEvent()),
      child: const EnterPinTabPage(),
    );
  }
}

class EnterPinTabPageState extends State<EnterPinTabPage> {
  TextEditingController pinController = TextEditingController();
  String currentPin = "";
  void _showSnackBar(String message, bool isError) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? appTheme.red900 : Colors.green,
        duration: Duration(seconds: isError ? 3 : 2),
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<EnterPinBloc, EnterPinState>(
      listener: (context, state) {
        if (state.connectionStatus == ConnectionStatus.error) {
          _showSnackBar(state.error ?? 'An error occurred', true);
        } else if (state.connectionStatus == ConnectionStatus.joined) {
          _showSnackBar("Joined room ", false);
        }
      },
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: 28.h,
            vertical: 90.h,
          ),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: 70.h),
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        SizedBox(height: 40.h),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.h),
                          child: PinCodeTextField(
                            appContext: context,
                            length: 6,
                            obscureText: false,
                            animationType: AnimationType.fade,
                            pinTheme: PinTheme(
                              shape: PinCodeFieldShape.box,
                              borderRadius: BorderRadius.circular(10),
                              fieldHeight: 60,
                              fieldWidth: 45,
                              activeFillColor: Colors.transparent,
                              inactiveFillColor: Colors.transparent,
                              selectedFillColor: Colors.transparent,
                              activeColor: appTheme.whiteA700,
                              inactiveColor:
                                  appTheme.whiteA700.withOpacity(0.5),
                              selectedColor: appTheme.whiteA700,
                            ),
                            animationDuration:
                                const Duration(milliseconds: 300),
                            enableActiveFill: true,
                            controller: pinController,
                            keyboardType: TextInputType.number,
                            textStyle:
                                CustomTextStyles.graphikwhiteA700SemiBold,
                            cursorColor: appTheme.whiteA700,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onChanged: (value) {
                              setState(() {
                                currentPin = value;
                              });
                            },
                          ),
                        ),
                        SizedBox(height: 185.h),
                        CustomElevatedButton(
                          height: 55.h,
                          text: "lbl_join_now".tr,
                          buttonStyle: CustomButtonStyles.fillWhiteRadius20,
                          buttonTextStyle: CustomTextStyles.bodyLargePrimary,
                          onPressed: () {
                            if (currentPin.length == 6) {
                              context.read<EnterPinBloc>().add(
                                    JoinRoomEvent(
                                      pin: currentPin,
                                      name:
                                          "User", 
                                    ),
                                  );
                            }
                          },
                        ),
                        if (state.connectionStatus ==
                            ConnectionStatus.connecting)
                          const CircularProgressIndicator(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    pinController.dispose();
    super.dispose();
  }
}
