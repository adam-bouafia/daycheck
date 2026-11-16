import 'package:daycheck/core/notifications/notification_service.dart';
import 'package:daycheck/core/theme/app_theme.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/home/presentation/home_gate.dart';
import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';
import 'package:daycheck/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService().init();
  runApp(const ProviderScope(child: MyApp()));
}

/// Matches the device's languages in order of preference; English when
/// none of them is supported. Flutter's own fallback is the first entry
/// of `supportedLocales`, which is alphabetical (Arabic).
Locale resolveLocale(List<Locale>? preferred, Iterable<Locale> supported) {
  for (final locale in preferred ?? const <Locale>[]) {
    for (final s in supported) {
      if (s.languageCode == locale.languageCode) return s;
    }
  }
  return const Locale('en');
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsViewModelProvider);
    final code = settings.languageCode;
    return MaterialApp(
      title: 'DayCheck',
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      darkTheme: appDarkTheme,
      themeMode: settings.themeMode,
      locale: code == null ? null : Locale(code),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeListResolutionCallback: resolveLocale,
      builder: (context, child) => GlassEffects(
        reduced: settings.reduceEffects || MediaQuery.highContrastOf(context),
        child: child!,
      ),
      home: const HomeGate(),
    );
  }
}
