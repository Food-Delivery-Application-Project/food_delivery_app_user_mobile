import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

class ContentWidget extends StatelessWidget {
  final String header, content;
  const ContentWidget({Key? key, required this.header, required this.content})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: header,
            style: AppTextStyle.normal.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
              color: AppColors.black,
            ),
          ),
          TextSpan(
            text: content,
            style: AppTextStyle.normal.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
