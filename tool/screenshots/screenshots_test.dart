// Renders every screen in light and dark mode into docs/img/screens/.
//
//   flutter test tool/screenshots/screenshots_test.dart --update-goldens
//
// Lives outside test/ so CI never compares these pixels: font rendering
// differs between machines. Uses the Roboto and Material Icons fonts from
// the Flutter SDK cache and Noto Hebrew/Arabic from the system, so the
// screenshots show real text instead of the test font's boxes.
import 'dart:io';

import 'package:daycheck/core/theme/app_theme.dart';
import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../test/features/roster/support.dart';
import '../../test/support/test_app.dart';

final _flutterRoot =
    Platform.environment['FLUTTER_ROOT'] ??
    File(Platform.resolvedExecutable)
        .parent
        .parent
        .parent
        .parent
        .parent
        .parent
        .path;
final _photos = Directory('tool/screenshots/photos').absolute;

class _ShotRoster extends FakeRosterRepository {
  @override
  Future<Directory> photosFolder() async => _photos;
}

Future<void> _loadFont(String family, List<String> paths) async {
  final loader = FontLoader(family);
  for (final p in paths) {
    final f = File(p);
    if (f.existsSync()) {
      final bytes = f.readAsBytesSync();
      loader.addFont(Future.value(ByteData.view(bytes.buffer)));
    }
  }
  await loader.load();
}

DateTime _today(int h, int m) {
  final n = DateTime.now();
  return DateTime(n.year, n.month, n.day, h, m);
}

TestApp _demoApp() {
  final roster = _ShotRoster()
    ..children = const [
      Child(
        id: '1',
        name: 'Mila de Vries',
        guardians: ['Sanne de Vries', 'Tom de Vries'],
      ),
      Child(id: '2', name: 'Noah Jansen', guardians: ['Lotte Jansen']),
      Child(
        id: '3',
        name: 'Yusuf El Amrani',
        guardians: ['Amina El Amrani', 'Karim El Amrani'],
      ),
    ]
    ..schedules = const [
      Schedule(
        childId: '1',
        weekdays: {1, 2, 3, 4, 5},
        startMinutes: 7 * 60,
        endMinutes: 18 * 60,
      ),
      Schedule(
        childId: '2',
        weekdays: {1, 3, 5},
        startMinutes: 8 * 60,
        endMinutes: 17 * 60,
      ),
    ]
    ..events = [
      DayEvent(
        childId: '1',
        at: _today(8, 5),
        kind: EventKind.checkIn,
        by: 'Sanne de Vries',
      ),
      DayEvent(
        childId: '2',
        at: _today(7, 40),
        kind: EventKind.absent,
        by: 'Sara Bakker',
        note: 'Sick, fever since last night',
      ),
      DayEvent(
        childId: '1',
        at: _today(10, 20),
        kind: EventKind.activityNote,
        by: 'Sara Bakker',
        note: 'Painted autumn leaves with her fingers',
        photoName: 'painting.jpg',
      ),
      DayEvent(
        childId: '1',
        at: _today(11, 45),
        kind: EventKind.activityNote,
        by: 'Tim Visser',
        note: 'Built a tower with the big blocks',
        photoName: 'blocks.jpg',
      ),
      DayEvent(
        childId: '1',
        at: _today(13, 10),
        kind: EventKind.activityNote,
        by: 'Sara Bakker',
        note: 'Permission form for the petting zoo visit',
        attachmentName: 'permission_petting_zoo.pdf',
      ),
      DayEvent(
        childId: '1',
        at: _today(15, 30),
        kind: EventKind.activityNote,
        by: 'Tim Visser',
        note: 'Played in the garden',
        photoName: 'garden.jpg',
      ),
    ];
  final app = TestApp(roster: roster);
  app.requests.requests = [
    LeaveRequest(
      id: 'r1',
      childId: '2',
      type: RequestType.leave,
      date: _today(0, 0).add(const Duration(days: 7)),
      note: 'Family visit',
      requestedBy: 'Lotte Jansen',
      requestedAt: _today(9, 0),
    ),
    LeaveRequest(
      id: 'r2',
      childId: '1',
      type: RequestType.extraHours,
      date: _today(0, 0).add(const Duration(days: 3)),
      requestedBy: 'Sanne de Vries',
      requestedAt: _today(8, 30),
      status: RequestStatus.approved,
    ),
  ];
  app.inbox.items = [
    InboxItem(
      id: 'i1',
      title: 'Leave request for Noah Jansen',
      body: 'Requested by Lotte Jansen',
      at: _today(9, 0),
      childId: '2',
      link: InboxLink.request,
    ),
    InboxItem(
      id: 'i2',
      title: 'New activity for Mila de Vries',
      body: 'Played in the garden',
      at: _today(15, 30),
      childId: '1',
      forStaff: false,
      link: InboxLink.child,
    ),
    InboxItem(
      id: 'i3',
      title: 'New activity for Mila de Vries',
      body: 'Painted autumn leaves with her fingers',
      at: _today(10, 20),
      childId: '1',
      forStaff: false,
      link: InboxLink.child,
      readBy: const {'sanne'},
    ),
    InboxItem(
      id: 'i4',
      title: 'Mila de Vries has arrived',
      body: 'Checked in at 08:05 by Sanne de Vries',
      at: _today(8, 5),
      childId: '1',
      forStaff: false,
      link: InboxLink.child,
      readBy: const {'sanne'},
    ),
    InboxItem(
      id: 'i5',
      title: 'Request approved for Mila de Vries',
      body: '',
      at: _today(8, 40),
      childId: '1',
      forStaff: false,
      link: InboxLink.request,
      readBy: const {'sanne'},
    ),
  ];
  return app;
}

