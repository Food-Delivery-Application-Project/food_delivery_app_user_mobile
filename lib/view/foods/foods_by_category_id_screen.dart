import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/food/food_bloc.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/utils/app_grid_delegate.dart';
import 'package:food_delivery_app/widgets/foods/food_item_widget.dart';

class FoodByCategoryIdScreen extends StatefulWidget {
  final int categoryId;
  const FoodByCategoryIdScreen({Key? key, required this.categoryId})
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
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: BlocBuilder(
            bloc: foodBloc,
            builder: (context, state) => Column(
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
            ),
          ),
        ),
      ),
    );
  }
}
