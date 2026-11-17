import 'package:daycheck/features/documents/data/daycare_document.dart';
import 'package:daycheck/features/documents/presentation/documents_screen.dart';
import 'package:daycheck/features/home/presentation/home_gate.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/requests/presentation/requests_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';
import 'package:daycheck/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../features/inbox/fake_inbox_repository.dart';
import '../features/requests/fake_request_repository.dart';
import '../features/roster/fake_notification_service.dart';
import '../features/roster/support.dart';
import '../features/session/fake_session_repository.dart';
import '../features/settings/fake_settings_repository.dart';

/// The real document list, without copying assets to disk.
class FakeDocumentRepository extends DocumentRepository {
  @override
  Future<String> fileFor(DaycareDocument doc) async => '/tmp/${doc.fileName}';
}

/// The whole app from the login gate, with every repository faked.
class TestApp {
  TestApp({FakeRosterRepository? roster})
    : roster = roster ?? FakeRosterRepository();

  final FakeRosterRepository roster;
  final requests = FakeRequestRepository();
  final notifications = FakeNotificationService();
  final inbox = FakeInboxRepository();
  final session = FakeSessionRepository();

  Widget build({
    Locale locale = const Locale('en'),
    ThemeData? theme,
    ThemeData? darkTheme,
    ThemeMode themeMode = ThemeMode.light,
  }) => ProviderScope(
    overrides: [
      rosterRepositoryProvider.overrideWithValue(roster),
      notificationServiceProvider.overrideWithValue(notifications),
      inboxRepositoryProvider.overrideWithValue(inbox),
      requestRepositoryProvider.overrideWithValue(requests),
      settingsRepositoryProvider.overrideWithValue(FakeSettingsRepository()),
      sessionRepositoryProvider.overrideWithValue(session),
      documentRepositoryProvider.overrideWithValue(FakeDocumentRepository()),
    ],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      locale: locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: const HomeGate(),
    ),
  );

  Future<void> logIn(WidgetTester tester, String user, String pass) async {
    await tester.enterText(find.byKey(const Key('username')), user);
    await tester.enterText(find.byKey(const Key('password')), pass);
    await tester.tap(find.widgetWithText(FilledButton, 'Sign in'));
    await tester.pumpAndSettle();
  }

  Future<void> signOut(WidgetTester tester) async {
    await tester.tap(find.byIcon(Icons.settings_outlined).hitTestable().first);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Sign out'),
      200,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();
  }

  Future<void> logOutIn(WidgetTester tester, String user) async {
    await signOut(tester);
    await logIn(tester, user, '${user}123');
  }
}
