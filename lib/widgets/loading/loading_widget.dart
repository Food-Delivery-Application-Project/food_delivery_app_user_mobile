import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  final Color? color;
  const LoadingWidget({Key? key, this.color}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SpinKitChasingDots(
        color: color ?? AppColors.primary,
        size: 30.0,
      ),
    );
  }
}
