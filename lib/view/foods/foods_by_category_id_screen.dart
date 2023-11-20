import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/food/food_bloc.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_grid_delegate.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';

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
  int paginatedBy = 10;

  @override
  void initState() {
    foodBloc = foodBloc
      ..add(
        FoodGetByCategoryIdEvent(widget.categoryId, page, paginatedBy),
      );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbarWidget(title: widget.categoryName),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocBuilder(
            bloc: foodBloc,
            builder: (context, state) {
              if (state is FoodLoadingState) {
                return const LoadingWidget();
              } else if (state is FoodErrorState) {
                return Center(
                  child: Text(state.message),
                );
              } else if (state is FoodLoadedState) {
                return Column(
                  children: [
                    GridView.builder(
                      gridDelegate: AppGridDelegate.foodItems,
                      itemBuilder: (context, index) => FoodItem(
                        foodModel: state.foodList.data[index],
                      ),
                      itemCount: state.foodList.data.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                    )
                  ],
                );
              }
              return Column(
                children: [
                  GridView.builder(
                    gridDelegate: AppGridDelegate.foodItems,
                    itemBuilder: (context, index) =>
                        FoodItem(foodModel: FoodModel()),
                    itemCount: 4,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
