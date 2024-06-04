import 'package:flutter/material.dart';

class Themes {
  Themes();

  final main = ThemeData.dark(useMaterial3: true).copyWith(
    textTheme: const TextTheme(
      // headlines
      headlineLarge: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(fontSize: 48.0, fontStyle: FontStyle.italic),
      headlineSmall: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      // titles
      titleLarge: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
      titleMedium: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
      titleSmall: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold),
      // bodyText
      bodyLarge: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
      bodyMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      bodySmall: TextStyle(fontSize: 12.0, fontFamily: 'Hind'),
      // captions
      labelLarge: TextStyle(fontSize: 16.0, fontFamily: 'Hind'),
      labelMedium: TextStyle(fontSize: 14.0, fontFamily: 'Hind'),
      labelSmall: TextStyle(fontSize: 12.0, fontFamily: 'Hind'),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      contentPadding: EdgeInsets.zero,
      border: OutlineInputBorder(borderSide: BorderSide.none),
      fillColor: Colors.grey,
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(width: 2),
      ),
    ),
    splashFactory: NoSplash.splashFactory,
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        overlayColor: WidgetStateProperty.all(Colors.grey.withOpacity(0.2)),
        shape: WidgetStateProperty.all(
            BeveledRectangleBorder(borderRadius: BorderRadius.circular(3))),
      ),
    ),
  );
}
