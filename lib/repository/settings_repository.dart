import 'dart:convert';

import 'package:awesome_board_v2/models/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class SettingsRepository {
  Future<Settings> fetchSettings();
  Future<bool> saveSettings(Settings settings);
}

class SettingsRepositorySharedPrefs extends SettingsRepository {
  static const settingsKey = 'settings_object';
  @override
  Future<Settings> fetchSettings() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final res = prefs.getString(settingsKey);
      final map = jsonDecode(res!);
      return Settings.fromMap(map);
    } catch (e) {
      return Settings.defaultSettings;
    }
  }

  @override
  Future<bool> saveSettings(Settings settings) async {
    final prefs = await SharedPreferences.getInstance();
    final res =
        await prefs.setString(settingsKey, jsonEncode(settings.toMap()));
    return res;
  }
}
