import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:nb_utils/nb_utils.dart';

class HeadingWidget extends StatelessWidget {
  final String headingText;
  final bool? isViewAll;
  final VoidCallback? callback;
  const HeadingWidget({
    Key? key,
    required this.headingText,
    this.isViewAll,
    this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          headingText,
          style: AppTextStyle.headings,
        ),
        TextButton(
          onPressed: callback ?? () {},
          child: Text("View All", style: AppTextStyle.button),
        ).visible(isViewAll == true),
      ],
    );
  }
}
