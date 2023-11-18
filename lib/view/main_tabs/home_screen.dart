import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/utils/app_grid_delegate.dart';
import 'package:food_delivery_app/widgets/category/category_widget.dart';
import 'package:food_delivery_app/widgets/divider/app_divider.dart';
import 'package:nb_utils/nb_utils.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Categories",
                style: AppTextStyle.headings,
              ),
              10.height,
              GridView.builder(
                gridDelegate: AppGridDelegate.categories,
                itemBuilder: (context, index) => const CategoryWidget(),
                itemCount: 4,
                shrinkWrap: true,
              ),
              20.height,
              const AppDivider(),
            ],
          ),
        ),
      ],
    );
  }
}
