import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

class ListTileWidget extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final VoidCallback? onTap;
  const ListTileWidget(
      {Key? key,
      required this.title,
      required this.subtitle,
      required this.icon,
      this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: AppColors.lightGrey,
        child: Icon(icon, size: 30),
      ),
      title: Text(title, style: AppTextStyle.listTileTitle),
      subtitle: Text(subtitle, style: AppTextStyle.listTileSubHeading),
    );
  }
}
