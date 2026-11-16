// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Dutch Flemish (`nl`).
class AppLocalizationsNl extends AppLocalizations {
  AppLocalizationsNl([String locale = 'nl']) : super(locale);

  @override
  String get signInPrompt => 'Wie gebruikt DayCheck?';

  @override
  String get signInDemoNotice => 'Alleen een demo-inlog, geen echte login.';

  @override
  String get roleStaff => 'Medewerker';

  @override
  String get roleStaffSubtitle =>
      'Zie ieder kind, check in/uit, voeg activiteiten toe';

  @override
  String get roleParentPrompt => 'Ouder — kies je naam';

  @override
  String get roleParentSubtitle => 'Zie je kind, alleen lezen';

  @override
  String get appBarStaff => 'DayCheck · Medewerker';

  @override
  String appBarParent(String name) {
    return 'DayCheck · $name';
  }

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
  String get requestsTooltip => 'Aanvragen';

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
  String get inboxTooltip => 'Meldingen';

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
}
