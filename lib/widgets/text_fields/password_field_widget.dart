import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';

class PasswordFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText, hintText;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final TextInputType? keyboardType;
  final Function()? onEditingComplete;
  final TextInputAction? textInputAction;

  const PasswordFieldWidget({
    Key? key,
    required this.labelText,
    required this.controller,
    required this.hintText,
    this.validator,
    this.focusNode,
    this.keyboardType,
    this.onEditingComplete,
    this.textInputAction,
  }) : super(key: key);

  @override
  State<PasswordFieldWidget> createState() => _PasswordFieldWidgetState();
}

class _PasswordFieldWidgetState extends State<PasswordFieldWidget> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      focusNode: widget.focusNode,
      obscureText: obscureText,
      style: AppTextStyle.textField,
      textInputAction: widget.textInputAction ??
          (widget.focusNode == null
              ? TextInputAction.done
              : TextInputAction.next),
      onEditingComplete: widget.onEditingComplete ??
          () {
            if (widget.focusNode != null) {
              // change focus to next field
              widget.focusNode!.nextFocus();
            } else {
              // Unfocus the current field
              FocusScope.of(context).unfocus();
            }
          },
      keyboardType: widget.keyboardType,
      decoration: InputDecoration(
        labelText: widget.labelText.toUpperCase(),
        hintText: widget.hintText,
        labelStyle: AppTextStyle.textField,
        hintStyle: AppTextStyle.textField,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              obscureText = !obscureText;
            });
          },
          icon: Icon(
            obscureText ? Icons.visibility : Icons.visibility_off,
            color: AppColors.darkGrey,
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderGrey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.borderGrey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.primary),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.dangerColor),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: AppColors.dangerColor),
        ),
        errorStyle: AppTextStyle.textField.copyWith(
          color: AppColors.dangerColor,
        ),
        fillColor: AppColors.white,
        filled: true,
      ),
    );
  }
}
