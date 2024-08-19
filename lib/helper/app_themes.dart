import 'package:flutter/material.dart';
import 'package:mood_press/gen/colors.gen.dart';

class AppThemes {
  static final ThemeData normalTheme = ThemeData(
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
    ),
    colorScheme: ColorScheme(
      primary: Colors.lightBlue,
      secondary: Colors.blueGrey.shade400,
      surface: Colors.white,
      error: Colors.red,
      onPrimary: Colors.lightBlue.shade100,
      onSecondary: Colors.blueGrey.shade500,
      onSurface: Colors.black,
      onError: Colors.white,
      brightness: Brightness.light,
    ),
    primaryColor: ColorName.colorPrimary,
    splashColor: Colors.teal,
    cardTheme: CardTheme(
      color: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
      shadowColor: Colors.blueGrey.withBlue(140)
    ),
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
      iconTheme: IconThemeData(color: Colors.white),
    ),
    cardColor: ColorName.darkBlue,
    dividerColor: Colors.blueGrey.shade700.withGreen(100).withOpacity(0.6),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.all(Colors.tealAccent),
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return Colors.teal;
        }
        return Colors.grey.shade200;
      }),
      overlayColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.5)),
    ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: ColorName.colorBackground
    ),
  );

  static final ThemeData bearTheme = ThemeData(
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
              color: Colors.orange.shade200
          ),
        bodyLarge: TextStyle(
            color: Colors.orange.shade200,
            fontWeight: FontWeight.w600,
            fontSize: 19
        ),
      ),
      colorScheme: ColorScheme(
        primary: const Color(0xfff8962b),
        secondary: const Color(0xffAB9387),
        surface: Colors.white,
        error: Colors.red,
        onPrimary: Colors.orangeAccent.shade100,
        onSecondary: const Color(0xffC4B3AB),
        onSurface: Colors.black,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    primaryColor: const Color(0xff211507),
    splashColor: const Color(0xfffda84a),
    cardTheme: const CardTheme(
        color: Color(0x8e705d49),
        shadowColor: Color(0xff987450)
    ),
    appBarTheme: const AppBarTheme(
        titleTextStyle: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.w600),
        iconTheme: IconThemeData(color: Colors.white),
    ),
    cardColor: const Color(0xff3c2202),
    dividerColor: const Color(0xffE4BE9E).withOpacity(0.3),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.orange),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xffe8ab76);
          }
          return Colors.grey.shade200;
        }),
        overlayColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.5)),
      ),
    bottomAppBarTheme: const BottomAppBarTheme(
      color: Color(0xff413730)
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
            color: Colors.orange.shade200
        ),
        bodyLarge: TextStyle(
            color: Colors.orange.shade200,
            fontWeight: FontWeight.w600,
            fontSize: 19
        ),
      ),
      primaryColor: const Color(0xff211507),
      splashColor: const Color(0xfffda84a),
      cardTheme: const CardTheme(
          color: Color(0x8e705d49),
          shadowColor: Color(0xff987450)
      ),
      cardColor: const Color(0xff3c2202),
      dividerColor: const Color(0xffE4BE9E).withOpacity(0.3),
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.all(Colors.orange),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const Color(0xffe8ab76);
          }
          return Colors.grey.shade200;
        }),
        overlayColor: WidgetStateProperty.all(Colors.blue.withOpacity(0.5)),
      ),
      bottomAppBarTheme: const BottomAppBarTheme(
          color: Color(0xff413730)
      )
  );
}