import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/presentation/sign_in_screen.dart';
import 'package:daycheck/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../roster/fake_notification_service.dart';
import '../../roster/support.dart';

void main() {
  late FakeRosterRepository repo;

  Widget app(Locale locale) => ProviderScope(
    overrides: [
      rosterRepositoryProvider.overrideWithValue(repo),
      notificationServiceProvider.overrideWithValue(FakeNotificationService()),
    ],
    child: MaterialApp(
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const SignInScreen(),
    ),
  );

  setUp(() => repo = FakeRosterRepository());

  testWidgets('shows English by default', (tester) async {
    await tester.pumpWidget(app(const Locale('en')));
    await tester.pumpAndSettle();

    expect(find.text("Who's using DayCheck?"), findsOneWidget);
    expect(find.text('Staff'), findsOneWidget);
  });

  testWidgets('shows Dutch when the device locale is Dutch', (tester) async {
    await tester.pumpWidget(app(const Locale('nl')));
    await tester.pumpAndSettle();

    expect(find.text('Wie gebruikt DayCheck?'), findsOneWidget);
    expect(find.text('Medewerker'), findsOneWidget);
    expect(find.text('Ouder — kies je naam'), findsOneWidget);
  });
}
