// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class ThemeService {
  final _getStorage = GetStorage();
  final _storageKey = "isDarkMode";

  bool isDarkModeActive() {
    var isDarkModeActive = _getStorage.read(_storageKey);
    if (isDarkModeActive == null) {
      isDarkModeActive = false;
      _getStorage.write(_storageKey, isDarkModeActive);
    }
    return isDarkModeActive;
  }

  ThemeMode getThemeMode() {
    return isDarkModeActive() ? ThemeMode.dark : ThemeMode.light;
  }

  void _saveThemeMode(bool isDarkMode) {
    _getStorage.write(_storageKey, isDarkMode);
  }

  void changeThemeMode() {
    Get.changeThemeMode(isDarkModeActive() ? ThemeMode.light : ThemeMode.dark);
    _saveThemeMode(!isDarkModeActive());
  }
}
