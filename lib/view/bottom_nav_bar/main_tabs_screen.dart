import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/blocs/cart/cart_bloc.dart';
import 'package:food_delivery_app/blocs/user/user_bloc.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/models/user/user_model.dart';
import 'package:food_delivery_app/view/main_tabs/cart_screen.dart';
import 'package:food_delivery_app/view/main_tabs/home_screen.dart';
import 'package:food_delivery_app/view/main_tabs/profile_screen.dart';
import 'package:food_delivery_app/view/main_tabs/wishlist_screen.dart';
import 'package:food_delivery_app/widgets/appbars/basic_appbar_widget.dart';

class MainTabsScreen extends StatefulWidget {
  const MainTabsScreen({Key? key}) : super(key: key);

  @override
  State<MainTabsScreen> createState() => _MainTabsScreenState();
}

class _MainTabsScreenState extends State<MainTabsScreen> {
  int _page = 0;
  late PageController pageController; // for tabs animation
  List<CartFoodModel> cartList = [];
  UserModel userModel = UserModel();

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void onPageChanged(int page) {
    setState(() {
      _page = page;
    });
  }

  void navigationTapped(int page) {
    //Animating Page
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BasicAppbarWidget(title: "HABIBI", isBackButton: false),
      body: PageView(
        controller: pageController,
        onPageChanged: onPageChanged,
        children: [
          const HomeScreen(),
          const WishlistScreen(),
          CartScreen(),
          const ProfileScreen(),
        ],
      ),
      bottomNavigationBar: BlocConsumer<CartBloc, CartState>(
        listener: (context, state) {
          if (state is CartGetCartListState) {
            setState(() {
              cartList = state.cartList;
            });
          }
        },
        builder: (context, state) {
          return BlocConsumer<UserBloc, UserState>(
            listener: (context, st) {
              if (st is UserGetState) {
                userModel = st.user;
              }
            },
            builder: (context, st) {
              return CupertinoTabBar(
                items: <BottomNavigationBarItem>[
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(Icons.favorite),
                  ),
                  BottomNavigationBarItem(
                    icon: cartList.isNotEmpty
                        ? Badge(
                            label: Text(cartList.length.toString()),
                            child: const Icon(Icons.shopping_cart),
                          )
                        : const Icon(Icons.shopping_cart),
                  ),
                  const BottomNavigationBarItem(
                    icon: Icon(
                      Icons.person,
                    ),
                  ),
                ],
                onTap: navigationTapped,
                currentIndex: _page,
                activeColor: AppColors.primary,
                inactiveColor: AppColors.darkGrey,
                height: 60.h,
                backgroundColor: AppColors.white,
              );
            },
          );
        },
      ),
    );
  }
}
