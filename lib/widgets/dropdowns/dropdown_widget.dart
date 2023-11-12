import 'package:flutter/material.dart';
import 'package:food_delivery_app/constants/app_text_style.dart';
import 'package:food_delivery_app/global/colors/app_colors.dart';
import 'package:ionicons/ionicons.dart';

class DropdownWidget extends StatefulWidget {
  final List items;
  final String? value;
  final String? hint;
  final Function? onChanged;

  const DropdownWidget({
    Key? key,
    required this.items,
    required this.value,
    this.hint,
    this.onChanged,
  }) : super(key: key);

  @override
  State<DropdownWidget> createState() => _DropdownWidgetState();
}

class _DropdownWidgetState extends State<DropdownWidget> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: widget.items.map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
      value: widget.value,
      onChanged: (value) {
        widget.onChanged!(value);
      },
      hint: Text(widget.hint.toString()),
      icon: const Icon(Ionicons.arrow_down),
      borderRadius: BorderRadius.circular(10),
      isExpanded: true,
      style: AppTextStyle.textField,
      isDense: true,
      // change border style
      decoration: InputDecoration(
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
      ),
    );
  }
}
