import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/notifications/notification_service.dart';
import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/data/roster_repository.dart';
import 'package:daycheck/features/roster/data/schedule.dart';
import 'package:daycheck/features/settings/data/app_settings.dart';
import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';
import 'package:daycheck/l10n/app_localizations.dart';
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

  /// Every event for this child on any day, for the photo gallery.
  List<DayEvent> allEventsOf(String childId) => allEventsFor(childId, events);

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

  Future<void> checkIn(String childId, String by) async {
    await _record(
      DayEvent(
        childId: childId,
        at: DateTime.now(),
        kind: EventKind.checkIn,
        by: by,
      ),
    );
    final l10n = _l10n;
    await _notifyFamily(
      childId,
      l10n.checkedInNotificationTitle(_nameOf(childId)),
      l10n.checkedInAtBy(_clock(DateTime.now()), by),
      popup: _settings.attendancePopups,
    );
  }

  Future<void> checkOut(String childId, String by) async {
    await _record(
      DayEvent(
        childId: childId,
        at: DateTime.now(),
        kind: EventKind.checkOut,
        by: by,
      ),
    );
    final l10n = _l10n;
    await _notifyFamily(
      childId,
      l10n.checkedOutNotificationTitle(_nameOf(childId)),
      l10n.checkedOutAtBy(_clock(DateTime.now()), by),
      popup: _settings.attendancePopups,
    );
  }

  /// Staff record that a child is not coming today. Every guardian is
  /// told, so a parent who did not drop the child off still knows.
  Future<void> markAbsent(String childId, String by, {String? reason}) async {
    final text = reason?.trim();
    await _record(
      DayEvent(
        childId: childId,
        at: DateTime.now(),
        kind: EventKind.absent,
        by: by,
        note: text == null || text.isEmpty ? null : text,
      ),
    );
    final l10n = _l10n;
    await _notifyFamily(
      childId,
      l10n.absentNotificationTitle(_nameOf(childId)),
      text == null || text.isEmpty ? l10n.markedAbsentBy(by) : text,
      popup: _settings.attendancePopups,
    );
  }

  /// Takes back today's most recent check-in, pick-up or absence, for a
  /// tap on the wrong child or the wrong button. The family is told,
  /// because they were told about the original.
  Future<void> undoLastAttendance(String childId) async {
    final last = state.attendanceOf(childId).firstOrNull;
    if (last == null) return;
    final events = [
      for (final e in state.events)
        if (!identical(e, last)) e,
    ];
    await _repo.saveEvents(events);
    state = RosterState(
      children: state.children,
      events: events,
      schedules: state.schedules,
    );
    final l10n = _l10n;
    final what = switch (last.kind) {
      EventKind.checkIn => l10n.checkedInBy(last.by),
      EventKind.checkOut => l10n.checkedOutBy(last.by),
      _ => l10n.markedAbsentBy(last.by),
    };
    await _notifyFamily(
      childId,
      l10n.correctionNotificationTitle(_nameOf(childId)),
      l10n.eventUndone(what),
      popup: _settings.attendancePopups,
    );
  }

  /// Demo only: back to the seeded children with an empty day.
  Future<void> resetDemoData() async {
    await _repo.saveEvents(const []);
    state = RosterState(children: state.children, schedules: state.schedules);
  }

  AppSettings get _settings => ref.read(settingsViewModelProvider);
  AppLocalizations get _l10n => localizationsFor(_settings.languageCode);
  String _nameOf(String childId) =>
      state.children.firstWhere((c) => c.id == childId).name;
  String _clock(DateTime t) =>
      '${t.hour.toString().padLeft(2, '0')}:${t.minute.toString().padLeft(2, '0')}';

  /// One entry in the in-app list for the child's family (both parents
  /// read it, on their own accounts), and a pop-up when switched on.
  Future<void> _notifyFamily(
    String childId,
    String title,
    String body, {
    required bool popup,
  }) async {
    if (popup) {
      await ref
          .read(notificationServiceProvider)
          .showActivityNotification(title, body);
    }
    await ref
        .read(inboxViewModelProvider.notifier)
        .add(
          title,
          body,
          childId: childId,
          forStaff: false,
          link: InboxLink.child,
        );
  }

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
        note: note.isEmpty ? null : note,
        photoName: photoName,
        attachmentName: attachmentName,
      ),
    );
    await _notifyFamily(
      childId,
      _l10n.newActivityNotificationTitle(_nameOf(childId)),
      note.isEmpty ? _l10n.photoAdded : note,
      popup: _settings.activityPopups,
    );
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
