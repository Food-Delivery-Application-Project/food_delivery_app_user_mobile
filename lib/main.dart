import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/constants/bloc_provider.dart';
import 'package:food_delivery_app/global/themes/app_theme.dart';
import 'package:food_delivery_app/view/bottom_nav_bar/main_tabs_screen.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await initialize();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return ScreenUtilInit(
      designSize: Size(width, height),
      builder: (context, child) {
        return GestureDetector(
          onTap: () {
            hideKeyboard(context);
          },
          child: MultiBlocProvider(
            providers: BlocProviders.providers,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Habibi',
              navigatorKey: navigatorKey,
              theme: AppTheme.light,
              home: const MainTabsScreen(index: 0),
            ),
          ),
        );
      },
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