ThemeData _withFallback(ThemeData t) => t.copyWith(
  textTheme: t.textTheme.apply(
    fontFamilyFallback: ['NotoHebrew', 'NotoArabic'],
  ),
);

void main() {
  setUpAll(() async {
    final fonts = '$_flutterRoot/bin/cache/artifacts/material_fonts';
    await _loadFont('Roboto', [
      '$fonts/Roboto-Regular.ttf',
      '$fonts/Roboto-Medium.ttf',
      '$fonts/Roboto-Bold.ttf',
    ]);
    await _loadFont('MaterialIcons', ['$fonts/MaterialIcons-Regular.otf']);
    await _loadFont('NotoHebrew', [
      '/usr/share/fonts/google-noto-vf/NotoSansHebrew[wght].ttf',
    ]);
    await _loadFont('NotoArabic', [
      '/usr/share/fonts/google-noto-vf/NotoSansArabic[wght].ttf',
    ]);
  });

  Future<void> photosLoaded(WidgetTester tester) async {
    final context = tester.element(find.byType(Scaffold).first);
    await tester.runAsync(() async {
      for (final f in _photos.listSync().whereType<File>()) {
        final file = FileImage(f);
        for (final w in [null, 480, 900]) {
          await precacheImage(
            ResizeImage.resizeIfNeeded(w, null, file),
            context,
          );
        }
      }
    });
    await tester.pumpAndSettle();
  }

  for (final mode in [ThemeMode.light, ThemeMode.dark]) {
    final dir = mode == ThemeMode.light ? 'light' : 'dark';

    Future<TestApp> open(WidgetTester tester, String? user) async {
      tester.view.physicalSize = const Size(1080, 2340);
      tester.view.devicePixelRatio = 3;
      addTearDown(tester.view.reset);
      final app = _demoApp();
      app.session.username = user;
      await tester.pumpWidget(
        app.build(
          theme: _withFallback(appTheme),
          darkTheme: _withFallback(appDarkTheme),
          themeMode: mode,
        ),
      );
      // Before any screen asks for them: an image load started by a
      // widget under the test clock never finishes.
      await photosLoaded(tester);
      return app;
    }

    Future<void> shot(WidgetTester tester, String name) async {
      await tester.pumpAndSettle();
      await expectLater(
        find.byType(MaterialApp),
        matchesGoldenFile('../../docs/img/screens/$dir/$name.png'),
      );
    }

    Future<void> tab(WidgetTester tester, String label) async {
      await tester.tap(find.text(label).last);
      await tester.pumpAndSettle();
    }

    testWidgets('$dir: login', (tester) async {
      await open(tester, null);
      await shot(tester, '01-login');
    });

    testWidgets('$dir: staff screens', (tester) async {
      await open(tester, 'sara');
      await shot(tester, '02-staff-children');

      await tester.tap(find.text('Mila de Vries'));
      await tester.pumpAndSettle();
      await shot(tester, '03-staff-child');

      await tester.tap(find.byKey(const Key('status-chip')));
      await tester.pumpAndSettle();
      await shot(tester, '04-staff-status-menu');
      await tester.tapAt(const Offset(180, 100));
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.calendar_month_outlined));
      await tester.pumpAndSettle();
      await shot(tester, '05-calendar');
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.pageBack();
      await tester.pumpAndSettle();

      await tab(tester, 'Log');
      await shot(tester, '06-staff-log');
      await tab(tester, 'Requests');
      await shot(tester, '07-staff-requests');
      await tab(tester, 'Documents');
      await shot(tester, '08-documents');
      await tab(tester, 'Inbox');
      await shot(tester, '09-staff-inbox');

      await tester.tap(
        find.byIcon(Icons.settings_outlined).hitTestable().first,
      );
      await tester.pumpAndSettle();
      await shot(tester, '10-settings');
    });

    testWidgets('$dir: parent screens', (tester) async {
      await open(tester, 'sanne');
      await shot(tester, '11-parent-today');

      await tab(tester, 'Photos');
      await shot(tester, '12-parent-photos');

      await tester.tap(find.byType(Image).first);
      await tester.pumpAndSettle();
      await shot(tester, '13-photo-viewer');
      await tester.pageBack();
      await tester.pumpAndSettle();

      await tab(tester, 'Requests');
      await shot(tester, '14-parent-requests');
      await tab(tester, 'Inbox');
      await shot(tester, '15-parent-inbox');
    });
  }
}
