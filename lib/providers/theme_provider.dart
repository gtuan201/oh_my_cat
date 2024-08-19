import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:mood_press/gen/assets.gen.dart';
import 'package:mood_press/ulti/constant.dart';

import '../helper/app_themes.dart';

enum AppTheme {
  normal,
  noel,
  bear;

  AssetGenImage? get image {
    switch (this) {
      case AppTheme.noel:
        return Assets.image.noelImage;
      case AppTheme.bear:
        return Assets.image.bear;
      default:
        return null;
    }
  }

  AssetGenImage get imageThumb {
    switch (this) {
      case AppTheme.noel:
        return Assets.image.bearThumb;
      case AppTheme.bear:
        return Assets.image.bearThumb;
      default:
        return Assets.image.bearThumb;
    }
  }

  AssetGenImage get imagePreview {
    switch (this) {
      case AppTheme.noel:
        return Assets.image.bearPreview;
      case AppTheme.bear:
        return Assets.image.bearPreview;
      default:
        return Assets.image.bearPreview;
    }
  }
}

class ThemeProvider with ChangeNotifier {
  final FlutterSecureStorage storage;
  AppTheme _currentTheme = AppTheme.normal;
  AssetGenImage? _imageBackground;

  ThemeProvider({required this.storage});

  AssetGenImage? get imageBackground => _imageBackground;

  AppTheme get currentTheme => _currentTheme;

  ThemeData get themeData {
    switch (_currentTheme) {
      case AppTheme.normal:
        _imageBackground = AppTheme.normal.image;
        return AppThemes.normalTheme;
      case AppTheme.noel:
        _imageBackground = AppTheme.noel.image;
        return AppThemes.noelTheme;
      case AppTheme.bear:
        _imageBackground = AppTheme.bear.image;
        return AppThemes.bearTheme;
      default:
        _imageBackground = AppTheme.normal.image;
        return AppThemes.normalTheme;
    }
  }

  void setTheme(AppTheme theme) {
    _currentTheme = theme;
    storage.write(key: Constant.theme, value: theme.name);
    notifyListeners();
  }
  Future<void> getTheme() async {
    String? themeName = await storage.read(key: Constant.theme);
    if(themeName != null){
      _currentTheme = AppTheme.values.firstWhere((theme) => theme.name == themeName);
    }
    else{
      _currentTheme = AppTheme.normal;
    }
    notifyListeners();
  }
}