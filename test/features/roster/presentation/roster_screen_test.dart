import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support.dart';

void main() {
  late FakeRosterRepository repo;

  Widget app() => ProviderScope(
    overrides: [rosterRepositoryProvider.overrideWithValue(repo)],
    child: const MaterialApp(home: SignInScreen()),
  );

  setUp(() => repo = FakeRosterRepository());

  group('staff', () {
    Future<void> signIn(WidgetTester tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();
      await tester.tap(find.text('Staff'));
      await tester.pumpAndSettle();
    }

    testWidgets('sees every child, each starting not arrived', (tester) async {
      await signIn(tester);

      expect(find.text('Mila de Vries'), findsOneWidget);
      expect(find.text('Noah Jansen'), findsOneWidget);
      expect(find.text('Not arrived'), findsNWidgets(2));
    });

    testWidgets(
      'checking a child in makes them present, leaves the other alone',
      (tester) async {
        await signIn(tester);

        await tester.tap(find.text('Mila de Vries'));
        await tester.pumpAndSettle();
        await tester.tap(find.text('Check in'));
        await tester.pumpAndSettle();
        expect(find.text('Dropped off by'), findsOneWidget);
        await tester.tap(find.text('Check in').last);
        await tester.pumpAndSettle();

        expect(find.text('Present'), findsOneWidget);
        expect(find.text('1 event today'), findsOneWidget);

        await tester.pageBack();
        await tester.pumpAndSettle();
        expect(find.text('Present'), findsOneWidget);
        expect(find.text('Not arrived'), findsOneWidget);
      },
    );

    testWidgets('checking out and the daily log across children', (
      tester,
    ) async {
      await signIn(tester);

      await tester.tap(find.text('Mila de Vries'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Check in'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Check in').last);
      await tester.pumpAndSettle();

      await tester.tap(find.text('Check out'));
      await tester.pumpAndSettle();
      expect(find.text('Picked up by'), findsOneWidget);
      await tester.tap(find.text('Tom de Vries'));
      await tester.tap(find.text('Check out').last);
      await tester.pumpAndSettle();

      expect(find.text('Departed'), findsOneWidget);

      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();
      expect(find.text("Today's log"), findsOneWidget);
      expect(find.text('Checked out by Tom de Vries'), findsOneWidget);
      expect(find.text('Checked in by Sanne de Vries'), findsOneWidget);
    });

    testWidgets('an activity note does not check the child in', (tester) async {
      await signIn(tester);

      await tester.tap(find.text('Mila de Vries'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Add note'));
      await tester.pumpAndSettle();
      await tester.enterText(
        find.byType(TextField),
        'Played outside all morning',
      );
      await tester.tap(find.text('Save'));
      await tester.pumpAndSettle();

      expect(find.text('Played outside all morning'), findsOneWidget);
      expect(find.text('Not arrived'), findsOneWidget);
      expect(repo.events, hasLength(1));
    });
  });

  group('parent', () {
    testWidgets('only sees their own child, and cannot check in or out', (
      tester,
    ) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Lotte Jansen'));
      await tester.pumpAndSettle();

      expect(find.text('Noah Jansen'), findsOneWidget);
      expect(find.text('Mila de Vries'), findsNothing);
      // Staff-only actions don't show in the app bar for a parent.
      expect(find.byIcon(Icons.history), findsNothing);

      await tester.tap(find.text('Noah Jansen'));
      await tester.pumpAndSettle();

      expect(find.text('Check in'), findsNothing);
      expect(find.text('Add note'), findsNothing);
    });

    testWidgets('sees an activity note staff added, read-only', (tester) async {
      repo.events = [
        DayEvent(
          childId: '2',
          at: DateTime.now(),
          kind: EventKind.activityNote,
          by: 'Staff',
          note: 'Had a great nap',
        ),
      ];
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Lotte Jansen'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Noah Jansen'));
      await tester.pumpAndSettle();

      expect(find.text('Had a great nap'), findsOneWidget);
      expect(find.text('Check in'), findsNothing);
    });
  });
}
