import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';

class BioTextWidget extends StatelessWidget {
  final String bio;
  const BioTextWidget({Key? key, required this.bio}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Text(
        bio,
        textAlign: TextAlign.center,
        style: AppTextStyle.normal,
      ),
    );
  }
}
