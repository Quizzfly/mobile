import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/grid_label_item_model.dart';

// ignore_for_file: must_be_immutable
class GridLabelItemWidget extends StatelessWidget {
  GridLabelItemWidget(this.gridLabelItemModelObj, {super.key});
  GridLabelItemModel gridLabelItemModelObj;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomImageView(
          imagePath: gridLabelItemModelObj.image!,
          height: 50.h,
          width: double.maxFinite,
          margin: EdgeInsets.only(
            left: 12.h,
            right: 10.h,
          ),
        ),
        Text(
          gridLabelItemModelObj.label!,
          style: CustomTextStyles.bodyMediumRobotoBlueGray300,
        )
      ],
    );
  }
}
