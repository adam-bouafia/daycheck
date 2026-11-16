// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get roleStaff => 'Personal';

  @override
  String get todaysLogTooltip => 'Heutiges Protokoll';

  @override
  String get signOutTooltip => 'Abmelden';

  @override
  String get noChildForGuardian => 'Kein Kind für diesen Elternteil gefunden.';

  @override
  String get statusNotArrived => 'Nicht angekommen';

  @override
  String get statusPresent => 'Anwesend';

  @override
  String get statusDeparted => 'Abgeholt';

  @override
  String get notArrivedYet => 'Noch nicht angekommen';

  @override
  String checkedInAtBy(String time, String name) {
    return 'Um $time gebracht von $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'Um $time abgeholt von $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Notizen heute',
      one: '1 Notiz heute',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count Ereignisse heute',
      one: '1 Ereignis heute',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'Anmelden';

  @override
  String get checkOut => 'Abmelden';

  @override
  String get addNote => 'Notiz hinzufügen';

  @override
  String get todaysActivity => 'Heutige Aktivitäten';

  @override
  String get nothingYetToday => 'Heute noch nichts.';

  @override
  String checkedInBy(String name) {
    return 'Gebracht von $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'Abgeholt von $name';
  }

  @override
  String noteBy(String name) {
    return 'Notiz von $name';
  }

  @override
  String checkInChild(String name) {
    return '$name anmelden';
  }

  @override
  String checkOutChild(String name) {
    return '$name abmelden';
  }

  @override
  String get droppedOffBy => 'Gebracht von';

  @override
  String get pickedUpBy => 'Abgeholt von';

  @override
  String get addActivityNoteTitle => 'Aktivität hinzufügen';

  @override
  String get whatDidTheyDo => 'Was hat das Kind heute gemacht?';

  @override
  String get addPhoto => 'Foto hinzufügen';

  @override
  String get photoAdded => 'Foto hinzugefügt';

  @override
  String get save => 'Speichern';

  @override
  String get nothingCheckedToday => 'Heute noch niemand an- oder abgemeldet.';

  @override
  String get unknownChild => 'Unbekanntes Kind';

  @override
  String get activityNoteLabel => 'Aktivitätsnotiz';

  @override
  String newActivityNotificationTitle(String name) {
    return 'Neue Aktivität für $name';
  }

  @override
  String get requestsTitle => 'Anträge';

  @override
  String get requestTypeLeave => 'Abwesenheit';

  @override
  String get requestTypeExtraHours => 'Zusätzliche Stunden';

  @override
  String get requestStatusPending => 'Offen';

  @override
  String get requestStatusApproved => 'Genehmigt';

  @override
  String get requestStatusCancelled => 'Storniert';

  @override
  String get newRequestTitle => 'Neuer Antrag';

  @override
  String get pickDate => 'Datum wählen';

  @override
  String get noteOptionalHint => 'Notiz (optional)';

  @override
  String get submitRequest => 'Absenden';

  @override
  String get approve => 'Genehmigen';

  @override
  String get cancelRequest => 'Stornieren';

  @override
  String get noRequestsYet => 'Noch keine Anträge.';

  @override
  String requestedBy(String name) {
    return 'Beantragt von $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'Abwesenheitsantrag für $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'Antrag auf zusätzliche Stunden für $name';
  }

  @override
  String get scheduleTooltip => 'Plan';

  @override
  String get scheduleTitle => 'Plan';

  @override
  String scheduledHours(String start, String end) {
    return 'Geplant $start–$end';
  }

  @override
  String get notScheduledToday => 'An diesem Tag nicht geplant';

  @override
  String get photosTooltip => 'Fotos';

  @override
  String get photosTitle => 'Fotos';

  @override
  String get noPhotosYet => 'Noch keine Fotos.';

  @override
  String get addPdf => 'PDF hinzufügen';

  @override
  String get pdfAdded => 'PDF hinzugefügt';

  @override
  String get attachmentLabel => 'Anhang';

  @override
  String get openAttachment => 'Öffnen';

  @override
  String get shareAttachment => 'Teilen';

  @override
  String get couldNotOpenAttachment =>
      'Diese Datei konnte nicht geöffnet werden.';

  @override
  String get inboxTitle => 'Benachrichtigungen';

  @override
  String get noNotificationsYet => 'Noch keine Benachrichtigungen.';

  @override
  String get markAllRead => 'Alle als gelesen markieren';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'Antrag für $name genehmigt';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'Antrag für $name storniert';
  }

  @override
  String get sharePhoto => 'Foto teilen';

  @override
  String photoPosition(int index, int count) {
    return '$index von $count';
  }

  @override
  String get settingsTitle => 'Einstellungen';

  @override
  String get languageLabel => 'Sprache';

  @override
  String get languageSystem => 'Gerätesprache';

  @override
  String get themeLabel => 'Darstellung';

  @override
  String get themeSystem => 'System';

  @override
  String get themeLight => 'Hell';

  @override
  String get themeDark => 'Dunkel';

  @override
  String get reduceEffectsLabel => 'Effekte reduzieren';

  @override
  String get reduceEffectsHint =>
      'Deckende Flächen statt Milchglas. Flüssiger auf älteren Handys.';

  @override
  String get activityPopupsLabel => 'Pop-ups für neue Aktivitäten';

  @override
  String get requestPopupsLabel => 'Pop-ups für Anträge';

  @override
  String get popupsHint =>
      'Alles landet trotzdem in der Benachrichtigungsliste der App. Diese Schalter steuern nur das Pop-up auf deinem Handy.';

  @override
  String get loginSubtitle => 'Melde dich mit deinem Kita-Konto an.';

  @override
  String get usernameLabel => 'Benutzername';

  @override
  String get passwordLabel => 'Passwort';

  @override
  String get signInButton => 'Anmelden';

  @override
  String get loginFailed => 'Falscher Benutzername oder falsches Passwort.';

  @override
  String get demoAccountsTitle => 'Testkonten';

  @override
  String get demoAccountsHint =>
      'Tippe auf ein Konto, um seine Daten einzutragen. Nur zum Testen.';

  @override
  String get roleParent => 'Elternteil';

  @override
  String get tabChildren => 'Kinder';

  @override
  String get tabLog => 'Protokoll';

  @override
  String get tabToday => 'Heute';

  @override
  String helloName(String name) {
    return 'Hallo, $name';
  }

  @override
  String signedInAs(String name) {
    return 'Angemeldet als $name';
  }
}
