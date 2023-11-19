import 'package:flutter/material.dart';

class AppGridDelegate {
  static var categories = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 1.3,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  );

  static var foodItems = const SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    childAspectRatio: 0.8,
    crossAxisSpacing: 10,
    mainAxisSpacing: 10,
  );
}
