/*
 * @Author: dfh
 * @Date: 2024-09-20 07:39:35
 * @LastEditors: dfh
 * @Modified By: dfh
 * @describe: 
 */
import 'package:flutter/material.dart';

class GlobalThemeData {
  static final Color _lightFocusColor = Colors.black.withOpacity(0.12);
  static final Color _darkFocusColor = Colors.white.withOpacity(0.12);

  static ThemeData lightThemeData =themeData(lightColorScheme, _lightFocusColor);
  static ThemeData darkThemeData = themeData(darkColorScheme, _darkFocusColor);

  
  static ThemeData themeData(ColorScheme colorScheme, Color focusColor) {
    return ThemeData(
        colorScheme: colorScheme,
        canvasColor: colorScheme.background,
        scaffoldBackgroundColor: colorScheme.background,
        highlightColor: Colors.transparent,
        focusColor: focusColor);
  }

  static const ColorScheme lightColorScheme = ColorScheme(
    primary: Color.fromRGBO(255, 194, 0, 1),
    onPrimary: Colors.black,
    secondary: Color(0xFFEFF3F3),
    onSecondary: Color(0xFF322942),
    error: Colors.redAccent,
    onError: Colors.white,
    background: Color(0xFFE6EBEB),
    onBackground: Colors.white,
    surface: Color(0xFFFAFBFB),
    onSurface: Color(0xFF241E30),
    brightness: Brightness.light,
  );
  
  static const ColorScheme darkColorScheme = ColorScheme(
    primary: Color.fromRGBO(255, 194, 0, 1),
    secondary: Color(0xFF4D1F7C),
    background: Color(0xFF241E30),
    surface: Color(0xFF1F1929),
    onBackground: Color(0x0DFFFFFF),
    error: Colors.redAccent,
    onError: Colors.white,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    onSurface: Colors.white,
    brightness: Brightness.dark,
  );
}
