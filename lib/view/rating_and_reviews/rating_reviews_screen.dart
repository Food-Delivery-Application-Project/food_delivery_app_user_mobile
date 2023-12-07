import 'package:flutter/material.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';

class RatingReviewsScreen extends StatelessWidget {
  final String foodId;
  const RatingReviewsScreen({Key? key, required this.foodId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppbarWidget(),
      body: Container(),
    );
  }
}
