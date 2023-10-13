import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteapp/Constant/themes.dart';
import '../ThemeStore/theme.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

class ThemeState extends StateNotifier<bool> {
  ThemeState() : super(false); // Set an initial value

  void toggleTheme() {
    state = !state;
  }
}

final themeProvider = StateNotifierProvider<ThemeState, bool>((ref) {
  return ThemeState();
});