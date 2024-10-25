import 'package:flutter/material.dart';
import '../../core/app_export.dart';
import '../../routes/navigation_args.dart';
import '../../theme/custom_button_style.dart';
import '../../widgets/custom_elevated_button.dart';
import '../../widgets/custom_outlined_button.dart';
import '../library_collections_screen/library_collections_screen.dart';
import '../library_screen/bloc/library_bloc.dart';
import '../library_screen/models/library_model.dart';
import '../library_screen/models/library_list_item_model.dart';
import '../library_screen/widgets/library_list_item_widget.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({Key? key})
      : super(
          key: key,
        );
  static Widget builder(BuildContext context) {
    return BlocProvider<LibraryBloc>(
      create: (context) => LibraryBloc(LibraryState(
        libraryModelObj: LibraryModel(),
      ))
        ..add(LibraryInitialEvent()),
      child: LibraryScreen(),
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
          padding: EdgeInsets.symmetric(horizontal: 18.h),
          decoration: BoxDecoration(
            color: appTheme.whiteA700,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              _buildQuizzflyRow(context),
              SizedBox(height: 24.h),
              Text(
                "lbl_45_quizzfly".tr,
                style: CustomTextStyles.titleMediumRobotoBlack900,
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: _buildLibraryList(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildQuizzflyButton(BuildContext context) {
    return Expanded(
      child: CustomElevatedButton(
        text: "lbl_quizzfly".tr,
        buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
      ),
    );
  }

  /// Section Widget
  Widget _buildCollectionsButton(BuildContext context) {
    return Expanded(
      child: CustomOutlinedButton(
        text: "lbl_collections".tr,
        buttonStyle: CustomButtonStyles.fillWhiteRadius20,
        onPressed: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => LibraryCollectionsScreen.builder(context),
            ),
          );
        },
      ),
    );
  }

  /// Section Widget
  Widget _buildQuizzflyRow(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: EdgeInsets.only(right: 8.h),
      child: Row(
        children: [
          _buildQuizzflyButton(context),
          SizedBox(width: 20.h),
          _buildCollectionsButton(context)
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildLibraryList(BuildContext context) {
    return BlocSelector<LibraryBloc, LibraryState, LibraryModel?>(
      selector: (state) => state.libraryModelObj,
      builder: (context, libraryModelObj) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15.h,
            );
          },
          itemCount: libraryModelObj?.libraryListItemList.length ?? 0,
          itemBuilder: (context, index) {
            LibraryListItemModel model =
                libraryModelObj?.libraryListItemList[index] ??
                    LibraryListItemModel();
            return LibraryListItemWidget(
              model,
              callDetail: () {
                callDetail(context, index);
              },
            );
          },
        );
      },
    );
  }

  /// Navigates to the quizzflyDetailScreen when the action is triggered.
  callDetail(BuildContext context, int index) {
    NavigatorService.pushNamed(AppRoutes.quizzflyDetailScreen, arguments: {
      NavigationArgs.id:
          context.read<LibraryBloc>().getLibraryResp.data?[index].id,
    });
  }
}
