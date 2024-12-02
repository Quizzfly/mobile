import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../../core/app_export.dart';
import '../../routes/navigation_args.dart';
import '../library_screen/bloc/library_bloc.dart';
import '../library_screen/models/library_model.dart';
import '../library_screen/models/library_list_item_model.dart';
import '../library_screen/widgets/library_list_item_widget.dart';

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
            'library_cover_image_${context.read<LibraryBloc>().getLibraryResp.data?[index].id}', // Thêm heroTag
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
    Fluttertoast.showToast(msg: "Delete succeed");
    // Refresh the list after successful deletion
    context.read<LibraryBloc>().add(CreateGetLibraryEvent(
      onGetLibrarySuccess: () {
        Fluttertoast.showToast(
          msg: "Delete succeed",
        );
      },
    ));
  }

  void _onDeleteQuizzflyApiEventError(BuildContext context) {
    Fluttertoast.showToast(msg: "Delete failed");
  }
}
