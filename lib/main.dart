import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/blocs/session/session_bloc.dart';
import 'package:food_delivery_app/constants/app_url.dart';
import 'package:food_delivery_app/constants/bloc_provider.dart';
import 'package:food_delivery_app/global/themes/app_theme.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/view/auth/welcome_screen.dart';
import 'package:food_delivery_app/view/bottom_nav_bar/main_tabs_screen.dart';
import 'package:food_delivery_app/view/splash/splash_screen.dart';
import 'package:nb_utils/nb_utils.dart';

void main() async {
  await AppUrl.load();
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
  SessionBloc sessionBloc = SessionBloc();
  String? userId, token;

  @override
  void initState() {
    UserSecureStorage.fetchUserId().then((value) {
      userId = value;
    });

    UserSecureStorage.fetchToken().then((value) {
      token = value;
    }).then((value) {
      Future.delayed(const Duration(seconds: 1), () {
        sessionBloc.add(
          SessionRefreshEvent(
            token: token.toString(),
            id: userId.toString(),
          ),
        );
      });
    });
    super.initState();
  }

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
              home: BlocBuilder<SessionBloc, SessionState>(
                bloc: sessionBloc,
                builder: (context, state) {
                  if (state is SessionHomeState) {
                    return const MainTabsScreen();
                  } else if (state is SessionLoginState) {
                    return const WelcomeScreen();
                  } else if (state is SessionErrorState) {
                    return const WelcomeScreen();
                  }
                  return const SplashScreen();
                },
              ),
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
