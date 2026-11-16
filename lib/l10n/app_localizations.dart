import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_he.dart';
import 'app_localizations_it.dart';
import 'app_localizations_nl.dart';
import 'app_localizations_pl.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('de'),
    Locale('en'),
    Locale('fr'),
    Locale('he'),
    Locale('it'),
    Locale('nl'),
    Locale('pl'),
    Locale('tr'),
  ];

  /// No description provided for @signInPrompt.
  ///
  /// In en, this message translates to:
  /// **'Who\'s using DayCheck?'**
  String get signInPrompt;

  /// No description provided for @signInDemoNotice.
  ///
  /// In en, this message translates to:
  /// **'Demo sign-in only, not a real login.'**
  String get signInDemoNotice;

  /// No description provided for @roleStaff.
  ///
  /// In en, this message translates to:
  /// **'Staff'**
  String get roleStaff;

  /// No description provided for @roleStaffSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See every child, check them in/out, add activity notes'**
  String get roleStaffSubtitle;

  /// No description provided for @roleParentPrompt.
  ///
  /// In en, this message translates to:
  /// **'Parent — pick your name'**
  String get roleParentPrompt;

  /// No description provided for @roleParentSubtitle.
  ///
  /// In en, this message translates to:
  /// **'See your child, read-only'**
  String get roleParentSubtitle;

  /// No description provided for @appBarStaff.
  ///
  /// In en, this message translates to:
  /// **'DayCheck · Staff'**
  String get appBarStaff;

  /// No description provided for @appBarParent.
  ///
  /// In en, this message translates to:
  /// **'DayCheck · {name}'**
  String appBarParent(String name);

  /// No description provided for @todaysLogTooltip.
  ///
  /// In en, this message translates to:
  /// **'Today\'s log'**
  String get todaysLogTooltip;

  /// No description provided for @signOutTooltip.
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get signOutTooltip;

  /// No description provided for @noChildForGuardian.
  ///
  /// In en, this message translates to:
  /// **'No child found for this guardian.'**
  String get noChildForGuardian;

  /// No description provided for @statusNotArrived.
  ///
  /// In en, this message translates to:
  /// **'Not arrived'**
  String get statusNotArrived;

  /// No description provided for @statusPresent.
  ///
  /// In en, this message translates to:
  /// **'Present'**
  String get statusPresent;

  /// No description provided for @statusDeparted.
  ///
  /// In en, this message translates to:
  /// **'Departed'**
  String get statusDeparted;

  /// No description provided for @notArrivedYet.
  ///
  /// In en, this message translates to:
  /// **'Not arrived yet'**
  String get notArrivedYet;

  /// No description provided for @checkedInAtBy.
  ///
  /// In en, this message translates to:
  /// **'Checked in at {time} by {name}'**
  String checkedInAtBy(String time, String name);

  /// No description provided for @checkedOutAtBy.
  ///
  /// In en, this message translates to:
  /// **'Checked out at {time} by {name}'**
  String checkedOutAtBy(String time, String name);

  /// No description provided for @notesToday.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 note today} other{{count} notes today}}'**
  String notesToday(int count);

  /// No description provided for @eventsToday.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 event today} other{{count} events today}}'**
  String eventsToday(int count);

  /// No description provided for @checkIn.
  ///
  /// In en, this message translates to:
  /// **'Check in'**
  String get checkIn;

  /// No description provided for @checkOut.
  ///
  /// In en, this message translates to:
  /// **'Check out'**
  String get checkOut;

  /// No description provided for @addNote.
  ///
  /// In en, this message translates to:
  /// **'Add note'**
  String get addNote;

  /// No description provided for @todaysActivity.
  ///
  /// In en, this message translates to:
  /// **'Today\'s activity'**
  String get todaysActivity;

  /// No description provided for @nothingYetToday.
  ///
  /// In en, this message translates to:
  /// **'Nothing yet today.'**
  String get nothingYetToday;

  /// No description provided for @checkedInBy.
  ///
  /// In en, this message translates to:
  /// **'Checked in by {name}'**
  String checkedInBy(String name);

  /// No description provided for @checkedOutBy.
  ///
  /// In en, this message translates to:
  /// **'Checked out by {name}'**
  String checkedOutBy(String name);

  /// No description provided for @noteBy.
  ///
  /// In en, this message translates to:
  /// **'Note by {name}'**
  String noteBy(String name);

  /// No description provided for @checkInChild.
  ///
  /// In en, this message translates to:
  /// **'Check in {name}'**
  String checkInChild(String name);

  /// No description provided for @checkOutChild.
  ///
  /// In en, this message translates to:
  /// **'Check out {name}'**
  String checkOutChild(String name);

  /// No description provided for @droppedOffBy.
  ///
  /// In en, this message translates to:
  /// **'Dropped off by'**
  String get droppedOffBy;

  /// No description provided for @pickedUpBy.
  ///
  /// In en, this message translates to:
  /// **'Picked up by'**
  String get pickedUpBy;

  /// No description provided for @addActivityNoteTitle.
  ///
  /// In en, this message translates to:
  /// **'Add an activity note'**
  String get addActivityNoteTitle;

  /// No description provided for @whatDidTheyDo.
  ///
  /// In en, this message translates to:
  /// **'What did they do today?'**
  String get whatDidTheyDo;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add a photo'**
  String get addPhoto;

  /// No description provided for @photoAdded.
  ///
  /// In en, this message translates to:
  /// **'Photo added'**
  String get photoAdded;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @nothingCheckedToday.
  ///
  /// In en, this message translates to:
  /// **'Nothing checked in or out yet today.'**
  String get nothingCheckedToday;

  /// No description provided for @unknownChild.
  ///
  /// In en, this message translates to:
  /// **'Unknown child'**
  String get unknownChild;

  /// No description provided for @activityNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Activity note'**
  String get activityNoteLabel;

  /// No description provided for @newActivityNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'New activity for {name}'**
  String newActivityNotificationTitle(String name);

  /// No description provided for @requestsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTooltip;

  /// No description provided for @requestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requestsTitle;

  /// No description provided for @requestTypeLeave.
  ///
  /// In en, this message translates to:
  /// **'Leave'**
  String get requestTypeLeave;

  /// No description provided for @requestTypeExtraHours.
  ///
  /// In en, this message translates to:
  /// **'Extra hours'**
  String get requestTypeExtraHours;

  /// No description provided for @requestStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get requestStatusPending;

  /// No description provided for @requestStatusApproved.
  ///
  /// In en, this message translates to:
  /// **'Approved'**
  String get requestStatusApproved;

  /// No description provided for @requestStatusCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get requestStatusCancelled;

  /// No description provided for @newRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'New request'**
  String get newRequestTitle;

  /// No description provided for @pickDate.
  ///
  /// In en, this message translates to:
  /// **'Pick a date'**
  String get pickDate;

  /// No description provided for @noteOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'Note (optional)'**
  String get noteOptionalHint;

  /// No description provided for @submitRequest.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submitRequest;

  /// No description provided for @approve.
  ///
  /// In en, this message translates to:
  /// **'Approve'**
  String get approve;

  /// No description provided for @cancelRequest.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancelRequest;

  /// No description provided for @noRequestsYet.
  ///
  /// In en, this message translates to:
  /// **'No requests yet.'**
  String get noRequestsYet;

  /// No description provided for @requestedBy.
  ///
  /// In en, this message translates to:
  /// **'Requested by {name}'**
  String requestedBy(String name);

  /// No description provided for @newLeaveRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Leave request for {name}'**
  String newLeaveRequestTitle(String name);

  /// No description provided for @newExtraHoursRequestTitle.
  ///
  /// In en, this message translates to:
  /// **'Extra hours request for {name}'**
  String newExtraHoursRequestTitle(String name);

  /// No description provided for @scheduleTooltip.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTooltip;

  /// No description provided for @scheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get scheduleTitle;

  /// No description provided for @scheduledHours.
  ///
  /// In en, this message translates to:
  /// **'Scheduled {start}–{end}'**
  String scheduledHours(String start, String end);

  /// No description provided for @notScheduledToday.
  ///
  /// In en, this message translates to:
  /// **'Not scheduled this day'**
  String get notScheduledToday;

  /// No description provided for @photosTooltip.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photosTooltip;

  /// No description provided for @photosTitle.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photosTitle;

  /// No description provided for @noPhotosYet.
  ///
  /// In en, this message translates to:
  /// **'No photos yet.'**
  String get noPhotosYet;

  /// No description provided for @addPdf.
  ///
  /// In en, this message translates to:
  /// **'Add a PDF'**
  String get addPdf;

  /// No description provided for @pdfAdded.
  ///
  /// In en, this message translates to:
  /// **'PDF added'**
  String get pdfAdded;

  /// No description provided for @attachmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Attachment'**
  String get attachmentLabel;

  /// No description provided for @openAttachment.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get openAttachment;

  /// No description provided for @shareAttachment.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get shareAttachment;

  /// No description provided for @couldNotOpenAttachment.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t open this file.'**
  String get couldNotOpenAttachment;

  /// No description provided for @inboxTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get inboxTitle;

  /// No description provided for @inboxTooltip.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get inboxTooltip;

  /// No description provided for @noNotificationsYet.
  ///
  /// In en, this message translates to:
  /// **'No notifications yet.'**
  String get noNotificationsYet;

  /// No description provided for @markAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get markAllRead;

  /// No description provided for @requestApprovedNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Request approved for {name}'**
  String requestApprovedNotificationTitle(String name);

  /// No description provided for @requestCancelledNotificationTitle.
  ///
  /// In en, this message translates to:
  /// **'Request cancelled for {name}'**
  String requestCancelledNotificationTitle(String name);

  /// No description provided for @sharePhoto.
  ///
  /// In en, this message translates to:
  /// **'Share photo'**
  String get sharePhoto;

  /// No description provided for @photoPosition.
  ///
  /// In en, this message translates to:
  /// **'{index} of {count}'**
  String photoPosition(int index, int count);

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @languageLabel.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageLabel;

  /// No description provided for @languageSystem.
  ///
  /// In en, this message translates to:
  /// **'Device language'**
  String get languageSystem;

  /// No description provided for @themeLabel.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get themeLabel;

  /// No description provided for @themeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get themeSystem;

  /// No description provided for @themeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get themeLight;

  /// No description provided for @themeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get themeDark;

  /// No description provided for @reduceEffectsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reduce effects'**
  String get reduceEffectsLabel;

  /// No description provided for @reduceEffectsHint.
  ///
  /// In en, this message translates to:
  /// **'Solid panels instead of blurred glass. Smoother on older phones.'**
  String get reduceEffectsHint;

  /// No description provided for @activityPopupsLabel.
  ///
  /// In en, this message translates to:
  /// **'Pop-ups for new activity'**
  String get activityPopupsLabel;

  /// No description provided for @requestPopupsLabel.
  ///
  /// In en, this message translates to:
  /// **'Pop-ups for requests'**
  String get requestPopupsLabel;

  /// No description provided for @popupsHint.
  ///
  /// In en, this message translates to:
  /// **'Everything still lands in the notification list in the app. These switches only control the pop-up on your phone.'**
  String get popupsHint;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ar',
    'de',
    'en',
    'fr',
    'he',
    'it',
    'nl',
    'pl',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
    case 'he':
      return AppLocalizationsHe();
    case 'it':
      return AppLocalizationsIt();
    case 'nl':
      return AppLocalizationsNl();
    case 'pl':
      return AppLocalizationsPl();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
