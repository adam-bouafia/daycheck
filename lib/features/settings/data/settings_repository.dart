import 'dart:convert';

import 'package:daycheck/features/settings/data/app_settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _settingsKey = 'app_settings';

class SettingsRepository {
  Future<AppSettings> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_settingsKey);
    if (raw == null) return const AppSettings();
    return AppSettings.fromJson(jsonDecode(raw) as Map<String, dynamic>);
  }

  Future<void> save(AppSettings settings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_settingsKey, jsonEncode(settings.toJson()));
  }
}
