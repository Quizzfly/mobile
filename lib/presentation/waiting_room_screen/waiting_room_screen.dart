import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../room_quiz_screen/room_quiz_screen.dart';
import 'bloc/waiting_room_bloc.dart';
import 'models/waiting_room_model.dart';

class WaitingRoomScreen extends StatefulWidget {
  WaitingRoomScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<WaitingRoomBloc>(
      create: (context) => WaitingRoomBloc(WaitingRoomState(
        inputNicknameModelObj: WaitingRoomModel(),
      ))
        ..add(WaitingRoomInitialEvent()),
      child: WaitingRoomScreen(),
    );
  }

  @override
  State<WaitingRoomScreen> createState() => _WaitingRoomScreenState();
}

class _WaitingRoomScreenState extends State<WaitingRoomScreen> {
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<WaitingRoomBloc, WaitingRoomState>(
      listener: (context, state) {
        if (state.connectionStatus == ConnectionStatus.quizStarted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RoomQuizScreen.builder(context),
            ),
          );
        }
      },
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          resizeToAvoidBottomInset: false,
          body: Container(
            width: double.maxFinite,
            height: SizeUtils.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  ImageConstant.imgBackground1,
                ),
                fit: BoxFit.fill,
              ),
            ),
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 15.h, top: 12.h),
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => NavigatorService.goBack(),
                      child: Container(
                        padding: EdgeInsets.all(10.h),
                        child: Image.asset(
                          ImageConstant.imgClose,
                          width: 24.h,
                          height: 24.h,
                          color: appTheme.whiteA700,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 150.h),
                    padding: EdgeInsets.symmetric(horizontal: 22.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [_buildContentColumn(context)],
                    ),
                  ),
                  BlocBuilder<WaitingRoomBloc, WaitingRoomState>(
                    builder: (context, state) {
                      if (state.connectionStatus ==
                          ConnectionStatus.connecting) {
                        return Column(
                          children: [
                            SizedBox(height: 30.h),
                            CircularProgressIndicator(
                              color: appTheme.whiteA700,
                            ),
                            SizedBox(height: 20.h),
                            Text(
                              "Waiting for quiz to start...",
                              style: CustomTextStyles.titleLargeWhiteA700,
                            ),
                          ],
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildContentColumn(BuildContext context) {
    return Container(
      width: double.maxFinite,
      padding: EdgeInsets.symmetric(horizontal: 38.h),
      child: Column(
        children: [
          SizedBox(
            width: double.maxFinite,
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  margin: EdgeInsets.only(
                    left: 52.h,
                    right: 46.h,
                  ),
                  child: Column(
                    children: [
                      CustomImageView(
                        imagePath: ImageConstant.imageBackToSchool,
                        height: 116.h,
                        width: double.maxFinite,
                        radius: BorderRadius.circular(
                          10.h,
                        ),
                        margin: EdgeInsets.symmetric(horizontal: 18.h),
                      ),
                      SizedBox(height: 22.h),
                      BlocSelector<WaitingRoomBloc, WaitingRoomState, String?>(
                        selector: (state) => state.nameController?.text,
                        builder: (context, name) {
                          return Text(
                            name ?? "",
                            style: CustomTextStyles.graphikwhiteA700SemiBold,
                          );
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                Align(
                  alignment: Alignment.centerRight,
                  child: Text(
                    "msg_you_re_in_see_your".tr,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: CustomTextStyles.bodyMediumRobotoWhiteA700,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
