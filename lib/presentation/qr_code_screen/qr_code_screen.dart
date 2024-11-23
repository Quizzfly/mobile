import 'package:flutter/material.dart';
import 'package:quizzfly_application_flutter/presentation/enter_pin_screen/enter_pin_tab_page.dart';
import '../../core/app_export.dart';
import 'bloc/qr_code_bloc.dart';
import 'qr_code_tab_page.dart';
import 'models/qr_code_model.dart';

class QrCodeScreen extends StatefulWidget {
  const QrCodeScreen({super.key});
  @override
  QrCodeScreenState createState() => QrCodeScreenState();
  static Widget builder(BuildContext context) {
    return BlocProvider<QrCodeBloc>(
      create: (context) => QrCodeBloc(QrCodeState(
        qrCodeModelObj: QrCodeModel(),
      ))
        ..add(QrCodeInitialEvent()),
      child: const QrCodeScreen(),
    );
  }
}

class QrCodeScreenState extends State<QrCodeScreen>
    with TickerProviderStateMixin {
  late TabController tabViewController;
  int tabIndex = 0;
  @override
  void initState() {
    super.initState();
    tabViewController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<QrCodeBloc, QrCodeState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            backgroundColor: appTheme.whiteA700.withOpacity(1),
            body: Container(
              width: double.maxFinite,
              padding: EdgeInsets.only(top: 2.h),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    ImageConstant.imgBackground1,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 26.h),
                  _buildTabView(context),
                  Expanded(
                    child: Container(
                      child: TabBarView(
                        controller: tabViewController,
                        children: [
                          QrCodeTabPage.builder(context),
                          EnterPinTabPage.builder(context)
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildTabView(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.h),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 10.h),
            child: GestureDetector(
              onTap: () => onTapClose(context),
              child: Container(
                alignment: Alignment.bottomLeft,
                padding: EdgeInsets.all(10.h),
                child: Image.asset(
                  ImageConstant.imgClose,
                  width: 24.h,
                  height: 24.h,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Row(
            children: [
              SizedBox(height: 8.h),
              Expanded(
                child: TabBar(
                  controller: tabViewController,
                  labelPadding: EdgeInsets.zero,
                  dividerColor: Colors.transparent,
                  indicatorColor: Colors.transparent,
                  labelColor: appTheme.deppPurplePrimary,
                  labelStyle: TextStyle(
                    fontSize: 14.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                  unselectedLabelColor: appTheme.whiteA700.withOpacity(1),
                  unselectedLabelStyle: TextStyle(
                    fontSize: 14.fSize,
                    fontFamily: 'Roboto',
                    fontWeight: FontWeight.w700,
                  ),
                  tabs: [
                    Tab(
                      height: 30,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(right: 6.h),
                        decoration: tabIndex == 0
                            ? BoxDecoration(
                                color: appTheme.whiteA700.withOpacity(1),
                                borderRadius: BorderRadius.circular(
                                  14.h,
                                ))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  14.h,
                                ),
                                border: Border.all(
                                  color: appTheme.whiteA700.withOpacity(1),
                                  width: 1.h,
                                ),
                              ),
                        child: Text(
                          "lbl_enter_pin".tr,
                        ),
                      ),
                    ),
                    Tab(
                      height: 30,
                      child: Container(
                        alignment: Alignment.center,
                        width: double.maxFinite,
                        margin: EdgeInsets.only(left: 6.h),
                        decoration: tabIndex == 1
                            ? BoxDecoration(
                                color: appTheme.whiteA700.withOpacity(1),
                                borderRadius: BorderRadius.circular(
                                  14.h,
                                ))
                            : BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  14.h,
                                ),
                                border: Border.all(
                                  color: appTheme.whiteA700.withOpacity(1),
                                  width: 1.h,
                                ),
                              ),
                        child: Text(
                          "lbl_scan_qr_code2".tr,
                        ),
                      ),
                    )
                  ],
                  onTap: (index) {
                    tabIndex = index;
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  onTapClose(BuildContext context) {
    NavigatorService.goBack();
  }
}
