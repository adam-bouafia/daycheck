import 'package:daycheck/features/settings/data/app_settings.dart';
import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';
import 'package:daycheck/l10n/app_localizations.dart';
import 'package:daycheck/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_settings_repository.dart';

void main() {
  test('loads saved settings and saves every change', () async {
    final repo = FakeSettingsRepository(
      const AppSettings(themeMode: ThemeMode.dark, languageCode: 'pl'),
    );
    final container = ProviderContainer(
      overrides: [settingsRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    container.read(settingsViewModelProvider);
    await Future<void>.delayed(Duration.zero);

    expect(container.read(settingsViewModelProvider).languageCode, 'pl');

    final vm = container.read(settingsViewModelProvider.notifier);
    await vm.setLanguage(null);
    await vm.setReduceEffects(true);

    expect(repo.settings.languageCode, isNull);
    expect(repo.settings.reduceEffects, isTrue);
    expect(repo.settings.themeMode, ThemeMode.dark);
  });

  test('settings survive a round trip through JSON', () {
    const settings = AppSettings(
      themeMode: ThemeMode.light,
      languageCode: 'tr',
      activityPopups: false,
      reduceEffects: true,
    );
    final back = AppSettings.fromJson(settings.toJson());

    expect(back.themeMode, ThemeMode.light);
    expect(back.languageCode, 'tr');
    expect(back.activityPopups, isFalse);
    expect(back.requestPopups, isTrue);
    expect(back.reduceEffects, isTrue);
  });

  test('every language in the picker has translations', () {
    final shipped = AppLocalizations.supportedLocales
        .map((l) => l.languageCode)
        .toSet();
    expect(appLanguages.map((l) => l.$1).toSet(), shipped);
  });

  group('resolveLocale', () {
    const supported = AppLocalizations.supportedLocales;

    test('picks the first preferred language the app has', () {
      expect(
        resolveLocale([
          const Locale('ja'),
          const Locale('fr', 'BE'),
        ], supported),
        const Locale('fr'),
      );
    });

    test('falls back to English, not the first locale in the list', () {
      expect(
        resolveLocale([const Locale('ja')], supported),
        const Locale('en'),
      );
      expect(resolveLocale(null, supported), const Locale('en'));
    });
  });
}
