import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../support/test_app.dart';

void main() {
  late TestApp t;
  setUp(() => t = TestApp());

  testWidgets('a wrong password shows an error and stays on login', (
    tester,
  ) async {
    await tester.pumpWidget(t.build());
    await tester.pumpAndSettle();

    await t.logIn(tester, 'sara', 'nope');

    expect(find.text('Wrong username or password.'), findsOneWidget);
    expect(find.text('Children'), findsNothing);
    expect(t.session.username, isNull);
  });

  testWidgets('tapping a test account fills in its details', (tester) async {
    // Tall enough that the whole account list is laid out.
    tester.view.physicalSize = const Size(1080, 4000);
    addTearDown(tester.view.reset);
    await tester.pumpWidget(t.build());
    await tester.pumpAndSettle();

    await tester.tap(find.text('Lotte Jansen'));
    await tester.pump();

    final field = tester.widget<TextField>(find.byKey(const Key('username')));
    expect(field.controller!.text, 'lotte');
  });

  testWidgets('a saved session skips the login screen', (tester) async {
    t.session.username = 'sara';
    await tester.pumpWidget(t.build());
    await tester.pumpAndSettle();

    expect(find.text('Hello, Sara'), findsOneWidget);
    expect(find.text('Sign in'), findsNothing);
  });

  testWidgets('shows Dutch when the locale is Dutch', (tester) async {
    await tester.pumpWidget(t.build(locale: const Locale('nl')));
    await tester.pumpAndSettle();

    expect(find.text('Inloggen'), findsOneWidget);
    expect(find.text('Gebruikersnaam'), findsOneWidget);
  });

  testWidgets('Arabic and Hebrew lay the screen out right to left', (
    tester,
  ) async {
    for (final code in ['ar', 'he']) {
      await tester.pumpWidget(t.build(locale: Locale(code)));
      await tester.pumpAndSettle();

      final context = tester.element(find.byType(ListView));
      expect(Directionality.of(context), TextDirection.rtl, reason: code);
    }
    expect(find.text('התחברות'), findsOneWidget);
  });
}
