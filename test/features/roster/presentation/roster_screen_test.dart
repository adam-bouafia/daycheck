import 'package:daycheck/features/roster/presentation/roster_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support.dart';

void main() {
  late FakeRosterRepository repo;

  Widget app() => ProviderScope(
    overrides: [rosterRepositoryProvider.overrideWithValue(repo)],
    child: const MaterialApp(home: RosterScreen()),
  );

  setUp(() => repo = FakeRosterRepository());

  testWidgets('a child starts not arrived, then present after checking in', (
    tester,
  ) async {
    await tester.pumpWidget(app());
    await tester.pumpAndSettle();

    expect(find.text('Not arrived'), findsOneWidget);

    await tester.tap(find.text('Mila de Vries'));
    await tester.pumpAndSettle();
    expect(find.text('Dropped off by'), findsOneWidget);

    await tester.tap(find.text('Check in'));
    await tester.pumpAndSettle();

    expect(find.text('Present'), findsOneWidget);
    expect(find.textContaining('Checked in at'), findsOneWidget);
  });

  testWidgets(
    'a checked-in child can be checked out, and it appears in the log',
    (tester) async {
      await tester.pumpWidget(app());
      await tester.pumpAndSettle();

      await tester.tap(find.text('Mila de Vries'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Check in'));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Mila de Vries'));
      await tester.pumpAndSettle();
      expect(find.text('Picked up by'), findsOneWidget);
      await tester.tap(find.text('Tom de Vries'));
      await tester.tap(find.text('Check out'));
      await tester.pumpAndSettle();

      expect(find.text('Departed'), findsOneWidget);

      await tester.tap(find.byIcon(Icons.history));
      await tester.pumpAndSettle();
      expect(find.text("Today's log"), findsOneWidget);
      expect(find.text('Checked out by Tom de Vries'), findsOneWidget);
      expect(find.text('Checked in by Sanne de Vries'), findsOneWidget);
    },
  );
}
