import 'package:flutter/material.dart';
import 'package:mood_press/gen/assets.gen.dart';

import '../helper/app_themes.dart';

enum AppTheme { normal, noel, pink, green }

class ThemeProvider with ChangeNotifier {
  AppTheme _currentTheme = AppTheme.normal;
  AssetGenImage? _imageBackground;

  AssetGenImage? get imageBackground => _imageBackground;

  AppTheme get currentTheme => _currentTheme;

  ThemeData get themeData {
    switch (_currentTheme) {
      case AppTheme.normal:
        _imageBackground = null;
        return AppThemes.normalTheme;
      case AppTheme.noel:
        _imageBackground = Assets.image.noelImage;
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