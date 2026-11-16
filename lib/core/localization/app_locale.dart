import 'dart:ui' as ui;

import 'package:daycheck/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension AppLocaleX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Localized strings for code with no `BuildContext` - a notification
/// raised from a ViewModel, for example. [languageCode] is the in-app
/// choice from Settings; null falls back to the device's language.
AppLocalizations localizationsFor(String? languageCode) {
  final code =
      languageCode ?? ui.PlatformDispatcher.instance.locale.languageCode;
  final supported = AppLocalizations.supportedLocales.firstWhere(
    (l) => l.languageCode == code,
    orElse: () => const Locale('en'),
  );
  return lookupAppLocalizations(supported);
}
