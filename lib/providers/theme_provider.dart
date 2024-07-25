import 'package:flutter/material.dart';

import '../helper/app_themes.dart';

enum AppTheme { normal, noel, pink, green }

class ThemeProvider with ChangeNotifier {
  AppTheme _currentTheme = AppTheme.normal;

  AppTheme get currentTheme => _currentTheme;

  ThemeData get themeData {
    switch (_currentTheme) {
      case AppTheme.normal:
        return AppThemes.normalTheme;
      case AppTheme.noel:
        return AppThemes.noelTheme;
      case AppTheme.pink:
        return AppThemes.pinkTheme;
      case AppTheme.green:
        return AppThemes.greenTheme;
    }
  }

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    notifyListeners();
  }
}