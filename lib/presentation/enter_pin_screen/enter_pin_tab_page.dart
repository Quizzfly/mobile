import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:quizzfly_application_flutter/routes/navigation_args.dart';
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
      create: (context) => EnterPinBloc(const EnterPinState(
        enterPinTabModelObj: EnterPinTabModel(),
      ))
        ..add(EnterPinInitialEvent()),
      child: const EnterPinTabPage(),
    );
  }
}

class EnterPinTabPageState extends State<EnterPinTabPage> {
  @override
  Widget build(BuildContext context) {
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
                    BlocSelector<EnterPinBloc, EnterPinState,
                        TextEditingController?>(
                      selector: (state) => state.pinController,
                      builder: (context, pinController) {
                        return Padding(
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
                                CustomTextStyles.graphikWhiteA700SemiBold,
                            cursorColor: appTheme.whiteA700,
                            onCompleted: (v) {
                              debugPrint("Completed");
                            },
                            onChanged: (value) {
                              pinController?.text = value;
                            },
                          ),
                        );
                      },
                    ),
                    SizedBox(height: 185.h),
                    BlocSelector<EnterPinBloc, EnterPinState,
                        TextEditingController?>(
                      selector: (state) => state.pinController,
                      builder: (context, pinController) {
                        return CustomElevatedButton(
                          height: 55.h,
                          text: "lbl_enter".tr,
                          buttonStyle: CustomButtonStyles.fillWhiteRadius30,
                          buttonTextStyle: CustomTextStyles.bodyLargePrimary,
                          onPressed: () {
                            if (pinController?.text.length == 6) {
                              NavigatorService.pushNamed(
                                  AppRoutes.inputNickname,
                                  arguments: {
                                    NavigationArgs.roomPin: pinController?.text
                                  });
                            }
                          },
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
