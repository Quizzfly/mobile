import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../../widgets/custom_text_form_field.dart';
import '../../../routes/navigation_args.dart';
import 'bloc/community_bloc.dart';
import 'models/community_list_item_model.dart';
import 'widgets/community_list_item_widget.dart';

class CommunityActivityTabPage extends StatelessWidget {
  const CommunityActivityTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CommunityBloc, CommunityState>(
      builder: (context, state) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Column(
            children: [
              _buildPostCreationSection(context, state),
              const SizedBox(height: 16),
              _buildCommunityList(context, state),
            ],
          ),
        );
      },
    );
  }

  Widget _buildPostCreationSection(BuildContext context, CommunityState state) {
    return Container(
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
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(PrefUtils().getAvatar()),
                  backgroundColor: Colors.transparent,
                  // ignore: unnecessary_null_comparison
                  child: PrefUtils().getAvatar() == null
                      ? const Icon(Icons.person, size: 24)
                      : null,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: CustomTextFormField(
                    controller: state.postInputFieldController,
                    hintText: "Post something",
                    borderDecoration:
                        TextFormFieldStyleHelper.outlineBlueGrayTL82.copyWith(
                      borderRadius: BorderRadius.circular(20.h),
                    ),
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
              buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCommunityList(BuildContext context, CommunityState state) {
    return Expanded(
      child: ListView.separated(
        padding: EdgeInsets.zero,
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        separatorBuilder: (context, index) {
          return SizedBox(height: 16.h);
        },
        itemCount:
            state.communityActivityTabModelObj?.communityListItemList.length ??
                0,
        itemBuilder: (context, index) {
          CommunityListItemModel model = state
                  .communityActivityTabModelObj?.communityListItemList[index] ??
              CommunityListItemModel();
          return CommunityListItemWidget(
            model,
            index: index, // Add this line

            callDetail: () {
              callDetail(context, index);
            },
          );
        },
      ),
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
