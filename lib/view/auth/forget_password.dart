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
import 'package:food_delivery_app/view/auth/otp_screen.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/text_fields/text_fields_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({super.key});

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  // Controllers
  final TextEditingController emailController = TextEditingController();

  // form key
  final formKey = GlobalKey<FormState>();

  // Blocs
  AuthBloc authBloc = AuthBloc();

  initBloc() {
    authBloc = authBloc
      ..add(AuthEventSendVerificationForPasswordReset(
        email: emailController.text.trim(),
      ));
  }

  navigate() {
    Future.delayed(const Duration(seconds: 1), () {
      AppNavigator.goToPage(
          context: context,
          screen: OtpScreen(
            email: emailController.text.trim(),
          ));
    });
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
          } else if (state is AuthSendVerificationForPasswordResetState) {
            AppDialogs.closeDialog(context);
            AppToast.success(state.response.message);
            navigate();
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
                    Text('Forgot password', style: AppTextStyle.headings),
                    30.height,
                    Text('Please enter your email below to receive your OTP ',
                        style: AppTextStyle.subHeading),
                    50.height,
                    TextFieldWidget(
                      controller: emailController,
                      labelText: "EMAIL",
                      hintText: "Enter your email",
                      validator: AppValidators.email,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.w),
                  child: PrimaryButtonWidget(
                    margin:
                        EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        // remove focus from the text field
                        hideKeyboard(context);
                        // initBloc();
                        AppNavigator.goToPage(
                          context: context,
                          screen: OtpScreen(email: ""),
                        );
                      }
                    },
                    caption: 'Send OTP',
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
