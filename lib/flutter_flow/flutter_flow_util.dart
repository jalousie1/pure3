import 'package:flutter/material.dart';

extension FFNavigationExtension on BuildContext {
  void pushNamed(String routeName) {
    Navigator.pushNamed(this, routeName);
  }
}
