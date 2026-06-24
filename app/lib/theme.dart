import 'package:flutter/material.dart';

const Color kGold = Color(0xFFB8860B);
const Color kGoldLight = Color(0xFFDAA520);
const Color kBg = Color(0xFF1A1A1A);
const Color kSurface = Color(0xFF2A2A2A);

ThemeData troopersTheme() {
  return ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme.dark(
      primary: kGold,
      secondary: kGoldLight,
      surface: kSurface,
      onPrimary: Colors.black,
    ),
    scaffoldBackgroundColor: kBg,
    cardColor: kSurface,
    appBarTheme: const AppBarTheme(
      backgroundColor: kBg,
      foregroundColor: kGold,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: TextStyle(
        color: kGold,
        fontSize: 22,
        fontWeight: FontWeight.w900,
        letterSpacing: 5,
      ),
    ),
    tabBarTheme: const TabBarThemeData(
      labelColor: kGold,
      unselectedLabelColor: Colors.white38,
      indicatorColor: kGold,
      indicatorSize: TabBarIndicatorSize.tab,
    ),
    inputDecorationTheme: const InputDecorationTheme(
      isDense: true,
      border: UnderlineInputBorder(),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.white24),
      ),
      focusedBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kGold),
      ),
      labelStyle: TextStyle(color: Colors.white38, fontSize: 11),
      contentPadding: EdgeInsets.symmetric(vertical: 4),
    ),
    dividerColor: Colors.white12,
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (states) => states.contains(WidgetState.selected) ? kGold : null,
      ),
      checkColor: WidgetStateProperty.all(Colors.black),
    ),
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.white70),
    ),
  );
}
