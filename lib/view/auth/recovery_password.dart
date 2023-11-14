import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/blocs/auth/auth_bloc.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/app_toast.dart';
import 'package:food_delivery_app/utils/app_validators.dart';
import 'package:food_delivery_app/view/auth/login_screen.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/text_fields/password_field_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RecoveryPasswordScreen extends StatefulWidget {
  const RecoveryPasswordScreen({super.key});

  @override
  State<RecoveryPasswordScreen> createState() => _RecoveryPasswordScreenState();
}

class _RecoveryPasswordScreenState extends State<RecoveryPasswordScreen> {
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  // blocs
  AuthBloc authBloc = AuthBloc();

  // other variables
  String? userId;

  @override
  void initState() {
    // UserSecureStorage.fetchUserId().then((value) {
    //   userId = value;
    // });
    super.initState();
  }

  resetPassword() {
    if (formKey.currentState!.validate()) {
      // authBloc = authBloc
      //   ..add(AuthEventChangePasswordAfterOtpVerification(
      //     userId: userId.toString(),
      //     password: passwordController.text.trim(),
      //   ));
    }
  }

  @override
  void dispose() {
    passwordController.dispose();
    confirmPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: const BackAppbarWidget(),
      body: BlocListener<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthLoadingState) {
            AppDialogs.loadingDialog(context);
          } else if (state is AuthChangePasswordAfterOtpVerificationState) {
            AppDialogs.closeDialog(context);
            AppNavigator.goToPageWithReplacement(
              context: context,
              screen: const LoginScreen(),
            );
          } else if (state is AuthStateFailure) {
            AppDialogs.closeDialog(context);
            AppToast.danger(state.message);
          } else {
            AppDialogs.closeDialog(context);
          }
        },
        child: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    20.height,
                    Text('Recovery Password', style: AppTextStyle.headings),
                    30.height,
                    Text(
                        'Enter your new and confirm password to reset your password.',
                        style: AppTextStyle.subHeading),
                    50.height,
                    PasswordFieldWidget(
                      controller: passwordController,
                      labelText: "Password",
                      hintText: "Password",
                      validator: AppValidators.password,
                    ),
                    30.height,
                    PasswordFieldWidget(
                      controller: confirmPasswordController,
                      labelText: "Re-Password",
                      hintText: "Re-Password",
                      validator: (value) => AppValidators.reEnterPassword(
                        value,
                        passwordController.text.trim(),
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: PrimaryButtonWidget(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    onPressed: () {
                      resetPassword();
                    },
                    caption: 'Reset Password',
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
