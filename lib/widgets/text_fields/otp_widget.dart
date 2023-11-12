import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:pinput/pinput.dart';

class OtpWidget extends StatefulWidget {
  final TextEditingController pinController;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  const OtpWidget({
    Key? key,
    required this.pinController,
    this.focusNode,
    this.validator,
  }) : super(key: key);

  @override
  State<OtpWidget> createState() => _OtpWidgetState();
}

class _OtpWidgetState extends State<OtpWidget> {
  // Colors
  final focusedBorderColor = AppColors.primary;
  final borderColor = AppColors.borderGrey;

  // Themes
  late PinTheme defaultPinTheme;
  late PinTheme errorPinTheme;
  late PinTheme focusedPinTheme;

  @override
  void initState() {
    setThemes();
    super.initState();
  }

  setThemes() {
    defaultPinTheme = PinTheme(
      width: 70,
      height: 80,
      textStyle: AppTextStyle.pinput,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: borderColor),
      ),
    );

    errorPinTheme = PinTheme(
      width: 70,
      height: 80,
      textStyle: AppTextStyle.pinput,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.dangerColor),
      ),
    );

    focusedPinTheme = PinTheme(
      width: 70,
      height: 80,
      textStyle: AppTextStyle.pinput,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(19),
        border: Border.all(color: AppColors.primary),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Pinput(
      controller: widget.pinController,
      focusNode: widget.focusNode,
      showCursor: true,
      closeKeyboardWhenCompleted: true,
      validator: widget.validator,
      defaultPinTheme: PinTheme(
        width: 70,
        height: 80,
        textStyle: const TextStyle(
          fontSize: 22,
          color: AppColors.darkGrey,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(19),
          border: Border.all(color: borderColor),
        ),
      ),
      length: 4,
      pinAnimationType: PinAnimationType.scale,
      separatorBuilder: (index) => const SizedBox(width: 20),
      onCompleted: (pin) {
        debugPrint('onCompleted: $pin');
      },
      onChanged: (value) {
        debugPrint('onChanged: $value');
      },
      cursor: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 9),
            width: 50,
            height: 1,
            color: focusedBorderColor,
          ),
        ],
      ),
      focusedPinTheme: focusedPinTheme,
      submittedPinTheme: defaultPinTheme,
      errorPinTheme: errorPinTheme,
    );
  }
}
