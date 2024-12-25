import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../core/app_export.dart';

class CommunityShimmerLoading extends StatelessWidget {
  const CommunityShimmerLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: appTheme.gray300,
      highlightColor: appTheme.gray100,
      child: ListView.builder(
        itemCount: 3,
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, __) => Container(
          margin: const EdgeInsets.only(bottom: 16),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: appTheme.whiteA700,
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 16,
                          color: appTheme.whiteA700,
                        ),
                        const SizedBox(height: 8),
                        Container(
                          width: 100,
                          height: 12,
                          color: appTheme.whiteA700,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Container(
                width: double.infinity,
                height: 100,
                color: appTheme.whiteA700,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    width: 60,
                    height: 24,
                    color: appTheme.whiteA700,
                  ),
                  const SizedBox(width: 16),
                  Container(
                    width: 60,
                    height: 24,
                    color: appTheme.whiteA700,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
