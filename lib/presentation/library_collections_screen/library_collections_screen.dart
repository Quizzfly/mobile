import 'package:flutter/material.dart';
import 'package:responsive_grid_list/responsive_grid_list.dart';
import '../../core/app_export.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_floating_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../library_collections_screen/bloc/library_collections_bloc.dart';
import '../library_collections_screen/models/library_collections_grid_item_model.dart';
import '../library_collections_screen/widgets/library_collections_grid_item_widget.dart';
import '../library_screen/library_screen.dart';
import 'models/library_collections_model.dart';

class LibraryCollectionsScreen extends StatelessWidget {
  const LibraryCollectionsScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<LibraryCollectionsBloc>(
      create: (context) => LibraryCollectionsBloc(LibraryCollectionsState(
        libraryCollectionsModelObj: LibraryCollectionsModel(),
      ))
        ..add(LibraryCollectionsInitialEvent()),
      child: const LibraryCollectionsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        body: Container(
          width: double.maxFinite,
          margin: EdgeInsets.only(top: 20.h),
          padding: EdgeInsets.symmetric(horizontal: 20.h),
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildNavigationButtons(context),
              SizedBox(height: 32.h),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(left: 12.h),
                  child: Text(
                    "lbl_7_collections".tr,
                    style: CustomTextStyles.titleMediumRobotoBlack900,
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              _buildLibraryCollectionsGrid(context),
              SizedBox(height: 44.h)
            ],
          ),
        ),
        floatingActionButton: _buildFloatingActionButton(context),
      ),
    );
  }

  /// Section Widget
  Widget _buildNavigationButtons(BuildContext context) {
    return SizedBox(
      width: double.maxFinite,
      child: Row(
        children: [
          Expanded(
            child: CustomOutlinedButton(
              text: "lbl_quizzfly".tr,
              buttonStyle: CustomButtonStyles.fillWhiteRadius30,
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LibraryScreen.builder(context),
                  ),
                );
              },
            ),
          ),
          SizedBox(width: 22.h),
          Expanded(
            child: CustomElevatedButton(
              text: "lbl_collections".tr,
              buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
            ),
          )
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLibraryCollectionsGrid(BuildContext context) {
    return Expanded(
      child: BlocSelector<LibraryCollectionsBloc, LibraryCollectionsState,
          LibraryCollectionsModel?>(
        selector: (state) => state.libraryCollectionsModelObj,
        builder: (context, libraryCollectionsModelObj) {
          return ResponsiveGridListBuilder(
            minItemWidth: 1,
            minItemsPerRow: 2,
            maxItemsPerRow: 2,
            horizontalGridSpacing: 20.h,
            verticalGridSpacing: 30.h,
            builder: (context, items) => ListView(
              shrinkWrap: true,
              padding: EdgeInsets.zero,
              physics: const BouncingScrollPhysics(),
              children: items,
            ),
            gridItems: List.generate(
              libraryCollectionsModelObj
                      ?.libraryCollectionsGridItemList.length ??
                  0,
              (index) {
                LibraryCollectionsGridItemModel model =
                    libraryCollectionsModelObj
                            ?.libraryCollectionsGridItemList[index] ??
                        LibraryCollectionsGridItemModel();
                return LibraryCollectionsGridItemWidget(
                  model,
                );
              },
            ),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return CustomFloatingButton(
        height: 48,
        width: 48,
        backgroundColor: appTheme.deppPurplePrimary,
        child: Icon(
          Icons.add,
          size: 30.h,
          color: appTheme.whiteA700,
        ));
  }
}
