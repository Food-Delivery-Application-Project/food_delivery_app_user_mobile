import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/widgets/loading/loading_widget.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(AppImages.logoTrans),
          const LoadingWidget(),
        ],
      ),
    ));
  }
}
