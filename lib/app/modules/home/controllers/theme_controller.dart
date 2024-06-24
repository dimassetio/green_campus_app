import 'package:flutter/material.dart';
import 'package:get/get.dart';

ThemeController themeC = Get.find<ThemeController>();

class ThemeController extends GetxController {
  // Observable themeMode with initial value
  Rx<ThemeMode> themeMode = ThemeMode.light.obs;

  // Function to switch theme
  void switchTheme(ThemeMode mode) {
    if (mode != currentTheme) {
      themeMode.value = mode;
      Get.changeThemeMode(mode);
    }
    // Save theme mode to persistent storage if needed
    // For example, using SharedPreferences
  }

  // Function to get current theme mode
  ThemeMode get currentTheme => themeMode.value;
}
