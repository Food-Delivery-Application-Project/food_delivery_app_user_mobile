import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/food/food_bloc.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_grid_delegate.dart';
import 'package:food_delivery_app/widgets/appbars/two_buttons_appbar.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';
import 'package:ionicons/ionicons.dart';
import 'package:nb_utils/nb_utils.dart';

class FoodByCategoryIdScreen extends StatefulWidget {
  final int categoryId;
  final String categoryName;
  const FoodByCategoryIdScreen(
      {Key? key, required this.categoryId, required this.categoryName})
      : super(key: key);

  @override
  State<FoodByCategoryIdScreen> createState() => _FoodByCategoryIdScreenState();
}

class _FoodByCategoryIdScreenState extends State<FoodByCategoryIdScreen> {
  FoodBloc foodBloc = FoodBloc();

  // pagination variables
  int page = 1;
  int paginatedBy = 8;

  ScrollController scrollController = ScrollController();

  List<FoodModel> foods = [];

  @override
  void initState() {
    initData();
    // add scroll listner and increase page size when we reach at the bottom
    scrollController.addListener(() {
      if (scrollController.position.maxScrollExtent -
              scrollController.position.pixels <=
          400) {
        page++;
        moreData();
      }
    });
    super.initState();
  }

  initData() {
    foodBloc = foodBloc
      ..add(
        FoodGetByCategoryIdEvent(widget.categoryId, page, paginatedBy),
      );
  }

  moreData() {
    foodBloc = foodBloc
      ..add(
        FoodGetMoreByCategoryIdEvent(widget.categoryId, page, paginatedBy),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TwoButtonsAppbar(
        title: widget.categoryName,
        icon: Ionicons.refresh,
        onPressed: () {
          foodBloc.add(
            FoodGetByCategoryIdEvent(widget.categoryId, page, paginatedBy),
          );
        },
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          controller: scrollController,
          child: BlocConsumer(
            listener: (context, state) {
              if (state is FoodLoadedState) {
                foods.addAll(state.foodList.data);
              }
            },
            bloc: foodBloc,
            builder: (context, state) {
              if (state is FoodLoadingState) {
                return GridView.builder(
                  gridDelegate: AppGridDelegate.foodItems,
                  itemBuilder: (context, index) => const LoadingWidget(),
                  itemCount: 4,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                );
              } else if (state is FoodErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else {
                return Column(
                  children: [
                    GridView.builder(
                      gridDelegate: AppGridDelegate.foodItems,
                      itemBuilder: (context, index) {
                        return FoodItem(
                          foodModel: foods[index],
                        );
                      },
                      itemCount: foods.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    ),
                    if (state is FoodMoreLoadingState) ...[
                      30.height,
                      const LoadingWidget(),
                    ]
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
