// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/view/auth/login_screen.dart';
import 'package:food_delivery_app/view/auth/registration_screen.dart';
import 'package:food_delivery_app/widgets/buttons/outlined_button.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 30),
            Expanded(
              flex: 3,
              // flutter logo
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.primary.withOpacity(0.5),
                    width: 1,
                  ),
                ),
                child: Image.asset(AppImages.logoTrans),
              ),
            ),
            Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Welcome to Habibi",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.headings),
                      SizedBox(
                        height: 10,
                      ),
                      Text("A place where you can find and get your food",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.subHeading),
                    ],
                  ),
                )),
            Padding(
              padding: EdgeInsets.only(top: 30, left: 30, right: 30),
              child: PrimaryButtonWidget(
                  width: MediaQuery.of(context).size.width,
                  caption: 'Registration',
                  onPressed: () {
                    AppNavigator.goToPageWithReplacement(
                      context: context,
                      screen: RegistrationScreen(),
                    );
                  }),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.only(bottom: 30, left: 30, right: 30),
              child: OutlinedButtonWidget(
                  width: MediaQuery.of(context).size.width,
                  caption: 'Login',
                  onPressed: () {
                    AppNavigator.goToPageWithReplacement(
                      context: context,
                      screen: LoginScreen(),
                    );
                  }),
            ),
            SizedBox(height: 30)
          ],
        ),
      ),
    );
  }
}
