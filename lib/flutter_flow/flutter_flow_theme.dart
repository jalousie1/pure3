import 'package:flutter/material.dart';

class FlutterFlowTheme {
  static ThemeData of(BuildContext context) => Theme.of(context);
}

extension FFThemeExtension on ThemeData {
  Color get primary => primaryColor;
  Color get secondary => colorScheme.secondary;
  Color get tertiary => colorScheme.tertiary;
  Color get alternate => Colors.grey;
  Color get primaryText => brightness == Brightness.light ? Colors.black : Colors.white;
  Color get secondaryText => Colors.grey;
  Color get primaryBackground => brightness == Brightness.light ? Colors.white : Colors.black;
  Color get secondaryBackground => brightness == Brightness.light ? Colors.grey[100]! : Colors.grey[900]!;
  Color get info => Colors.blue;
}
