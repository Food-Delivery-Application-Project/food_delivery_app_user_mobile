import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';

class TextValueWidget extends StatelessWidget {
  final String text, value;
  final void Function()? onTap;
  const TextValueWidget(
      {Key? key, required this.text, required this.value, this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Text(value, style: AppTextStyle.normal),
          Text(text, style: AppTextStyle.normal),
        ],
      ),
    );
  }
}
