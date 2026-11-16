import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/test_app.dart';

void main() {
  late TestApp t;
  setUp(() => t = TestApp());

  Future<void> start(WidgetTester tester, String user) async {
    await tester.pumpWidget(t.build());
    await tester.pumpAndSettle();
    await t.logIn(tester, user, '${user}123');
  }

  group('staff', () {
    testWidgets('gets the daycare home: every child and an attendance count', (
      tester,
    ) async {
      await start(tester, 'sara');

      expect(find.text('Hello, Sara'), findsOneWidget);
      expect(find.text('Children'), findsOneWidget);
      expect(find.text('Log'), findsOneWidget);
      expect(find.text('Today'), findsNothing);
      expect(find.text('Mila de Vries'), findsOneWidget);
      expect(find.text('Noah Jansen'), findsOneWidget);
      // Two tiles plus the summary label.
      expect(find.text('Not arrived'), findsNWidgets(3));
    });

    testWidgets('checks a child in, then out, and both show in the log', (
      tester,
    ) async {
      await start(tester, 'sara');

      await tester.tap(find.text('Mila de Vries'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Check in'));
      await tester.pumpAndSettle();
      expect(find.text('Dropped off by'), findsOneWidget);
      await tester.tap(find.text('Check in').last);
      await tester.pumpAndSettle();
      expect(find.text('Present'), findsOneWidget);

      await tester.tap(find.text('Check out'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Tom de Vries'));
      await tester.tap(find.text('Check out').last);
      await tester.pumpAndSettle();
      expect(find.text('Departed'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.text('Log'));
      await tester.pumpAndSettle();
      expect(find.text('Checked out by Tom de Vries'), findsOneWidget);
      expect(find.text('Checked in by Sanne de Vries'), findsOneWidget);
    });

    testWidgets('a note is signed with the staff member, not checked in', (
      tester,
    ) async {
      await start(tester, 'tim');

      await tester.tap(find.text('Mila de Vries'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add note'));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'Played outside');
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Note by Tim Visser'), findsOneWidget);
      expect(find.text('Not arrived'), findsOneWidget);
      expect(t.roster.events.single.by, 'Tim Visser');
      expect(t.notifications.sent, hasLength(1));
    });
  });

  group('parent', () {
    testWidgets('gets the family home: only their child, no staff actions', (
      tester,
    ) async {
      await start(tester, 'lotte');

      expect(find.text('Hello, Lotte'), findsOneWidget);
      expect(find.text('Today'), findsOneWidget);
      expect(find.text('Children'), findsNothing);
      expect(find.text('Noah Jansen'), findsOneWidget);
      expect(find.text('Mila de Vries'), findsNothing);
      expect(find.text('Check in'), findsNothing);
      expect(find.text('Add note'), findsNothing);
    });

    testWidgets('sees what staff posted and who dropped their child off', (
      tester,
    ) async {
      final now = DateTime.now();
      t.roster.events = [
        DayEvent(
          childId: '2',
          at: now,
          kind: EventKind.checkIn,
          by: 'Lotte Jansen',
        ),
        DayEvent(
          childId: '2',
          at: now,
          kind: EventKind.activityNote,
          by: 'Sara Bakker',
          note: 'Had a great nap',
        ),
      ];
      await start(tester, 'lotte');

      expect(find.text('Present'), findsOneWidget);
      expect(find.textContaining('by Lotte Jansen'), findsWidgets);
      expect(find.text('Had a great nap'), findsOneWidget);
    });
  });

  testWidgets('signing out returns to login and forgets the session', (
    tester,
  ) async {
    await start(tester, 'sara');

    await tester.tap(find.byIcon(Icons.settings_outlined).first);
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(find.text('Sign out'), 200);
    await tester.tap(find.text('Sign out'));
    await tester.pumpAndSettle();

    expect(find.widgetWithText(FilledButton, 'Sign in'), findsOneWidget);
    expect(t.session.username, isNull);
  });
}
