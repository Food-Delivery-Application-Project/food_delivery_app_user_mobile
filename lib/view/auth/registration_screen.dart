import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/blocs/auth/auth_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/app_toast.dart';
import 'package:food_delivery_app/utils/app_validators.dart';
import 'package:food_delivery_app/view/auth/login_screen.dart';
import 'package:food_delivery_app/view/auth/registration_otp_screen.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/text_fields/password_field_widget.dart';
import 'package:food_delivery_app/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  // Blocs
  AuthBloc authBloc = AuthBloc();
  // controllers
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  // focus nodes
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  FocusNode rePasswordFocusNode = FocusNode();

  initBloc() {
    authBloc = authBloc
      ..add(AuthEventRegister(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      ));
  }

  pageNavigation() {
    // remove focus from all the text fields
    emailFocusNode.unfocus();
    hideKeyboard(context);
    AppNavigator.goToPage(
      context: context,
      screen: RegistrationOtpScreen(
        email: emailController.text.trim(),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();

    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    rePasswordFocusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthLoadingState) {
            AppDialogs.loadingDialog(context);
          } else if (state is AuthRegistrationSuccessState) {
            AppDialogs.closeDialog(context);
            pageNavigation();

            AppToast.normal(state.response.message);
          } else if (state is AuthStateFailure) {
            AppDialogs.closeDialog(context);
            AppToast.danger(state.message);
          }
        },
        child: SafeArea(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: ListView(
                children: [
                  20.height,
                  Text('Register on Habibi', style: AppTextStyle.headings),
                  20.height,
                  Text(
                    'Lets create you an account',
                    style: AppTextStyle.subHeading,
                  ),
                  20.height,
                  TextFieldWidget(
                    labelText: 'EMAIL',
                    controller: emailController,
                    hintText: "Enter your email",
                    validator: AppValidators.email,
                    focusNode: emailFocusNode,
                  ),
                  20.height,
                  PasswordFieldWidget(
                    labelText: 'PASSWORD',
                    controller: passwordController,
                    hintText: "Enter your password",
                    validator: AppValidators.password,
                    focusNode: passwordFocusNode,
                  ),
                  20.height,
                  PasswordFieldWidget(
                    labelText: 'RE-PASSWORD',
                    controller: rePasswordController,
                    hintText: "Re-enter your password",
                    focusNode: rePasswordFocusNode,
                    validator: (p0) {
                      return AppValidators.reEnterPassword(
                        p0,
                        passwordController.text,
                      );
                    },
                  ),
                  20.height,
                  // take the available height of the page
                  SizedBox(
                    height: context.height() * 0.3,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        PrimaryButtonWidget(
                            caption: "Register",
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                initBloc();
                              }
                            }),
                        20.height,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text('Already have an account?'),
                            TextButton(
                              onPressed: () {
                                AppNavigator.goToPageWithReplacement(
                                  context: context,
                                  screen: const LoginScreen(),
                                );
                              },
                              child: Text("Login", style: AppTextStyle.button),
                            ),
                          ],
                        ),
                        30.height,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
