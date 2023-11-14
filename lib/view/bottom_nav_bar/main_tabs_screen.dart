import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

class MainTabScreen extends StatefulWidget {
  final int index;

  const MainTabScreen({super.key, required this.index});

  @override
  State<MainTabScreen> createState() => _MainTabScreenState();
}

class _MainTabScreenState extends State<MainTabScreen> {
  int pageIndex = 0;
  @override
  void initState() {
    pageIndex = widget.index;

    super.initState();
  }

  void selectedIndex(int index) {
    setState(() => pageIndex = index);
  }

  final pages = [
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
    Scaffold(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: pageIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        elevation: 10,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: Colors.grey,
        backgroundColor: AppColors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        type: BottomNavigationBarType.fixed,
        items: [
          // BottomNavigationBarItem(
          //   label: "",
          //   icon: Image.asset(
          //     pageIndex == 0
          //         ? ImageAssets.homeImage
          //         : ImageAssets.homeUnselectedImage,
          //     height: 30.h,
          //   ),
          // ),
          // BottomNavigationBarItem(
          //   label: "",
          //   icon: Image.asset(
          //     pageIndex == 1
          //         ? ImageAssets.selectedGroupImage
          //         : ImageAssets.groupImage,
          //     height: 30.h,
          //   ),
          // ),
          // BottomNavigationBarItem(
          //   label: "",
          //   icon: SizedBox(
          //     width: 60.h,
          //     height: 60.h,
          //     child: FloatingActionButton(
          //       backgroundColor: AppColors.primary,
          //       foregroundColor: AppColors.white,
          //       shape: RoundedRectangleBorder(
          //           borderRadius: BorderRadius.circular(100)),
          //       onPressed: () {
          //         selectedIndex(1);
          //       },
          //       child: const Icon(Icons.add),
          //     ),
          //   ),
          // ),
          // BottomNavigationBarItem(
          //   label: "",
          //   icon: Image.asset(
          //     pageIndex == 3
          //         ? ImageAssets.messageSelectedImage
          //         : ImageAssets.messageImage,
          //     height: 30.h,
          //   ),
          // ),
          // BottomNavigationBarItem(
          //   label: "",
          //   icon: Image.asset(
          //     pageIndex == 4
          //         ? ImageAssets.profileSelectedImage
          //         : ImageAssets.profileImage,
          //     height: 30.h,
          //   ),
          // ),
        ],
        onTap: (value) {
          selectedIndex(value);
        },
        currentIndex: pageIndex,
      ),
    );
  }
}
