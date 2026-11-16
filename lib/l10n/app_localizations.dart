import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_nl.dart';

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
    Locale('en'),
    Locale('nl'),
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
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'nl'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'nl':
      return AppLocalizationsNl();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
