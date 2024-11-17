import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../bloc/room_quiz_bloc.dart';
import '../models/quiz_grid_item_model.dart';

class QuizGridItemWidget extends StatelessWidget {
  const QuizGridItemWidget(this.quizGridItemModelObj, this.index, {super.key});

  final QuizGridItemModel quizGridItemModelObj;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomQuizBloc, RoomQuizState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Container(
            height:
                state.roomQuizModelObj?.quizType?.toUpperCase() == 'TRUE_FALSE'
                    ? 650.h 
                    : 320.h,
            decoration: BoxDecoration(
              color: appTheme.whiteA700.withOpacity(0.1),
              borderRadius: BorderRadiusStyle.circleBorder12,
            ),
            child: const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            ),
          );
        }

        bool isTrueFalse =
            state.roomQuizModelObj?.quizType?.toUpperCase() == 'TRUE_FALSE';

        return InkWell(
          onTap: () {
            context.read<RoomQuizBloc>().add(QuizItemTappedEvent(index));
          },
          child: Container(
            height: isTrueFalse ? 650.h : 320.h, 
            width: isTrueFalse ? 170.h : null,
            decoration: BoxDecoration(
              color: quizGridItemModelObj.backgroundColor,
              borderRadius: BorderRadiusStyle.circleBorder12,
              border: quizGridItemModelObj.isSelected
                  ? Border.all(color: Colors.white, width: 3)
                  : null,
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  quizGridItemModelObj.textAnswer!,
                  style: CustomTextStyles.titleMediumWhiteA700Bold.copyWith(
                    fontSize: isTrueFalse
                        ? 24.fSize
                        : null, 
                  ),
                  textAlign: TextAlign.center,
                ),
                if (quizGridItemModelObj.isSelected)
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.rectangle,
                      ),
                      child: Icon(
                        Icons.check,
                        color: quizGridItemModelObj.backgroundColor,
                        size: 20,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
