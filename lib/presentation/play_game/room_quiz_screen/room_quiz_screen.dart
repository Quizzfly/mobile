import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import 'package:rive/rive.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/app_bar/appbar_leading_image.dart';
import '../../../../widgets/app_bar/appbar_title.dart';
import '../../../../widgets/app_bar/custom_app_bar.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_icon_button.dart';
import 'bloc/room_quiz_bloc.dart';
import 'models/quiz_grid_item_model.dart';
import 'models/room_quiz_model.dart';
import 'widgets/countdown_timer_widget.dart';
import 'widgets/quiz_grid_item_widget.dart';
import 'models/users_rank_list_item_model.dart';
import 'widgets/users_rank_list_item_widget.dart';

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
    return BlocConsumer<RoomQuizBloc, RoomQuizState>(
        listener: (context, state) {
      if (state.connectionStatus == ConnectionStatus.error) {
        showTopSnackBar(
          Overlay.of(context),
          CustomSnackBar.error(
            message: state.error ?? 'An error occurred',
          ),
        );
        NavigatorService.pushNamedAndRemoveUntil(
          AppRoutes.homeScreen,
        );
      }
    }, builder: (context, state) {
      if (state.showLeaderboard) {
        return _leaderBoard(context);
      }

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
    });
  }

  PreferredSizeWidget _buildAppbar(BuildContext context) {
    return CustomAppBar(
      height: 56.h,
      leadingWidth: 65.h,
      // leading: BlocSelector<RoomQuizBloc, RoomQuizState, RoomQuizModel?>(
      //   selector: (state) => state.roomQuizModelObj,
      //   builder: (context, modelQuestion) {
      //     return Container(
      //       margin: EdgeInsets.only(left: 24.h),
      //       width: 40.h,
      //       height: 40.h,
      //       decoration: BoxDecoration(
      //         color: appTheme.whiteA700.withOpacity(0.5),
      //         shape: BoxShape.circle,
      //       ),
      //       child: Center(
      //         child: Text(
      //             "${modelQuestion?.currentQuestionNumber}/${modelQuestion?.numberQuestion ?? 1}",
      //             style: CustomTextStyles.titleMediumRobotoBlack900),
      //       ),
      //     );
      //   },
      // ),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 150.h,
                    width: 150.h,
                    child: RiveAnimation.asset(
                      ImageConstant.riveLoadingPlay,
                      fit: BoxFit.cover,
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    "lbl_your_answer_is_processed".tr,
                    style: CustomTextStyles.titleLargeWhiteA700,
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            );
          }

          if (state.showResult) {
            return Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                  CustomImageView(
                      height: 150.h,
                      width: 150.h,
                      imagePath: state.isCorrect ?? false
                          ? ImageConstant.imgCheck
                          : ImageConstant.imgWrong),
                  Text(
                    state.isCorrect ?? false
                        ? "lbl_good_job".tr
                        : "lbl_wrong_answer".tr,
                    style: CustomTextStyles.titleLargeWhiteA700,
                  )
                ]));
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
                buttonStyle: CustomButtonStyles.fillDeepPurpleTL12,
                buttonTextStyle: CustomTextStyles.titleMediumWhiteA700Bold,
              );
            },
          ),
          const Spacer(flex: 22),
        ],
      ),
    );
  }

  Widget _leaderBoard(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.colorScheme.primary,
        appBar: _buildAppBar(context),
        body: Stack(
          children: [
            Column(
              children: [
                _buildPodiumSection(context),
                SizedBox(height: 80.h),
              ],
            ),
            Positioned(
              top: 380.h,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: appTheme.gray10001,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(24.h),
                    topRight: Radius.circular(24.h),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 8.h),
                      width: 40.h,
                      height: 4.h,
                      decoration: BoxDecoration(
                        color: appTheme.gray400,
                        borderRadius: BorderRadius.circular(2.h),
                      ),
                    ),
                    Expanded(
                      child: _buildUsersRankList(context),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return CustomAppBar(
      leadingWidth: 20.h,
      height: 50.h,
      padding: EdgeInsets.only(left: 25.h),
      leading: AppBarLeadingImage(
        imagePath: ImageConstant.imgTurnBack,
        color: appTheme.whiteA700,
        onTap: () => AppRoutes.navigateToHomeScreen(context),
      ),
      centerTitle: true,
      title: AppBarTitle(
        text: "lbl_leader_board".tr,
        textColor: appTheme.whiteA700,
        padding: EdgeInsets.only(right: 20.h),
      ),
    );
  }

  Widget _buildPodiumSection(BuildContext context) {
    return BlocBuilder<RoomQuizBloc, RoomQuizState>(
      builder: (context, state) {
        final topPlayers =
            state.roomQuizModelObj?.usersRankListItem.take(3).toList() ?? [];
        if (topPlayers.isEmpty) return const SizedBox();

        final screenWidth = MediaQuery.of(context).size.width;
        final podiumWidth = (screenWidth - 50.h) / 3;

        return Container(
          padding: EdgeInsets.symmetric(horizontal: 15.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (topPlayers.length > 1)
                SizedBox(
                  width: podiumWidth,
                  child: _buildPodiumPlayer(
                    topPlayers[1],
                    ImageConstant.imgSilver,
                    200.h,
                    podiumWidth,
                    2,
                  ),
                ),
              if (topPlayers.isNotEmpty)
                SizedBox(
                  width: podiumWidth,
                  child: _buildPodiumPlayer(
                    topPlayers[0],
                    ImageConstant.imgGold,
                    250.h,
                    podiumWidth,
                    1,
                  ),
                ),
              if (topPlayers.length > 2)
                SizedBox(
                  width: podiumWidth,
                  child: _buildPodiumPlayer(
                    topPlayers[2],
                    ImageConstant.imgBronze,
                    170.h,
                    podiumWidth,
                    3,
                  ),
                )
              else if (topPlayers.length > 1)
                SizedBox(width: podiumWidth),
            ],
          ),
        );
      },
    );
  }

  Widget _buildUsersRankList(BuildContext context) {
    return BlocBuilder<RoomQuizBloc, RoomQuizState>(
      builder: (context, state) {
        final players =
            state.roomQuizModelObj?.usersRankListItem.toList() ?? [];

        return Container(
          decoration: BoxDecoration(
            color: appTheme.gray10001,
            borderRadius: BorderRadius.circular(12.h),
          ),
          padding: EdgeInsets.symmetric(
            horizontal: 16.h,
            vertical: 12.h,
          ),
          child: ListView.separated(
            padding: EdgeInsets.zero,
            physics: const BouncingScrollPhysics(),
            separatorBuilder: (context, index) {
              return SizedBox(height: 10.h);
            },
            itemCount: players.length,
            itemBuilder: (context, index) {
              return UsersRankListItemWidget(players[index]);
            },
          ),
        );
      },
    );
  }

  Widget _buildPodiumPlayer(
    UsersRankListItemModel player,
    String medalImage,
    double podiumHeight,
    double podiumWidth,
    int rank,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 100.h,
          margin: EdgeInsets.symmetric(horizontal: 8.h),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              CustomIconButton(
                height: 56.h,
                width: 56.h,
                decoration: IconButtonStyleHelper.fillTeal,
                child: CustomImageView(
                  imagePath: player.imageAvatar,
                  radius: BorderRadius.circular(30.h),
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: SizedBox(
                  height: 50.h,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CustomImageView(
                        imagePath: medalImage,
                        height: 50.h,
                        width: 50.h,
                        radius: BorderRadius.circular(4.h),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          player.nickName ?? "",
          style: CustomTextStyles.titleMediumWhiteA700,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(height: 6.h),
        CustomElevatedButton(
          height: 34.h,
          width: 56.h,
          text: "${player.score}",
          buttonStyle: CustomButtonStyles.fillDeepPurple50TL12,
          buttonTextStyle: CustomTextStyles.labelLargeWhiteA700Bold,
        ),
        SizedBox(height: 8.h),
        Container(
          width: podiumWidth,
          height: podiumHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(_getPodiumImage(rank)),
              fit: BoxFit.fill,
            ),
          ),
        ),
      ],
    );
  }

  String _getPodiumImage(int rank) {
    switch (rank) {
      case 1:
        return ImageConstant.imgRank1;
      case 2:
        return ImageConstant.imgRank2;
      case 3:
        return ImageConstant.imgRank3;
      default:
        return ImageConstant.imgBackground1;
    }
  }
}
