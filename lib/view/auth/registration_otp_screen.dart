// ignore_for_file: prefer_const_constructors, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:food_delivery_app/blocs/auth/auth_bloc.dart';
import 'package:food_delivery_app/blocs/timer_cubit/timer_cubit_cubit.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/utils/app_dialogs.dart';
import 'package:food_delivery_app/utils/app_navigator.dart';
import 'package:food_delivery_app/utils/app_validators.dart';
import 'package:food_delivery_app/utils/secure_storage.dart';
import 'package:food_delivery_app/view/auth/login_screen.dart';
import 'package:food_delivery_app/widgets/appbars/back_appbar_widget.dart';
import 'package:food_delivery_app/widgets/buttons/primary_button.dart';
import 'package:food_delivery_app/widgets/text_fields/otp_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class RegistrationOtpScreen extends StatefulWidget {
  final String email;
  const RegistrationOtpScreen({super.key, required this.email});

  @override
  State<RegistrationOtpScreen> createState() => _RegistrationOtpScreenState();
}

class _RegistrationOtpScreenState extends State<RegistrationOtpScreen> {
  final TextEditingController phoneController = TextEditingController();
  final pinController = TextEditingController();
  final focusNode = FocusNode();
  final formKey = GlobalKey<FormState>();
  late OtpTimerCubit otpTimerCubit;

  // blocs
  AuthBloc authBloc = AuthBloc();

  initCubits() {
    otpTimerCubit = context.read<OtpTimerCubit>();
    otpTimerCubit.startOtpIntervals();
  }

  @override
  void initState() {
    super.initState();
    Future.wait([UserSecureStorage.setIsRegistering('true')]);
    Future.delayed(Duration(seconds: 1), () {
      initCubits();
      sendOtp();
    });
  }

  verifyOtp() {
    authBloc = authBloc
      ..add(AuthEventVerifyOtp(
        email: widget.email,
        otp: pinController.text.trim(),
      ));
  }

  sendOtp() {
    authBloc = authBloc..add(AuthEventSendOtp(email: widget.email));
  }

  @override
  void dispose() {
    pinController.dispose();
    focusNode.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BackAppbarWidget(),
      body: BlocConsumer<AuthBloc, AuthState>(
        bloc: authBloc,
        listener: (context, state) {
          if (state is AuthLoadingState) {
            AppDialogs.loadingDialog(context);
          } else if (state is AuthSentOtpState) {
            AppDialogs.closeDialog(context);
            toast(state.response.message);
          } else if (state is AuthVerificationState) {
            AppNavigator.goToPage(
              context: context,
              screen: LoginScreen(),
            );
          } else if (state is AuthVerifyOtpState) {
            AppDialogs.closeDialog(context);
            AppDialogs.otpSuccessDialog(context, onPressed: () {
              // verify email
              authBloc = authBloc
                ..add(AuthEventVerifyEmail(email: widget.email));
            });
          } else if (state is AuthStateFailure) {
            AppDialogs.closeDialog(context);
            toast(state.message);
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(20.w),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      20.height,
                      Text('OTP Verification', style: AppTextStyle.headings),
                      30.height,
                      Text(
                          'A 4 digit code has been sent to your email ${widget.email}',
                          style: AppTextStyle.subHeading),
                      50.height,
                      Center(
                        child: Directionality(
                          // Specify direction if desired
                          textDirection: TextDirection.ltr,
                          child: OtpWidget(
                            pinController: pinController,
                            focusNode: focusNode,
                            validator: AppValidators.otp,
                          ),
                        ),
                      ),
                      30.height,
                      BlocBuilder<OtpTimerCubit, OtpTimerState>(
                        builder: (context, state) {
                          if (state is OtpTimerRunning) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Code send in ',
                                  style: AppTextStyle.codeTextStyle,
                                ),
                                Text('${state.secondsValue} ',
                                    style: AppTextStyle.codeTextStyle),
                                Text(
                                  'seconds',
                                  style: AppTextStyle.codeTextStyle,
                                ),
                                10.width,
                              ],
                            );
                          }
                          if (state is OtpTimerInitial) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  'Sending... ',
                                  style: AppTextStyle.codeTextStyle,
                                ),
                                10.width,
                              ],
                            );
                          } else if (state is OtpTimerStoppedShowButton) {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    otpTimerCubit.startOtpIntervals();
                                    sendOtp();
                                  },
                                  child: Container(
                                    padding: EdgeInsets.only(
                                      bottom: 1.h,
                                    ),
                                    child: Text(
                                      'Click here to resend code',
                                      style: AppTextStyle.codeTextStyle,
                                    ),
                                  ),
                                )
                              ],
                            );
                          }
                          return Container();
                        },
                      ),
                      20.height,
                    ],
                  ),
                  PrimaryButtonWidget(
                    margin: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 20.h,
                    ),
                    onPressed: () async {
                      if (formKey.currentState!.validate()) {
                        verifyOtp();
                      }
                    },
                    caption: 'Verify',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
