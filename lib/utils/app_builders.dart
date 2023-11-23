import 'package:flutter/material.dart';

class AppBuilders {
  static ListView categories(
      Widget? Function(BuildContext, int) itemBuilder, int itemCount) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: itemCount,
      itemBuilder: itemBuilder,
      shrinkWrap: true,
    );
  }
}
