import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return const Divider(color: AppColors.primary, thickness: 2);
  }
}
