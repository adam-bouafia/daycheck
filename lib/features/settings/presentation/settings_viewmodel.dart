import 'package:daycheck/features/settings/data/app_settings.dart';
import 'package:daycheck/features/settings/data/settings_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI seam: tests override this with a fake repository.
final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(),
);

class SettingsViewModel extends Notifier<AppSettings> {
  SettingsRepository get _repo => ref.read(settingsRepositoryProvider);

  @override
  AppSettings build() {
    _load();
    return const AppSettings();
  }

  Future<void> _load() async {
    state = await _repo.load();
  }

  Future<void> _update(AppSettings next) async {
    state = next;
    await _repo.save(next);
  }

  Future<void> setThemeMode(ThemeMode mode) =>
      _update(state.copyWith(themeMode: mode));

  Future<void> setLanguage(String? code) =>
      _update(state.copyWith(languageCode: () => code));

  Future<void> setActivityPopups(bool on) =>
      _update(state.copyWith(activityPopups: on));

  Future<void> setRequestPopups(bool on) =>
      _update(state.copyWith(requestPopups: on));

  Future<void> setReduceEffects(bool on) =>
      _update(state.copyWith(reduceEffects: on));
}

final settingsViewModelProvider =
    NotifierProvider<SettingsViewModel, AppSettings>(SettingsViewModel.new);
