import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/wishlist/wishlist_bloc.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';

class FovoriteScreen extends StatefulWidget {
  const FovoriteScreen({super.key});

  @override
  State<FovoriteScreen> createState() => _FovoriteScreenState();
}

class _FovoriteScreenState extends State<FovoriteScreen> {
  WishlistBloc wishlistBloc = WishlistBloc();

  @override
  void initState() {
    UserSecureStorage.fetchUserId().then((value) {
      wishlistBloc.add(WishlistGetInitialDataEvent(
        userId: value.toString(),
        page: 1,
        paginatedBy: 10,
      ));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: AppColors.white,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: BlocConsumer<WishlistBloc, WishlistState>(
          bloc: wishlistBloc,
          listener: (context, state) {
            // TODO: implement listener
          },
          builder: (context, state) {
            if (state is WishlistInitialLoadedState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    GridView.builder(
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 0.8,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 20,
                      ),
                      itemBuilder: (context, index) {
                        return FoodItem(foodModel: state.foods.data[index]);
                      },
                      itemCount: state.foods.data.length,
                      shrinkWrap: true,
                    ),
                  ],
                ),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
