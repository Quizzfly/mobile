import 'package:flutter/material.dart';
import '../core/app_export.dart';
import '../presentation/enter_pin_screen/enter_pin_screen.dart';

// ignore: constant_identifier_names
enum BottomBarEnum { Home, Library, Group, Account }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});
  Function(BottomBarEnum)? onChanged;
  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: const Icon(Icons.home_filled, color: Color(0XFF4B5563)),
      activeIcon: const Icon(Icons.home_filled, color: Color(0XFF7C3AED)),
      title: "lbl_home".tr,
      type: BottomBarEnum.Home,
    ),
    BottomMenuModel(
      icon: const Icon(Icons.grid_view_rounded, color: Color(0XFF4B5563)),
      activeIcon: const Icon(Icons.grid_view_rounded, color: Color(0XFF7C3AED)),
      title: "lbl_library".tr,
      type: BottomBarEnum.Library,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgLogo,
      activeIcon: ImageConstant.imgLogo,
      type: BottomBarEnum.Home,
      isCircle: true,
    ),
    BottomMenuModel(
      icon: const Icon(Icons.group, color: Color(0XFF4B5563)),
      activeIcon: const Icon(Icons.group, color: Color(0XFF7C3AED)),
      title: "lbl_group".tr,
      type: BottomBarEnum.Group,
    ),
    BottomMenuModel(
      icon: const Icon(Icons.person, color: Color(0XFF4B5563)),
      activeIcon: const Icon(Icons.person, color: Color(0XFF7C3AED)),
      title: "lbl_account".tr,
      type: BottomBarEnum.Account,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: const Color(0XFFF2F4F7),
            width: 1.h,
          ),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Indicator line similar to TabBar
          Container(
            height: 3.h,
            width: double.infinity,
            color: Colors.transparent,
            child: Row(
              children: List.generate(bottomMenuList.length, (index) {
                return Expanded(
                  child: Container(
                    color: selectedIndex == index
                        ? const Color(0XFF7C3AED) // Deep Purple Primary
                        : Colors.transparent,
                  ),
                );
              }),
            ),
          ),
          BottomNavigationBar(
            backgroundColor: Colors.transparent,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            selectedFontSize: 0,
            elevation: 0,
            currentIndex: selectedIndex,
            type: BottomNavigationBarType.fixed,
            items: List.generate(bottomMenuList.length, (index) {
              if (bottomMenuList[index].isCircle) {
                return BottomNavigationBarItem(
                  icon: GestureDetector(
                    onTap: () {
                      _showEnterPinBottomSheet(context);
                    },
                    child: CustomImageView(
                      imagePath: bottomMenuList[index].icon,
                      height: 50.h,
                      width: 52.h,
                      radius: BorderRadius.circular(10.h),
                    ),
                  ),
                  label: '',
                );
              }
              return BottomNavigationBarItem(
                icon: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    bottomMenuList[index].icon is Icon
                        ? bottomMenuList[index].icon
                        : Icon(
                            Icons.error,
                            color: const Color(0XFF4B5563),
                            size: 24.h,
                          ),
                    SizedBox(height: 4.h),
                    Text(
                      bottomMenuList[index].title ?? "",
                      style: theme.textTheme.bodySmall!.copyWith(
                        color: const Color(0XFF4B5563),
                      ),
                    )
                  ],
                ),
                activeIcon: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    bottomMenuList[index].activeIcon is Icon
                        ? bottomMenuList[index].activeIcon
                        : Icon(
                            Icons.error,
                            color: const Color(0XFF7C3AED),
                            size: 24.h,
                          ),
                    SizedBox(height: 4.h),
                    Text(
                      bottomMenuList[index].title ?? "",
                      style: CustomTextStyles.labelLargeOnPrimary.copyWith(
                        color: const Color(0XFF7C3AED),
                      ),
                    )
                  ],
                ),
                label: '',
              );
            }),
            onTap: (index) {
              setState(() {
                selectedIndex = index;
              });
              widget.onChanged?.call(bottomMenuList[index].type);
            },
          ),
        ],
      ),
    );
  }

  void _showEnterPinBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.h),
            topRight: Radius.circular(30.h),
          ),
          child: EnterPinScreen.builder(context),
        ),
      ),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel(
      {required this.icon,
      required this.activeIcon,
      this.title,
      required this.type,
      this.isCircle = false});
  dynamic icon;
  dynamic activeIcon;
  String? title;
  BottomBarEnum type;
  bool isCircle;
}

class DefaultWidget extends StatelessWidget {
  const DefaultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFFFFFFF),
      padding: const EdgeInsets.all(10),
      child: const Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
