import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/core/app_export.dart';
import 'package:shimmer/shimmer.dart';

class CommentShimmerLoading extends StatelessWidget {
  const CommentShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: appTheme.gray300,
      highlightColor: appTheme.gray100,
      child: ListView.separated(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: 3,
        separatorBuilder: (context, index) => SizedBox(height: 26.h),
        itemBuilder: (_, __) => Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 32.h,
              height: 32.h,
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                shape: BoxShape.circle,
              ),
            ),
            SizedBox(width: 8.h),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 80.h,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      borderRadius: BorderRadius.circular(20.h),
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    children: [
                      Container(
                        width: 20.h,
                        height: 20.h,
                        color: appTheme.whiteA700,
                      ),
                      SizedBox(width: 8.h),
                      Container(
                        width: 30.h,
                        height: 16.h,
                        decoration: BoxDecoration(
                          color: appTheme.whiteA700,
                          borderRadius: BorderRadius.circular(4.h),
                        ),
                      ),
                    ],
                  ),
                  if (__ == 0) ...[
                    SizedBox(height: 16.h),
                    _buildReplyShimmer(),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReplyShimmer() {
    return Padding(
      padding: EdgeInsets.only(left: 40.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 24.h,
            height: 24.h,
            decoration: BoxDecoration(
              color: appTheme.whiteA700,
              shape: BoxShape.circle,
            ),
          ),
          SizedBox(width: 8.h),
          Expanded(
            child: Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: appTheme.whiteA700,
                borderRadius: BorderRadius.circular(20.h),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
