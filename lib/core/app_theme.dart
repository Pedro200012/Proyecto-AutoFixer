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
        colorSchemeSeed: colorList[selectedColor],
        brightness:
            isDarkMode ? Brightness.dark : Brightness.light // modo oscuro
        );
  }

  AppTheme copyWith({bool? isDarkMode}) {
    return AppTheme(
        isDarkMode: isDarkMode ?? this.isDarkMode);
  }
}
