import 'dart:ui' as ui;

import 'package:daycheck/l10n/app_localizations.dart';
import 'package:flutter/widgets.dart';

extension AppLocaleX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
}

/// Localized strings picked by the device's own locale, for code with no
/// `BuildContext` — a local notification shown from the ViewModel, for
/// example. There's no in-app language switcher here (unlike MetJou),
/// so the device's locale is the only signal available.
AppLocalizations deviceLocalizations() {
  final locale = ui.PlatformDispatcher.instance.locale;
  final supported = AppLocalizations.supportedLocales.firstWhere(
    (l) => l.languageCode == locale.languageCode,
    orElse: () => const Locale('en'),
  );
  return lookupAppLocalizations(supported);
}
