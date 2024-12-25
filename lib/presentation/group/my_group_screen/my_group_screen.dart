import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../core/app_export.dart';
import '../../../../routes/navigation_args.dart';
import 'bloc/my_group_bloc.dart';
import 'models/my_group_model.dart';
import 'models/my_group_list_item_model.dart';
import 'widgets/my_group_list_item_widget.dart';

class MyGroupScreen extends StatefulWidget {
  const MyGroupScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider<MyGroupBloc>(
      create: (context) => MyGroupBloc(MyGroupState(
        myGroupModelObj: MyGroupModel(),
      ))
        ..add(MyGroupInitialEvent()),
      child: const MyGroupScreen(),
    );
  }

  @override
  State<MyGroupScreen> createState() => _MyGroupScreenState();
}

class _MyGroupScreenState extends State<MyGroupScreen> {
  bool _dialogShown = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final showJoinDialog = args?[NavigationArgs.showJoinDialog] ?? false;
    final groupId = args?[NavigationArgs.groupId];

    if (showJoinDialog && groupId != null && !_dialogShown) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _dialogShown = true;
        });
        _showJoinGroupDialog(context, groupId);
      });
    }
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
                  child: const Icon(Icons.group)),
              leadingWidth: 25.h,
              titleSpacing: 25.h,
              title: const Text(
                'Group',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
        body: BlocBuilder<MyGroupBloc, MyGroupState>(
          builder: (context, state) {
            if (state.myGroupModelObj == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return Container(
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
                  BlocSelector<MyGroupBloc, MyGroupState, MyGroupModel?>(
                    selector: (state) => state.myGroupModelObj,
                    builder: (context, myGroupModelObj) {
                      return Text(
                        "${myGroupModelObj?.groupCount ?? 0} Groups",
                        style: CustomTextStyles.titleMediumRobotoBlack900,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  Expanded(
                    child: _buildMyGroupList(context),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMyGroupList(BuildContext context) {
    return BlocSelector<MyGroupBloc, MyGroupState, MyGroupModel?>(
      selector: (state) => state.myGroupModelObj,
      builder: (context, myGroupModelObj) {
        return ListView.separated(
          padding: EdgeInsets.zero,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (context, index) {
            return SizedBox(
              height: 15.h,
            );
          },
          itemCount: myGroupModelObj?.myGroupListItemList.length ?? 0,
          itemBuilder: (context, index) {
            MyGroupListItemModel model =
                myGroupModelObj?.myGroupListItemList[index] ??
                    const MyGroupListItemModel();
            return MyGroupListItemWidget(
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

  void _showJoinGroupDialog(BuildContext context, String groupId) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.bottomSlide,
      title: 'Join Group',
      desc: 'Would you like to join this group?',
      btnCancelOnPress: () {},
      btnOkOnPress: () {
        context.read<MyGroupBloc>().add(
              JoinGroupEvent(
                groupId: groupId,
                onJoinSuccess: () {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.success(
                      message: 'Joined group',
                    ),
                  );
                  context.read<MyGroupBloc>().add(
                        CreateGetMyGroupEvent(
                          onGetMyGroupSuccess: () {},
                          onGetMyGroupError: () {},
                        ),
                      );
                },
                onJoinError: () {
                  showTopSnackBar(
                    Overlay.of(context),
                    const CustomSnackBar.error(
                      message: 'Failed to join group',
                    ),
                  );
                },
              ),
            );
      },
      btnCancelText: 'Cancel',
      btnOkText: 'Join',
      btnOkColor: appTheme.deppPurplePrimary,
      btnCancelColor: appTheme.gray500,
      dismissOnBackKeyPress: false,
    ).show();
  }

  callDetail(BuildContext context, int index) async {
    final refreshRequired = await NavigatorService.pushNamed(
      AppRoutes.communityScreen,
      arguments: {
        NavigationArgs.id:
            context.read<MyGroupBloc>().getMyGroupResp.data?[index].group?.id,
      },
    );

    if (refreshRequired == true) {
      context.read<MyGroupBloc>().add(
            CreateGetMyGroupEvent(
              onGetMyGroupSuccess: () {},
              onGetMyGroupError: () {},
            ),
          );
    }
  }

  callAPIDelete(BuildContext context, String id) {
    context.read<MyGroupBloc>().add(
          DeleteMyGroupEvent(
            id: id,
            onDeleteMyGroupEventSuccess: () {
              _onDeleteMyGroupApiEventSuccess(context);
            },
            onDeleteMyGroupEventError: () {
              _onDeleteMyGroupApiEventError(context);
            },
          ),
        );
  }

  void _onDeleteMyGroupApiEventSuccess(BuildContext context) {
    context.read<MyGroupBloc>().add(CreateGetMyGroupEvent(
      onGetMyGroupSuccess: () {
        showTopSnackBar(
          Overlay.of(context),
          const CustomSnackBar.success(
            message: 'Delete succeed',
          ),
        );
      },
    ));
  }

  void _onDeleteMyGroupApiEventError(BuildContext context) {
    showTopSnackBar(
      Overlay.of(context),
      const CustomSnackBar.error(
        message: 'Delete failed',
      ),
    );
  }
}
