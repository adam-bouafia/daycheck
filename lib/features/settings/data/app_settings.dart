import 'package:flutter/material.dart';

/// The languages the app ships, as (code, name in that language). Shown
/// in their own language so a parent can find theirs whatever the app
/// is currently set to.
const appLanguages = [
  ('nl', 'Nederlands'),
  ('en', 'English'),
  ('fr', 'Français'),
  ('pl', 'Polski'),
  ('de', 'Deutsch'),
  ('tr', 'Türkçe'),
  ('it', 'Italiano'),
  ('he', 'עברית'),
  ('ar', 'العربية'),
];

class AppSettings {
  const AppSettings({
    this.themeMode = ThemeMode.system,
    this.languageCode,
    this.activityPopups = true,
    this.attendancePopups = true,
    this.requestPopups = true,
    this.reduceEffects = false,
  });

  final ThemeMode themeMode;

  /// Null follows the device's language.
  final String? languageCode;

  /// Whether a new activity note also shows a pop-up on the phone. The
  /// in-app notification list gets the entry either way.
  final bool activityPopups;

  /// Check-in, pick-up and absent.
  final bool attendancePopups;
  final bool requestPopups;

  /// Solid panels instead of blurred glass: the blur is the most
  /// expensive thing the app draws, and old phones stutter on it.
  final bool reduceEffects;

  AppSettings copyWith({
    ThemeMode? themeMode,
    String? Function()? languageCode,
    bool? activityPopups,
    bool? attendancePopups,
    bool? requestPopups,
    bool? reduceEffects,
  }) => AppSettings(
    themeMode: themeMode ?? this.themeMode,
    languageCode: languageCode != null ? languageCode() : this.languageCode,
    activityPopups: activityPopups ?? this.activityPopups,
    attendancePopups: attendancePopups ?? this.attendancePopups,
    requestPopups: requestPopups ?? this.requestPopups,
    reduceEffects: reduceEffects ?? this.reduceEffects,
  );

  Map<String, Object?> toJson() => {
    'themeMode': themeMode.name,
    'languageCode': languageCode,
    'activityPopups': activityPopups,
    'attendancePopups': attendancePopups,
    'requestPopups': requestPopups,
    'reduceEffects': reduceEffects,
  };

  factory AppSettings.fromJson(Map<String, dynamic> json) => AppSettings(
    themeMode: ThemeMode.values.firstWhere(
      (m) => m.name == json['themeMode'],
      orElse: () => ThemeMode.system,
    ),
    languageCode: json['languageCode'] as String?,
    activityPopups: json['activityPopups'] as bool? ?? true,
    attendancePopups: json['attendancePopups'] as bool? ?? true,
    requestPopups: json['requestPopups'] as bool? ?? true,
    reduceEffects: json['reduceEffects'] as bool? ?? false,
  );
}
