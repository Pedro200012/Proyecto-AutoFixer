import 'package:flutter/material.dart';

final List<Color> colorList = [
  Colors.red,
  Colors.green,
  Colors.blue,
  Colors.yellow,
  Colors.purple,
  Colors.orange,
  Colors.pink,
  Colors.teal,
  Colors.cyan,
  Colors.indigo,
  Colors.lime,
  Colors.amber,
  Colors.brown,
  Colors.grey,
  Colors.blueGrey.shade900,
  Colors.black,
  Colors.white,
  Colors.transparent,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({this.selectedColor = 14, this.isDarkMode = false});

  ThemeData getTheme() {
    return ThemeData(
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.black),
          bodyMedium: TextStyle(color: Colors.black),
          bodySmall: TextStyle(color: Colors.black),
          titleLarge: TextStyle(color: Colors.black),
          titleMedium: TextStyle(color: Colors.black),
          titleSmall: TextStyle(color: Colors.black)
        ),
        colorSchemeSeed: colorList[selectedColor],
        brightness:
            isDarkMode ? Brightness.dark : Brightness.dark // modo oscuro
        );
  }

  AppTheme copyWith({bool? isDarkMode}) {
    return AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}
