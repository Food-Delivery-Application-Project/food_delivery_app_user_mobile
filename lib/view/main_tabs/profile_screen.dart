import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/assets/app_assets.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/divider/app_divider.dart';
import 'package:ionicons/ionicons.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;
    return Scaffold(
      // appBar: AppBar(
      //   leading: IconButton(
      //       onPressed: (){},
      //       icon: const Icon(LineAwesomeIcons.angle_left)),
      //   title: Text(tProfile, style: Theme.of(context).textTheme.headline4),
      //   actions: [
      //     IconButton(
      //         onPressed: () {},
      //         icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon))
      //   ],
      // ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              /// -- IMAGE
              Stack(
                children: [
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(100),
                        child: const Image(
                            image: AssetImage(AppImages.logoTrans))),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: AppColors.primary),
                      child: const Icon(
                        Ionicons.pencil,
                        color: Colors.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text("Wasim Zaman", style: AppTextStyle.headings),
              Text("03005447070", style: AppTextStyle.subHeading),
              const SizedBox(height: 20),

              /// -- BUTTON
              // SizedBox(
              //   width: 200,
              //   child: ElevatedButton(
              //     onPressed: () {}),
              //     style: ElevatedButton.styleFrom(
              //         backgroundColor: tPrimaryColor,
              //         side: BorderSide.none,
              //         shape: const StadiumBorder()),
              //     child: const Text(tEditProfile,
              //         style: TextStyle(color: tDarkColor)),
              //   ),
              // ),
              PrimaryButtonWidget(caption: "Update Profile", onPressed: () {}),
              const SizedBox(height: 30),
              const AppDivider(),
              const SizedBox(height: 10),

              /// -- MENU
              // ProfileMenuWidget(
              //     title: "Settings",
              //     icon: LineAwesomeIcons.cog,
              //     onPress: () {}),
              // ProfileMenuWidget(
              //     title: "Billing Details",
              //     icon: LineAwesomeIcons.wallet,
              //     onPress: () {}),
              // ProfileMenuWidget(
              //     title: "User Management",
              //     icon: LineAwesomeIcons.user_check,
              //     onPress: () {}),
              // const Divider(),
              // const SizedBox(height: 10),
              // ProfileMenuWidget(
              //     title: "Information",
              //     icon: LineAwesomeIcons.info,
              //     onPress: () {}),
              // ProfileMenuWidget(
              //     title: "Logout",
              //     icon: LineAwesomeIcons.alternate_sign_out,
              //     textColor: Colors.red,
              //     endIcon: false,
              //     onPress: () {
              //       Get.defaultDialog(
              //         title: "LOGOUT",
              //         titleStyle: const TextStyle(fontSize: 20),
              //         content: const Padding(
              //           padding: EdgeInsets.symmetric(vertical: 15.0),
              //           child: Text("Are you sure, you want to Logout?"),
              //         ),
              //         confirm: Expanded(
              //           child: ElevatedButton(
              //             onPressed: () =>
              //                 AuthenticationRepository.instance.logout(),
              //             style: ElevatedButton.styleFrom(
              //                 backgroundColor: Colors.redAccent,
              //                 side: BorderSide.none),
              //             child: const Text("Yes"),
              //           ),
              //         ),
              //         cancel: OutlinedButton(
              //             onPressed: () => Get.back(), child: const Text("No")),
              //       );
              //     }),
            ],
          ),
        ),
      ),
    );
  }
}
