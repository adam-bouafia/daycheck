import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/notifications/notification_service.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/data/roster_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI seam: tests override this with a fake repository instead of the real
/// one that reads and writes `SharedPreferences` and the photos folder.
final rosterRepositoryProvider = Provider<RosterRepository>(
  (ref) => RosterRepository(),
);

/// DI seam: tests override this with a fake that records calls instead of
/// touching the real notifications plugin.
final notificationServiceProvider = Provider<NotificationService>(
  (ref) => NotificationService(),
);

/// Resolved once and cached, instead of on every rebuild of a photo tile.
final photosFolderProvider = FutureProvider<Directory>(
  (ref) => ref.read(rosterRepositoryProvider).photosFolder(),
);

class RosterState {
  const RosterState({this.children = const [], this.events = const []});

  final List<Child> children;
  final List<DayEvent> events;

  DayStatus statusOf(String childId) => statusFor(childId, events);

  /// Every event for this child today, newest first.
  List<DayEvent> eventsOf(String childId) => eventsFor(childId, events);

  /// Only this child's check-in/out events, newest first.
  List<DayEvent> attendanceOf(String childId) => attendanceFor(childId, events);
}

/// Holds the roster and today's events. The View only reads [RosterState]
/// and calls [checkIn]/[checkOut]/[addActivityNote]; every status shown on
/// screen is derived from the event log, never set directly.
class RosterViewModel extends Notifier<RosterState> {
  RosterRepository get _repo => ref.read(rosterRepositoryProvider);

  @override
  RosterState build() {
    _load();
    return const RosterState();
  }

  Future<void> _load() async {
    final children = await _repo.loadChildren();
    final events = await _repo.loadEvents();
    state = RosterState(children: children, events: events);
  }

  Future<void> checkIn(String childId, String by) => _record(
    DayEvent(
      childId: childId,
      at: DateTime.now(),
      kind: EventKind.checkIn,
      by: by,
    ),
  );

  Future<void> checkOut(String childId, String by) => _record(
    DayEvent(
      childId: childId,
      at: DateTime.now(),
      kind: EventKind.checkOut,
      by: by,
    ),
  );

  /// [photoSourcePath] is a path on the device (e.g. from the image
  /// picker); it gets copied into the app's own photos folder.
  Future<void> addActivityNote(
    String childId,
    String note, {
    String by = 'Staff',
    String? photoSourcePath,
  }) async {
    final photoName = photoSourcePath == null
        ? null
        : await _repo.addPhoto(photoSourcePath);
    await _record(
      DayEvent(
        childId: childId,
        at: DateTime.now(),
        kind: EventKind.activityNote,
        by: by,
        note: note,
        photoName: photoName,
      ),
    );
    final childName = state.children.firstWhere((c) => c.id == childId).name;
    final l10n = deviceLocalizations();
    await ref
        .read(notificationServiceProvider)
        .showActivityNotification(
          l10n.newActivityNotificationTitle(childName),
          note,
        );
  }

  Future<void> _record(DayEvent event) async {
    await _repo.appendEvent(event);
    state = RosterState(
      children: state.children,
      events: [...state.events, event],
    );
  }
}

final rosterViewModelProvider = NotifierProvider<RosterViewModel, RosterState>(
  RosterViewModel.new,
);
