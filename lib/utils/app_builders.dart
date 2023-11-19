import 'package:flutter/material.dart';
import 'package:food_delivery_app/utils/app_grid_delegate.dart';

class AppBuilders {
  static GridView categories(Widget? Function(BuildContext, int) builder) {
    return GridView.builder(
      gridDelegate: AppGridDelegate.categories,
      itemBuilder: builder,
      itemCount: 4,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
    );
  }
}
