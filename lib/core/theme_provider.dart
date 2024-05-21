import 'dart:ui';
import 'package:aplicacion_taller/core/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final Provider<List<Color>> colorListProvider = Provider((ref) => colorList);


final themeNotifierProvider = StateNotifierProvider<ThemeNotifier, AppTheme>((ref) => ThemeNotifier());

class ThemeNotifier extends StateNotifier<AppTheme>{

  ThemeNotifier() : super(AppTheme());

  void toggleDarkMode(){
    state = state.copyWith(isDarkMode: !state.isDarkMode);
  }
}
