import 'package:flutter/material.dart';
import '../../../../core/app_export.dart';
import '../../../../theme/custom_button_style.dart';
import '../../../../widgets/custom_elevated_button.dart';
import '../../../routes/navigation_args.dart';
import 'bloc/community_bloc.dart';
import 'community_activity_tab_page.dart';
import 'models/community_model.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  CommunityScreenState createState() => CommunityScreenState();

  static Widget builder(BuildContext context) {
    var arg =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
    return BlocProvider<CommunityBloc>(
      create: (context) => CommunityBloc(CommunityState(
        communityModelObj: const CommunityModel(),
        id: arg[NavigationArgs.id],
      ))
        ..add(CommunityInitialEvent()),
      child: const CommunityScreen(),
    );
  }
}

class CommunityScreenState extends State<CommunityScreen>
    with TickerProviderStateMixin {
  late TabController tabViewController;
  @override
  void initState() {
    super.initState();
    tabViewController = TabController(length: 2, vsync: this);
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
              leadingWidth: 40.h,
              leading: Padding(
                padding: EdgeInsets.only(left: 16.h),
                child: IconButton(
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => Navigator.of(context).pop(),
                ),
              ),
              titleSpacing: 15.h,
              title: const Text(
                'Communities',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 16.h, left: 8.h),
                  child: CustomElevatedButton(
                    height: 32.h,
                    width: 80.h,
                    text: "Invite",
                    buttonStyle: CustomButtonStyles.fillPrimaryRadius20,
                    buttonTextStyle:
                        CustomTextStyles.titleSmallOnErrorContainer,
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SizedBox(
          width: 414.h,
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              _buildActivityTab(context),
              Expanded(
                child: TabBarView(
                  controller: tabViewController,
                  children: const [
                    CommunityActivityTabPage(),
                    CommunityActivityTabPage()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivityTab(BuildContext context) {
    return SizedBox(
      height: 48.h,
      width: double.maxFinite,
      child: TabBar(
        controller: tabViewController,
        isScrollable: true,
        dividerColor: Colors.transparent,
        indicatorColor: appTheme.deppPurplePrimary,
        tabAlignment: TabAlignment.start,
        labelColor: appTheme.deppPurplePrimary,
        labelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelColor: Colors.grey,
        unselectedLabelStyle: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        indicatorSize: TabBarIndicatorSize.tab,
        tabs: const [Tab(text: "Activity"), Tab(text: "Share")],
      ),
    );
  }
}
