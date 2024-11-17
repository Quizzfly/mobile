import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/app_bar/custom_app_bar.dart';
import '../../widgets/custom_elevated_button.dart';
import 'bloc/room_quiz_bloc.dart';
import 'models/quiz_grid_item_model.dart';
import 'models/room_quiz_model.dart';
import 'widgets/countdown_timer_widget.dart';
import 'widgets/quiz_grid_item_widget.dart';

class RoomQuizScreen extends StatelessWidget {
  const RoomQuizScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<RoomQuizBloc>(
      create: (context) =>
          RoomQuizBloc(RoomQuizState(roomQuizModelObj: RoomQuizModel()))
            ..add(RoomQuizInitialEvent()),
      child: const RoomQuizScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        extendBody: true,
        extendBodyBehindAppBar: true,
        appBar: _buildAppbar(context),
        body: Container(
          width: double.maxFinite,
          height: SizeUtils.height,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                ImageConstant.imgChristmasTree,
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              Expanded(
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(
                    left: 6.h,
                    top: 14.h,
                    right: 6.h,
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        child: Container(
                          width: double.maxFinite,
                          margin: EdgeInsets.only(left: 2.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            children: [_buildQuizGrid(context)],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: _buildUserInfoRow(context),
      ),
    );
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      height: 56.h,
      leadingWidth: 65.h,
      leading: Container(
        margin: EdgeInsets.only(left: 24.h),
        width: 40.h,
        height: 40.h,
        decoration: BoxDecoration(
          color: appTheme.whiteA700.withOpacity(0.5),
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Text("1", style: CustomTextStyles.titleMediumRobotoBlack900),
        ),
      ),
      centerTitle: true,
      title: BlocSelector<RoomQuizBloc, RoomQuizState, RoomQuizModel?>(
        selector: (state) => state.roomQuizModelObj,
        builder: (context, roomQuizModelObj) {
          String quizType = roomQuizModelObj?.quizType?.toUpperCase() ?? 'QUIZ';
          String displayText =
              quizType == 'TRUE_FALSE' ? 'TRUE/FALSE' : 'MULTIPLE CHOICE';

          return Container(
            padding: EdgeInsets.symmetric(horizontal: 24.h, vertical: 8.h),
            decoration: BoxDecoration(
              color: appTheme.whiteA700.withOpacity(0.5),
              borderRadius: BorderRadius.circular(20.h),
            ),
            child: Text(displayText,
                style: CustomTextStyles.titleMediumRobotoBlack900),
          );
        },
      ),
      actions: [
        BlocSelector<RoomQuizBloc, RoomQuizState, (RoomQuizModel?, bool)>(
          selector: (state) => (state.roomQuizModelObj, state.isTimerPaused),
          builder: (context, data) {
            final (roomQuizModelObj, isTimerPaused) = data;
            return CountdownTimer(
              key: ValueKey(roomQuizModelObj?.questionId),
              timeLimit: roomQuizModelObj?.timeLimit ?? 60,
              isPaused: isTimerPaused,
              onTimerComplete: () {
                context.read<RoomQuizBloc>().add(QuizTimeoutEvent());
              },
            );
          },
        ),
      ],
      styleType: Style.bgTransparent,
    );
  }

  Widget _buildQuizGrid(BuildContext context) {
    return Expanded(
      child: BlocBuilder<RoomQuizBloc, RoomQuizState>(
        builder: (context, state) {
          if (state.isWaiting) {
            return Center(
              child: SizedBox(
                width: 60.h,
                height: 60.h,
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 5,
                ),
              ),
            );
          }

          if (state.showResult) {
            return Center(
              child: Icon(
                state.isCorrect ?? false
                    ? Icons.check_circle_outline
                    : Icons.close,
                size: 120.h,
                color: state.isCorrect ?? false ? Colors.green : Colors.red,
              ),
            );
          }

          return BlocSelector<RoomQuizBloc, RoomQuizState, RoomQuizModel?>(
            selector: (state) => state.roomQuizModelObj,
            builder: (context, roomQuizModelObj) {
              bool isTrueFalse =
                  roomQuizModelObj?.quizType?.toUpperCase() == 'TRUE_FALSE';

              if (isTrueFalse) {
                return Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      roomQuizModelObj?.quizGridItemList.length ?? 0,
                      (index) {
                        QuizGridItemModel model =
                            roomQuizModelObj?.quizGridItemList[index] ??
                                QuizGridItemModel();
                        return Padding(
                          padding: EdgeInsets.symmetric(horizontal: 5.h),
                          child: QuizGridItemWidget(model, index),
                        );
                      },
                    ),
                  ),
                );
              }

              // Original layout for multiple choice questions
              return ResponsiveGridListBuilder(
                minItemWidth: 1,
                minItemsPerRow: 2,
                maxItemsPerRow: 2,
                horizontalGridSpacing: 10.h,
                verticalGridSpacing: 10.h,
                builder: (context, items) => ListView(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  children: items,
                ),
                gridItems: List.generate(
                  roomQuizModelObj?.quizGridItemList.length ?? 0,
                  (index) {
                    QuizGridItemModel model =
                        roomQuizModelObj?.quizGridItemList[index] ??
                            QuizGridItemModel();
                    return QuizGridItemWidget(model, index);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }

  Widget _buildUserInfoRow(BuildContext context) {
    final userName = PrefUtils().getNickname();
    final userAvatar = PrefUtils().getAvatar();

    return Container(
      height: 58.h,
      padding: EdgeInsets.symmetric(horizontal: 10.h),
      decoration: BoxDecoration(
        color: appTheme.whiteA700,
      ),
      width: double.maxFinite,
      child: Row(
        children: [
          if (userAvatar.isNotEmpty)
            ClipRRect(
              borderRadius: BorderRadius.circular(12.h),
              child: ClipOval(
                child: CustomImageView(
                  imagePath: userAvatar,
                  height: 55.h,
                  width: 55.h,
                  fit: BoxFit.cover,
                  radius: BorderRadius.zero,
                ),
              ),
            )
          else
            Container(
              height: 54.h,
              width: 56.h,
              decoration: BoxDecoration(
                color: appTheme.gray200,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  userName.isNotEmpty ? userName[0].toUpperCase() : "?",
                  style: CustomTextStyles.titleMediumRobotoBlack900,
                ),
              ),
            ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                bottom: 14.h,
              ),
              child: Text(
                userName,
                style: CustomTextStyles.titleMediumRobotoBlack900,
              ),
            ),
          ),
          const Spacer(flex: 77),
          BlocSelector<RoomQuizBloc, RoomQuizState, int?>(
            selector: (state) => state.totalScore,
            builder: (context, totalScore) {
              return CustomElevatedButton(
                height: 34.h,
                width: 82.h,
                text: totalScore.toString(),
                buttonStyle: CustomButtonStyles.fillBlackGray,
                buttonTextStyle: CustomTextStyles.titleMediumWhiteA700Bold,
              );
            },
          ),
          const Spacer(flex: 22),
        ],
      ),
    );
  }
}
