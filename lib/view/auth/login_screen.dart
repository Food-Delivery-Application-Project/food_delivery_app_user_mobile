// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/auth/auth_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/global/fonts/app_fonts.dart';
import 'package:food_delivery_app/global/pixels/app_pixels.dart';
import 'package:food_delivery_app/models/auth/login_model.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/app_validators.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/view/auth/forget_password.dart';
import 'package:food_delivery_app/view/auth/registration_screen.dart';
import 'package:food_delivery_app/view/bottom_nav_bar/main_tabs_screen.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/text_fields/password_field_widget.dart';
import 'package:food_delivery_app/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

import 'complete_profile_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Blocs
  AuthBloc authBloc = AuthBloc();
  // Controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  // Focus Nodes
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();

  // Form key
  final formKey = GlobalKey<FormState>();

  // other variables
  String? isRegistering;

  @override
  void initState() {
    UserSecureStorage.fetchIsRegistering().then((value) {
      isRegistering = value;
    });
    super.initState();
  }

  initLocalStorage(LoginModel data) async {
    Future.wait([
      UserSecureStorage.setToken(data.accessToken.toString()),
      UserSecureStorage.setUserId(data.userId.toString()),
    ]);
  }

  login() {
    if (formKey.currentState!.validate()) {
      authBloc = authBloc
        ..add(
          AuthEventLogin(
            email: emailController.text.trim(),
            password: passwordController.text.trim(),
          ),
        );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<AuthBloc, AuthState>(
          bloc: authBloc,
          listener: (context, state) async {
            if (state is AuthLoadingState) {
              // unfocus keyboard
              FocusScope.of(context).unfocus();
              // show loading
              AppDialogs.loadingDialog(context);
            } else if (state is AuthLoginState) {
              AppDialogs.closeDialog(context);
              await initLocalStorage(state.response.data);
              if (state.response.data.isNewUser == true) {
                AppNavigator.goToPage(
                  context: context,
                  screen: const CompleteProfileScreen(),
                );
              } else {
                AppNavigator.goToPage(
                  context: context,
                  screen: const MainTabsScreen(index: 0),
                );
              }
            } else if (state is AuthStateFailure) {
              AppDialogs.closeDialog(context);
              toast(state.message);
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          20.height,
                          Text('Welcome Back', style: AppTextStyle.headings),
                          20.height,
                          Text(
                            'Lets get back to connect you to LetsCom, shall we',
                            style: AppTextStyle.subHeading,
                          ),
                          20.height,
                          TextFieldWidget(
                            labelText: 'EMAIL',
                            controller: emailController,
                            hintText: "Enter your email",
                            validator: AppValidators.email,
                          ),
                          20.height,
                          PasswordFieldWidget(
                            labelText: 'PASSWORD',
                            controller: passwordController,
                            hintText: "Enter your password",
                            validator: AppValidators.password,
                          ),
                          20.height,
                          // Forgot password
                          TextButton(
                            onPressed: () {
                              AppNavigator.goToPage(
                                context: context,
                                screen: const ForgetPasswordScreen(),
                              );
                            },
                            child: Text(
                              "Forgot password?",
                              style: TextStyle(
                                color: AppColors.primary,
                                fontWeight: FontWeight.bold,
                                fontFamily: AppFonts.poppins,
                                decoration: TextDecoration.underline,
                                decorationColor: AppColors.primary,
                                fontSize: AppPixels.subHeading,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: context.height() * 0.3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                PrimaryButtonWidget(
                                  caption: "Login",
                                  onPressed: login,
                                ),
                              ],
                            ),
                          ),
                          20.height,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text("Don't have an account?"),
                              TextButton(
                                onPressed: () {
                                  AppNavigator.goToPageWithReplacement(
                                    context: context,
                                    screen: const RegistrationScreen(),
                                  );
                                },
                                child: Text(
                                  "Register",
                                  style: AppTextStyle.button,
                                ),
                              ),
                            ],
                          ),
                          30.height,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
