import 'package:daycheck/features/roster/presentation/child_detail_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_notification_service.dart';
import '../support.dart';

void main() {
  late FakeRosterRepository repo;

  Widget app() => ProviderScope(
    overrides: [
      rosterRepositoryProvider.overrideWithValue(repo),
      notificationServiceProvider.overrideWithValue(FakeNotificationService()),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: ChildDetailScreen(child: repo.children.first),
    ),
  );

  setUp(() => repo = FakeRosterRepository());

  testWidgets('the schedule calendar opens and shows the weekday header', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    await tester.tap(find.byIcon(Icons.calendar_month_outlined));
    await tester.pumpAndSettle();

    // Mila (seeded in FakeRosterRepository) has no schedule by default, so
    // the calendar renders with "not scheduled" for whatever day opens
    // selected, and the month grid is visible.
    expect(find.byType(GridView), findsOneWidget);
  });

  testWidgets(
    'the photo gallery opens and shows the empty state with no photos',
    (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.photo_library_outlined));
      await tester.pumpAndSettle();

      expect(find.text('No photos yet.'), findsOneWidget);
    },
  );
}
