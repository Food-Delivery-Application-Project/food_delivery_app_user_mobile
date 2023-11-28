// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/global/fonts/app_fonts.dart';
import 'package:food_delivery_app/global/pixels/app_pixels.dart';

class AppTextStyle {
  static var headings = TextStyle(
    fontSize: AppPixels.heading,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
    fontFamily: AppFonts.jost,
  );

  static var subHeading = TextStyle(
    fontSize: AppPixels.subHeading,
    color: AppColors.darkGrey,
    fontFamily: AppFonts.jost,
    fontWeight: FontWeight.w500,
  );

  static var foodItemName = TextStyle(
    fontSize: AppPixels.subHeading,
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontFamily: AppFonts.jost,
  );

  static var body = TextStyle(
    fontSize: AppPixels.normal14,
    color: AppColors.darkGrey,
    fontFamily: AppFonts.jost,
  );

  static var textField = TextStyle(
    fontSize: AppPixels.subHeading,
    color: AppColors.black,
    fontFamily: AppFonts.jost,
  );

  static var button = TextStyle(
    fontSize: AppPixels.subHeading,
    fontFamily: AppFonts.jost,
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
  );

  static var productName = TextStyle(
    fontSize: AppPixels.subHeading,
    color: AppColors.black,
    fontFamily: AppFonts.jost,
    fontWeight: FontWeight.w500,
  );

  static var productDescription = TextStyle(
    fontSize: AppPixels.normal14,
    color: AppColors.white,
    fontFamily: AppFonts.jost,
    fontWeight: FontWeight.w400,
  );

  static var resentOtpTextStyle = TextStyle(
    decoration: TextDecoration.underline,
    decorationColor: AppColors.primary,
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static var codeTextStyle = TextStyle(
    color: AppColors.primary,
    fontSize: 16,
    fontWeight: FontWeight.w500,
  );

  static var whiteButtonTextStyle = const TextStyle(
    color: AppColors.white,
    fontWeight: FontWeight.bold,
    fontSize: AppPixels.subHeading,
  );

  static var outlinedButtonTextStyle = const TextStyle(
    color: AppColors.primary,
    fontWeight: FontWeight.bold,
    fontSize: AppPixels.subHeading,
  );

  static var pinput = TextStyle(
    fontSize: 22,
    color: AppColors.darkGrey,
  );

  static var normal = TextStyle(
    fontSize: AppPixels.normal14,
    color: AppColors.darkGrey,
    fontFamily: AppFonts.jost,
  );

  static var dialogHeader = TextStyle(
    fontSize: 20.8,
    color: AppColors.darkGrey,
    fontWeight: FontWeight.bold,
  );

  static var dialogNormal = TextStyle(
    fontSize: 12.8,
    color: AppColors.darkGrey,
  );

  static var listTileTitle = TextStyle(
    color: AppColors.black,
    fontSize: 18,
    fontFamily: AppFonts.poppins,
    fontWeight: FontWeight.w700,
  );

  static var listTileSubHeading = listTileTitle.copyWith(fontSize: 12);
}
