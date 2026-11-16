import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/notifications/notification_service.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/data/roster_repository.dart';
import 'package:daycheck/features/roster/data/schedule.dart';
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

/// Same idea, for PDF attachments.
final attachmentsFolderProvider = FutureProvider<Directory>(
  (ref) => ref.read(rosterRepositoryProvider).attachmentsFolder(),
);

class RosterState {
  const RosterState({
    this.children = const [],
    this.events = const [],
    this.schedules = const [],
  });

  final List<Child> children;
  final List<DayEvent> events;
  final List<Schedule> schedules;

  DayStatus statusOf(String childId) => statusFor(childId, events);

  /// Every event for this child today, newest first.
  List<DayEvent> eventsOf(String childId) => eventsFor(childId, events);

  /// Only this child's check-in/out events, newest first.
  List<DayEvent> attendanceOf(String childId) => attendanceFor(childId, events);

  /// This child's weekly schedule, if one is set.
  Schedule? scheduleOf(String childId) =>
      schedules.where((s) => s.childId == childId).firstOrNull;
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
    final schedules = await _repo.loadSchedules();
    state = RosterState(
      children: children,
      events: events,
      schedules: schedules,
    );
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

  /// [photoSourcePath] and [attachmentSourcePath] are paths on the device
  /// (from the image/file picker); each gets copied into the app's own
  /// folder. [note] also serves as the photo's caption, so a photo is
  /// never shown with no description of what it's a photo of.
  Future<void> addActivityNote(
    String childId,
    String note, {
    String by = 'Staff',
    String? photoSourcePath,
    String? attachmentSourcePath,
  }) async {
    final photoName = photoSourcePath == null
        ? null
        : await _repo.addPhoto(photoSourcePath);
    final attachmentName = attachmentSourcePath == null
        ? null
        : await _repo.addAttachment(attachmentSourcePath);
    await _record(
      DayEvent(
        childId: childId,
        at: DateTime.now(),
        kind: EventKind.activityNote,
        by: by,
        note: note,
        photoName: photoName,
        attachmentName: attachmentName,
      ),
    );
    final childName = state.children.firstWhere((c) => c.id == childId).name;
    final l10n = deviceLocalizations();
    final title = l10n.newActivityNotificationTitle(childName);
    await ref
        .read(notificationServiceProvider)
        .showActivityNotification(title, note);
    await ref
        .read(inboxViewModelProvider.notifier)
        .add(title, note, childId: childId);
  }

  Future<void> _record(DayEvent event) async {
    await _repo.appendEvent(event);
    state = RosterState(
      children: state.children,
      events: [...state.events, event],
      schedules: state.schedules,
    );
  }
}

final rosterViewModelProvider = NotifierProvider<RosterViewModel, RosterState>(
  RosterViewModel.new,
);
