// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get signInPrompt => 'Who\'s using DayCheck?';

  @override
  String get signInDemoNotice => 'Demo sign-in only, not a real login.';

  @override
  String get roleStaff => 'Staff';

  @override
  String get roleStaffSubtitle =>
      'See every child, check them in/out, add activity notes';

  @override
  String get roleParentPrompt => 'Parent — pick your name';

  @override
  String get roleParentSubtitle => 'See your child, read-only';

  @override
  String get appBarStaff => 'DayCheck · Staff';

  @override
  String appBarParent(String name) {
    return 'DayCheck · $name';
  }

  @override
  String get todaysLogTooltip => 'Today\'s log';

  @override
  String get signOutTooltip => 'Sign out';

  @override
  String get noChildForGuardian => 'No child found for this guardian.';

  @override
  String get statusNotArrived => 'Not arrived';

  @override
  String get statusPresent => 'Present';

  @override
  String get statusDeparted => 'Departed';

  @override
  String get notArrivedYet => 'Not arrived yet';

  @override
  String checkedInAtBy(String time, String name) {
    return 'Checked in at $time by $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'Checked out at $time by $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes today',
      one: '1 note today',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count events today',
      one: '1 event today',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'Check in';

  @override
  String get checkOut => 'Check out';

  @override
  String get addNote => 'Add note';

  @override
  String get todaysActivity => 'Today\'s activity';

  @override
  String get nothingYetToday => 'Nothing yet today.';

  @override
  String checkedInBy(String name) {
    return 'Checked in by $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'Checked out by $name';
  }

  @override
  String noteBy(String name) {
    return 'Note by $name';
  }

  @override
  String checkInChild(String name) {
    return 'Check in $name';
  }

  @override
  String checkOutChild(String name) {
    return 'Check out $name';
  }

  @override
  String get droppedOffBy => 'Dropped off by';

  @override
  String get pickedUpBy => 'Picked up by';

  @override
  String get addActivityNoteTitle => 'Add an activity note';

  @override
  String get whatDidTheyDo => 'What did they do today?';

  @override
  String get addPhoto => 'Add a photo';

  @override
  String get photoAdded => 'Photo added';

  @override
  String get save => 'Save';

  @override
  String get nothingCheckedToday => 'Nothing checked in or out yet today.';

  @override
  String get unknownChild => 'Unknown child';

  @override
  String get activityNoteLabel => 'Activity note';

  @override
  String newActivityNotificationTitle(String name) {
    return 'New activity for $name';
  }

  @override
  String get requestsTooltip => 'Requests';

  @override
  String get requestsTitle => 'Requests';

  @override
  String get requestTypeLeave => 'Leave';

  @override
  String get requestTypeExtraHours => 'Extra hours';

  @override
  String get requestStatusPending => 'Pending';

  @override
  String get requestStatusApproved => 'Approved';

  @override
  String get requestStatusCancelled => 'Cancelled';

  @override
  String get newRequestTitle => 'New request';

  @override
  String get pickDate => 'Pick a date';

  @override
  String get noteOptionalHint => 'Note (optional)';

  @override
  String get submitRequest => 'Submit';

  @override
  String get approve => 'Approve';

  @override
  String get cancelRequest => 'Cancel';

  @override
  String get noRequestsYet => 'No requests yet.';

  @override
  String requestedBy(String name) {
    return 'Requested by $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'Leave request for $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'Extra hours request for $name';
  }

  @override
  String get scheduleTooltip => 'Schedule';

  @override
  String get scheduleTitle => 'Schedule';

  @override
  String scheduledHours(String start, String end) {
    return 'Scheduled $start–$end';
  }

  @override
  String get notScheduledToday => 'Not scheduled this day';

  @override
  String get photosTooltip => 'Photos';

  @override
  String get photosTitle => 'Photos';

  @override
  String get noPhotosYet => 'No photos yet.';
}
