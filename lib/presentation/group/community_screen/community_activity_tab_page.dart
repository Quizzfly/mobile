import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../routes/navigation_args.dart';
import 'bloc/community_bloc.dart';
import 'models/community_list_item_model.dart';
import 'widgets/community_list_item_widget.dart';
import 'widgets/community_shimmer_loading.dart';

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
              expandedHeight: 140,
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
                                horizontal: 16, vertical: 8),
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
                                  child: CustomTextFormField(
                                    controller: state.postInputFieldController,
                                    hintText: "Post something",
                                    borderDecoration: TextFormFieldStyleHelper
                                        .outlineBlueGrayTL82
                                        .copyWith(
                                            borderRadius:
                                                BorderRadius.circular(20.h)),
                                  ),
                                ),
                                const SizedBox(width: 12),
                                CustomElevatedButton(
                                  height: 40,
                                  width: 100,
                                  text: "Post",
                                  buttonStyle:
                                      CustomButtonStyles.fillPrimaryRadius20,
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
                                  padding: const EdgeInsets.all(12),
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
                                        child: CustomTextFormField(
                                          controller:
                                              state.postInputFieldController,
                                          hintText: "Post something",
                                          borderDecoration:
                                              TextFormFieldStyleHelper
                                                  .outlineBlueGrayTL82
                                                  .copyWith(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.h)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Divider(),
                                Padding(
                                  padding: const EdgeInsets.all(12),
                                  child: CustomElevatedButton(
                                    text: "Add New Post",
                                    buttonStyle:
                                        CustomButtonStyles.fillPrimaryRadius20,
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
              padding: const EdgeInsets.symmetric(horizontal: 16),
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
}
