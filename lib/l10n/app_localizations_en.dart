// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get roleStaff => 'Staff';

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

  @override
  String get addPdf => 'Add a PDF';

  @override
  String get pdfAdded => 'PDF added';

  @override
  String get attachmentLabel => 'Attachment';

  @override
  String get openAttachment => 'Open';

  @override
  String get shareAttachment => 'Share';

  @override
  String get couldNotOpenAttachment => 'Couldn\'t open this file.';

  @override
  String get inboxTitle => 'Notifications';

  @override
  String get noNotificationsYet => 'No notifications yet.';

  @override
  String get markAllRead => 'Mark all read';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'Request approved for $name';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'Request cancelled for $name';
  }

  @override
  String get sharePhoto => 'Share photo';

  @override
  String photoPosition(int index, int count) {
    return '$index of $count';
  }

  @override
  String get settingsTitle => 'Settings';

  @override
  String get languageLabel => 'Language';

  @override
  String get languageSystem => 'Device language';

  @override
  String get themeLabel => 'Appearance';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Light';

  @override
  String get themeDark => 'Dark';

  @override
  String get reduceEffectsLabel => 'Reduce effects';

  @override
  String get reduceEffectsHint =>
      'Solid panels instead of blurred glass. Smoother on older phones.';

  @override
  String get activityPopupsLabel => 'Pop-ups for new activity';

  @override
  String get requestPopupsLabel => 'Pop-ups for requests';

  @override
  String get popupsHint =>
      'Everything still lands in the notification list in the app. These switches only control the pop-up on your phone.';

  @override
  String get loginSubtitle => 'Sign in with your daycare account.';

  @override
  String get usernameLabel => 'Username';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signInButton => 'Sign in';

  @override
  String get loginFailed => 'Wrong username or password.';

  @override
  String get demoAccountsTitle => 'Test accounts';

  @override
  String get demoAccountsHint =>
      'Tap an account to fill in its details. For testing only.';

  @override
  String get roleParent => 'Parent';

  @override
  String get tabChildren => 'Children';

  @override
  String get tabLog => 'Log';

  @override
  String get tabToday => 'Today';

  @override
  String helloName(String name) {
    return 'Hello, $name';
  }

  @override
  String signedInAs(String name) {
    return 'Signed in as $name';
  }
}
