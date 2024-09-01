import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode selectedThemeMode = ThemeMode.system;

  void setThemeMode(ThemeMode themeMode) {
    selectedThemeMode = themeMode;
    notifyListeners();
  }
}
