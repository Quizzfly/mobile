import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../library_collections_screen/models/library_collections_grid_item_model.dart';

// ignore_for_file: must_be_immutable
class LibraryCollectionsGridItemWidget extends StatelessWidget {
  LibraryCollectionsGridItemWidget(this.libraryCollectionsGridItemModelObj,
      {Key? key})
      : super(
          key: key,
        );
  LibraryCollectionsGridItemModel libraryCollectionsGridItemModelObj;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106.h,
      child: Stack(
        alignment: Alignment.center,
        children: [
          CustomImageView(
            imagePath: ImageConstant.imageEducation,
            height: 106.h,
            width: double.maxFinite,
            radius: BorderRadius.circular(
              10.h,
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                left: 8.h,
                bottom: 8.h,
              ),
              child: Text(
                libraryCollectionsGridItemModelObj.educationTwo!,
                style: CustomTextStyles.bodyMediumRobotoWhiteA700,
              ),
            ),
          )
        ],
      ),
    );
  }
}
