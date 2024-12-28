import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/app_export.dart';
import '../../../routes/navigation_args.dart';
import '../../../widgets/custom_outlined_button.dart';
import 'bloc/community_bloc.dart';
import 'models/community_list_item_model.dart';
import 'widgets/community_list_item_widget.dart';
import 'widgets/community_shimmer_loading.dart';
import 'widgets/create_bottom_sheet.dart';

class CommunityActivityTabPage extends StatelessWidget {
  const CommunityActivityTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CommunityShimmerLoading();
        }
        return CustomScrollView(
          slivers: [
            SliverAppBar(
              floating: true,
              pinned: false,
              expandedHeight: 50,
              backgroundColor: Colors.white,
              automaticallyImplyLeading: false,
              flexibleSpace: LayoutBuilder(
                builder: (BuildContext context, BoxConstraints constraints) {
                  bool isCollapsed =
                      constraints.maxHeight <= kToolbarHeight + 30;
                  return SingleChildScrollView(
                    child: isCollapsed
                        ? Container(
                            color: Colors.white,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 5),
                            child: Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundImage:
                                      NetworkImage(PrefUtils().getAvatar()),
                                  backgroundColor: Colors.transparent,
                                  // ignore: unnecessary_null_comparison
                                  child: PrefUtils().getAvatar() == null
                                      ? const Icon(Icons.person, size: 20)
                                      : null,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: CustomOutlinedButton(
                                    text: "Post something....",
                                    buttonStyle: OutlinedButton.styleFrom(
                                      backgroundColor: Colors.grey[100],
                                      alignment: Alignment.centerLeft,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      side: BorderSide(color: appTheme.gray200),
                                    ),
                                    buttonTextStyle: const TextStyle(
                                      color: Colors.grey,
                                      fontSize: 16,
                                    ),
                                    height: 40.h,
                                    onPressed: () =>
                                        _showPostBottomSheet(context),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.08),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                  offset: const Offset(1.01, 1.01),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        radius: 24,
                                        backgroundImage: NetworkImage(
                                            PrefUtils().getAvatar()),
                                        backgroundColor: Colors.transparent,
                                        // ignore: unnecessary_null_comparison
                                        child: PrefUtils().getAvatar() == null
                                            ? const Icon(Icons.person, size: 24)
                                            : null,
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomOutlinedButton(
                                          text: "Post something....",
                                          buttonStyle: OutlinedButton.styleFrom(
                                            backgroundColor: Colors.grey[100],
                                            alignment: Alignment.centerLeft,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                            ),
                                          ),
                                          buttonTextStyle: const TextStyle(
                                            color: Colors.grey,
                                            fontSize: 16,
                                          ),
                                          onPressed: () =>
                                              _showPostBottomSheet(context),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                  );
                },
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              sliver: SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    CommunityListItemModel model = state
                            .communityActivityTabModelObj
                            ?.communityListItemList[index] ??
                        CommunityListItemModel();
                    return Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: CommunityListItemWidget(
                        model,
                        index: index,
                        callDetail: () {
                          callDetail(context, index);
                        },
                        onDelete: (String id) {
                          callAPIDelete(context, id);
                        },
                      ),
                    );
                  },
                  childCount: state.communityActivityTabModelObj
                          ?.communityListItemList.length ??
                      0,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  callDetail(BuildContext context, int index) async {
    final result = await NavigatorService.pushNamed(
      AppRoutes.detailPostScreen,
      arguments: {
        NavigationArgs.id:
            context.read<CommunityBloc>().getListPostGroupResp.data?[index].id,
        NavigationArgs.groupId: context.read<CommunityBloc>().state.id
      },
    );

    if (result == true) {
      context.read<CommunityBloc>().add(CommunityInitialEvent());
    }
  }

  void _showPostBottomSheet(BuildContext context) {
    final communityBloc = context.read<CommunityBloc>();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => BlocProvider.value(
        value: communityBloc,
        child: const CreatePostBottomSheet(),
      ),
    );
  }

  callAPIDelete(BuildContext context, String id) {
    context.read<CommunityBloc>().add(
          DeletePostEvent(
            id: id,
            onDeletePostEventSuccess: () {
              _onDeletePostEventSuccess(context);
            },
            onDeletePostEventError: () {
              _onDeletePostEventError(context);
            },
          ),
        );
  }

  void _onDeletePostEventSuccess(BuildContext context) {
    context.read<CommunityBloc>().add(
          CreateGetCommunityPostsEvent(
            groupId: context.read<CommunityBloc>().state.id,
            onGetCommunityPostsSuccess: () {
              showTopSnackBar(
                Overlay.of(context),
                const CustomSnackBar.success(
                  message: 'Delete succeed',
                ),
              );
            },
          ),
        );
  }

  void _onDeletePostEventError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Delete failed',
      ),
    );
  }
}
