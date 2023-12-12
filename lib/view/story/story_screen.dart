import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/models/food/food_model.dart';
import 'package:food_delivery_app/models/story/story_model.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/foods/food_details_screen.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/buttons/outlined_button.dart';
import 'package:nb_utils/nb_utils.dart';

class StoryScreen extends StatefulWidget {
  final StoryModel story;
  const StoryScreen({Key? key, required this.story}) : super(key: key);

  @override
  State<StoryScreen> createState() => _StoryScreenState();
}

class _StoryScreenState extends State<StoryScreen> {
  double progressValue = 0.0;
  int durationInSeconds = 10; // Set the duration of your story in seconds
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    // Start the timer to update progress
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        progressValue += 1.0 / durationInSeconds;
      });

      // Check if the timer has reached its end
      if (progressValue >= 1.0) {
        _timer.cancel();
        // Add code here to navigate back
        route();
      }
    });
  }

  route() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.darkBackground,
      appBar: const BackAppbarWidget(color: AppColors.darkBackground),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: progressValue,
              backgroundColor: Colors.grey,
              valueColor:
                  const AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
            Flexible(flex: 2, child: Container()),
            // show price
            Text(
              "PKR: ${widget.story.foodId!.price}",
              style: const TextStyle(
                color: AppColors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ).paddingOnly(left: 16, right: 16),
            20.height,
            CachedNetworkImage(
              imageUrl: widget.story.foodId!.image.toString(),
              fit: BoxFit.contain,
            ),
            20.height,
            Text(widget.story.caption.toString(),
                style: const TextStyle(
                  color: AppColors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )).paddingOnly(left: 16, right: 16),
            Flexible(flex: 2, child: Container()),
            OutlinedButtonWidget(
              caption: "Visit",
              onPressed: () {
                AppNavigator.goToPage(
                  context: context,
                  screen: FoodDetailsScreen(
                    food: FoodModel(
                      foodId: widget.story.foodId!.sId.toString(),
                      foodName: widget.story.foodId!.foodName.toString(),
                      image: widget.story.foodId!.image.toString(),
                      price: widget.story.foodId!.price,
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
