import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/widgets/appbars/basic_appbar_widget.dart';
import 'package:ionicons/ionicons.dart';

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
    Scaffold(
      appBar: BasicAppbarWidget(title: "Home", isBackButton: false),
    ),
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
        items: const [
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Ionicons.home),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Ionicons.accessibility),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Ionicons.accessibility),
          ),
          BottomNavigationBarItem(
            label: "",
            icon: Icon(Ionicons.accessibility),
          ),
        ],
        onTap: (value) {
          selectedIndex(value);
        },
        currentIndex: pageIndex,
      ),
    );
  }
}
