// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get roleStaff => 'Medewerker';

  @override
  String get todaysLogTooltip => 'Logboek van vandaag';

  @override
  String get signOutTooltip => 'Uitloggen';

  @override
  String get noChildForGuardian => 'Geen kind gevonden voor deze ouder.';

  @override
  String get statusNotArrived => 'Niet aangekomen';

  @override
  String get statusPresent => 'Aanwezig';

  @override
  String get statusDeparted => 'Vertrokken';

  @override
  String get notArrivedYet => 'Nog niet aangekomen';

  @override
  String checkedInAtBy(String time, String name) {
    return 'Ingecheckt om $time door $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'Uitgecheckt om $time door $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notities vandaag',
      one: '1 notitie vandaag',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count gebeurtenissen vandaag',
      one: '1 gebeurtenis vandaag',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'Inchecken';

  @override
  String get checkOut => 'Uitchecken';

  @override
  String get addNote => 'Notitie toevoegen';

  @override
  String get todaysActivity => 'Activiteiten van vandaag';

  @override
  String get nothingYetToday => 'Nog niets vandaag.';

  @override
  String checkedInBy(String name) {
    return 'Ingecheckt door $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'Uitgecheckt door $name';
  }

  @override
  String noteBy(String name) {
    return 'Notitie door $name';
  }

  @override
  String checkInChild(String name) {
    return '$name inchecken';
  }

  @override
  String checkOutChild(String name) {
    return '$name uitchecken';
  }

  @override
  String get droppedOffBy => 'Afgezet door';

  @override
  String get pickedUpBy => 'Opgehaald door';

  @override
  String get addActivityNoteTitle => 'Activiteit toevoegen';

  @override
  String get whatDidTheyDo => 'Wat hebben ze vandaag gedaan?';

  @override
  String get addPhoto => 'Foto toevoegen';

  @override
  String get photoAdded => 'Foto toegevoegd';

  @override
  String get save => 'Opslaan';

  @override
  String get nothingCheckedToday => 'Nog niemand in- of uitgecheckt vandaag.';

  @override
  String get unknownChild => 'Onbekend kind';

  @override
  String get activityNoteLabel => 'Activiteitnotitie';

  @override
  String newActivityNotificationTitle(String name) {
    return 'Nieuwe activiteit voor $name';
  }

  @override
  String get requestsTitle => 'Aanvragen';

  @override
  String get requestTypeLeave => 'Verlof';

  @override
  String get requestTypeExtraHours => 'Extra uren';

  @override
  String get requestStatusPending => 'In behandeling';

  @override
  String get requestStatusApproved => 'Goedgekeurd';

  @override
  String get requestStatusCancelled => 'Geannuleerd';

  @override
  String get newRequestTitle => 'Nieuwe aanvraag';

  @override
  String get pickDate => 'Kies een datum';

  @override
  String get noteOptionalHint => 'Notitie (optioneel)';

  @override
  String get submitRequest => 'Indienen';

  @override
  String get approve => 'Goedkeuren';

  @override
  String get cancelRequest => 'Annuleren';

  @override
  String get noRequestsYet => 'Nog geen aanvragen.';

  @override
  String requestedBy(String name) {
    return 'Aangevraagd door $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'Verlofaanvraag voor $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'Aanvraag extra uren voor $name';
  }

  @override
  String get scheduleTooltip => 'Planning';

  @override
  String get scheduleTitle => 'Planning';

  @override
  String scheduledHours(String start, String end) {
    return 'Gepland $start–$end';
  }

  @override
  String get notScheduledToday => 'Niet gepland op deze dag';

  @override
  String get photosTooltip => 'Foto\'s';

  @override
  String get photosTitle => 'Foto\'s';

  @override
  String get noPhotosYet => 'Nog geen foto\'s.';

  @override
  String get addPdf => 'PDF toevoegen';

  @override
  String get pdfAdded => 'PDF toegevoegd';

  @override
  String get attachmentLabel => 'Bijlage';

  @override
  String get openAttachment => 'Openen';

  @override
  String get shareAttachment => 'Delen';

  @override
  String get couldNotOpenAttachment => 'Dit bestand kon niet worden geopend.';

  @override
  String get inboxTitle => 'Meldingen';

  @override
  String get noNotificationsYet => 'Nog geen meldingen.';

  @override
  String get markAllRead => 'Alles als gelezen markeren';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'Aanvraag goedgekeurd voor $name';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'Aanvraag geannuleerd voor $name';
  }

  @override
  String get sharePhoto => 'Foto delen';

  @override
  String photoPosition(int index, int count) {
    return '$index van $count';
  }

  @override
  String get settingsTitle => 'Instellingen';

  @override
  String get languageLabel => 'Taal';

  @override
  String get languageSystem => 'Taal van het toestel';

  @override
  String get themeLabel => 'Weergave';

  @override
  String get themeSystem => 'Systeem';

  @override
  String get themeLight => 'Licht';

  @override
  String get themeDark => 'Donker';

  @override
  String get reduceEffectsLabel => 'Minder effecten';

  @override
  String get reduceEffectsHint =>
      'Effen panelen in plaats van wazig glas. Soepeler op oudere telefoons.';

  @override
  String get activityPopupsLabel => 'Pop-ups voor nieuwe activiteit';

  @override
  String get requestPopupsLabel => 'Pop-ups voor aanvragen';

  @override
  String get popupsHint =>
      'Alles komt nog steeds in de meldingenlijst in de app. Deze schakelaars bepalen alleen de pop-up op je telefoon.';

  @override
  String get loginSubtitle => 'Log in met je account van de opvang.';

  @override
  String get usernameLabel => 'Gebruikersnaam';

  @override
  String get passwordLabel => 'Wachtwoord';

  @override
  String get signInButton => 'Inloggen';

  @override
  String get loginFailed => 'Onjuiste gebruikersnaam of wachtwoord.';

  @override
  String get demoAccountsTitle => 'Testaccounts';

  @override
  String get demoAccountsHint =>
      'Tik op een account om de gegevens in te vullen. Alleen om te testen.';

  @override
  String get roleParent => 'Ouder';

  @override
  String get tabChildren => 'Kinderen';

  @override
  String get tabLog => 'Logboek';

  @override
  String get tabToday => 'Vandaag';

  @override
  String helloName(String name) {
    return 'Hallo, $name';
  }

  @override
  String signedInAs(String name) {
    return 'Ingelogd als $name';
  }
}
