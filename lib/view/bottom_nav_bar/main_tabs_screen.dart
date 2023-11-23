import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/view/main_tabs/cart_screen.dart';
import 'package:food_delivery_app/view/main_tabs/fovorite_screen.dart';
import 'package:food_delivery_app/view/main_tabs/home_screen.dart';
import 'package:food_delivery_app/view/main_tabs/profile_screen.dart';
import 'package:food_delivery_app/widgets/appbars/basic_appbar_widget.dart';

class MainTabsScreen extends StatefulWidget {
  final int? index;
  const MainTabsScreen({Key? key, this.index}) : super(key: key);

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  final iconList = <IconData>[
    Icons.home,
    Icons.favorite,
    Icons.shopping_cart,
    Icons.person,
  ];

  final screens = <Widget>[
    const HomeScreen(),
    const FovoriteScreen(),
    CartScreen(),
    const ProfileScreen(),
  ];

  var _bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(
        title: "Habibi",
        isBackButton: false,
      ),
      body: screens[_bottomNavIndex], //destination screen
      floatingActionButton: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: AppColors.primary,
        ),
        child: FloatingActionButton(
          onPressed: () {},
          elevation: 2,
          backgroundColor: AppColors.darkBlack,
          shape: const CircleBorder(),
          child: Image.asset(AppImages.logoTrans),
          //params
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: iconList,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        borderWidth: 3,
        borderColor: AppColors.primary,
        activeColor: AppColors.primary,
        inactiveColor: AppColors.white,
        backgroundColor: AppColors.darkBlack,
        notchSmoothness: NotchSmoothness.verySmoothEdge,
        leftCornerRadius: 32,
        rightCornerRadius: 32,
        onTap: (index) => setState(() => _bottomNavIndex = index),
        //other params
      ),
    );
  }
}
