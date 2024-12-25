import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/app_export.dart';
import '../../../../routes/navigation_args.dart';
import 'bloc/library_bloc.dart';
import 'models/library_model.dart';
import 'models/library_list_item_model.dart';
import 'widgets/library_list_item_widget.dart';

class LibraryScreen extends StatelessWidget {
  const LibraryScreen({super.key});
  static Widget builder(BuildContext context) {
    return BlocProvider<LibraryBloc>(
      create: (context) => LibraryBloc(LibraryState(
        libraryModelObj: LibraryModel(),
      ))
        ..add(LibraryInitialEvent()),
      child: const LibraryScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: appTheme.whiteA700,
        resizeToAvoidBottomInset: false,
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(kToolbarHeight),
          child: Container(
            padding: EdgeInsets.only(left: 5.h, top: 16.h),
            color: appTheme.whiteA700,
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              leading: Padding(
                  padding: EdgeInsets.only(left: 16.h),
                  child: const Icon(Icons.grid_view_rounded)),
              leadingWidth: 25.h,
              titleSpacing: 25.h,
              title: const Text(
                'Library',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
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
              SizedBox(height: 24.h),
              BlocSelector<LibraryBloc, LibraryState, LibraryModel?>(
                selector: (state) => state.libraryModelObj,
                builder: (context, libraryModelObj) {
                  return Text(
                    "${libraryModelObj?.quizCount ?? 0} Quizzfly",
                    style: CustomTextStyles.titleMediumRobotoBlack900,
                  );
                },
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
  Widget _buildLibraryList(BuildContext context) {
    return BlocSelector<LibraryBloc, LibraryState, LibraryModel?>(
      selector: (state) => state.libraryModelObj,
      builder: (context, libraryModelObj) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15.h,
            );
          },
          itemCount: libraryModelObj?.libraryListItemList.length ?? 0,
          itemBuilder: (context, index) {
            LibraryListItemModel model =
                libraryModelObj?.libraryListItemList[index] ??
                    const LibraryListItemModel();
            return LibraryListItemWidget(
              model,
              callDetail: () {
                callDetail(context, index);
              },
              onDelete: (String id) {
                callAPIDelete(context, id);
              },
            );
          },
        );
      },
    );
  }

  /// Navigates to the quizzflyDetailScreen when the action is triggered.
  callDetail(BuildContext context, int index) async {
    final refreshRequired = await NavigatorService.pushNamed(
      AppRoutes.quizzflyDetailScreen,
      arguments: {
        NavigationArgs.id:
            context.read<LibraryBloc>().getLibraryResp.data?[index].id,
        NavigationArgs.heroTag:
            'library_cover_image_${context.read<LibraryBloc>().getLibraryResp.data?[index].id}',
      },
    );

    // If returned value is true, refresh the library data
    if (refreshRequired == true) {
      context.read<LibraryBloc>().add(
            CreateGetLibraryEvent(
              onGetLibrarySuccess: () {},
              onGetLibraryError: () {},
            ),
          );
    }
  }

  callAPIDelete(BuildContext context, String id) {
    context.read<LibraryBloc>().add(
          DeleteQuizzflyEvent(
            id: id,
            onDeleteQuizzflyEventSuccess: () {
              _onDeleteQuizzflyApiEventSuccess(context);
            },
            onDeleteQuizzflyEventError: () {
              _onDeleteQuizzflyApiEventError(context);
            },
          ),
        );
  }

  void _onDeleteQuizzflyApiEventSuccess(BuildContext context) {
    context.read<LibraryBloc>().add(CreateGetLibraryEvent(
      onGetLibrarySuccess: () {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Delete succeed',
          ),
        );
      },
    ));
  }

  void _onDeleteQuizzflyApiEventError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Delete failed',
      ),
    );
  }
}
