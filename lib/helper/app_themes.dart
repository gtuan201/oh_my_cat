import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData normalTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
    useMaterial3: false,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        disabledBackgroundColor: Colors.grey[500],
        disabledForegroundColor: Colors.black45,
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        color: Colors.white
      ),
      bodyLarge: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 19
      ),
    )
  );

  static final ThemeData noelTheme = ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: false,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          disabledBackgroundColor: Colors.grey[500],
          disabledForegroundColor: Colors.black45,
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      textTheme: TextTheme(
          bodySmall: TextStyle(
              color: Colors.yellowAccent.shade200
          ),
        bodyLarge: TextStyle(
            color: Colors.yellowAccent.shade200,
            fontWeight: FontWeight.w600,
            fontSize: 19
        ),
      )
  );

  static final ThemeData pinkTheme = ThemeData(
    primarySwatch: Colors.pink,
    brightness: Brightness.light,
  );

  static final ThemeData greenTheme = ThemeData(
    primarySwatch: Colors.green,
    brightness: Brightness.light,
  );
}