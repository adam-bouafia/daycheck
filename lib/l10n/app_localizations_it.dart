// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get roleStaff => 'Personale';

  @override
  String get todaysLogTooltip => 'Registro di oggi';

  @override
  String get signOutTooltip => 'Esci';

  @override
  String get noChildForGuardian =>
      'Nessun bambino trovato per questo genitore.';

  @override
  String get statusNotArrived => 'Non arrivato';

  @override
  String get statusPresent => 'Presente';

  @override
  String get statusDeparted => 'Uscito';

  @override
  String get notArrivedYet => 'Non ancora arrivato';

  @override
  String checkedInAtBy(String time, String name) {
    return 'Entrata alle $time, accompagnato da $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'Uscita alle $time, ritirato da $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count note oggi',
      one: '1 nota oggi',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count eventi oggi',
      one: '1 evento oggi',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'Entrata';

  @override
  String get checkOut => 'Uscita';

  @override
  String get addNote => 'Aggiungi nota';

  @override
  String get todaysActivity => 'Attività di oggi';

  @override
  String get nothingYetToday => 'Ancora niente oggi.';

  @override
  String checkedInBy(String name) {
    return 'Accompagnato da $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'Ritirato da $name';
  }

  @override
  String noteBy(String name) {
    return 'Nota di $name';
  }

  @override
  String checkInChild(String name) {
    return 'Entrata di $name';
  }

  @override
  String checkOutChild(String name) {
    return 'Uscita di $name';
  }

  @override
  String get droppedOffBy => 'Accompagnato da';

  @override
  String get pickedUpBy => 'Ritirato da';

  @override
  String get addActivityNoteTitle => 'Aggiungi un\'attività';

  @override
  String get whatDidTheyDo => 'Che cosa ha fatto oggi?';

  @override
  String get addPhoto => 'Aggiungi una foto';

  @override
  String get photoAdded => 'Foto aggiunta';

  @override
  String get save => 'Salva';

  @override
  String get nothingCheckedToday => 'Nessuna entrata o uscita registrata oggi.';

  @override
  String get unknownChild => 'Bambino sconosciuto';

  @override
  String get activityNoteLabel => 'Nota attività';

  @override
  String newActivityNotificationTitle(String name) {
    return 'Nuova attività per $name';
  }

  @override
  String get requestsTitle => 'Richieste';

  @override
  String get requestTypeLeave => 'Assenza';

  @override
  String get requestTypeExtraHours => 'Ore extra';

  @override
  String get requestStatusPending => 'In attesa';

  @override
  String get requestStatusApproved => 'Approvata';

  @override
  String get requestStatusCancelled => 'Annullata';

  @override
  String get newRequestTitle => 'Nuova richiesta';

  @override
  String get pickDate => 'Scegli una data';

  @override
  String get noteOptionalHint => 'Nota (facoltativa)';

  @override
  String get submitRequest => 'Invia';

  @override
  String get approve => 'Approva';

  @override
  String get cancelRequest => 'Annulla';

  @override
  String get noRequestsYet => 'Ancora nessuna richiesta.';

  @override
  String requestedBy(String name) {
    return 'Richiesta da $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'Richiesta di assenza per $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'Richiesta di ore extra per $name';
  }

  @override
  String get scheduleTooltip => 'Orario';

  @override
  String get scheduleTitle => 'Orario';

  @override
  String scheduledHours(String start, String end) {
    return 'Previsto $start–$end';
  }

  @override
  String get notScheduledToday => 'Non previsto in questo giorno';

  @override
  String get photosTooltip => 'Foto';

  @override
  String get photosTitle => 'Foto';

  @override
  String get noPhotosYet => 'Ancora nessuna foto.';

  @override
  String get addPdf => 'Aggiungi un PDF';

  @override
  String get pdfAdded => 'PDF aggiunto';

  @override
  String get attachmentLabel => 'Allegato';

  @override
  String get openAttachment => 'Apri';

  @override
  String get shareAttachment => 'Condividi';

  @override
  String get couldNotOpenAttachment => 'Impossibile aprire questo file.';

  @override
  String get inboxTitle => 'Notifiche';

  @override
  String get noNotificationsYet => 'Ancora nessuna notifica.';

  @override
  String get markAllRead => 'Segna tutto come letto';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'Richiesta approvata per $name';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'Richiesta annullata per $name';
  }

  @override
  String get sharePhoto => 'Condividi foto';

  @override
  String photoPosition(int index, int count) {
    return '$index di $count';
  }

  @override
  String get settingsTitle => 'Impostazioni';

  @override
  String get languageLabel => 'Lingua';

  @override
  String get languageSystem => 'Lingua del dispositivo';

  @override
  String get themeLabel => 'Aspetto';

  @override
  String get themeSystem => 'Sistema';

  @override
  String get themeLight => 'Chiaro';

  @override
  String get themeDark => 'Scuro';

  @override
  String get reduceEffectsLabel => 'Riduci effetti';

  @override
  String get reduceEffectsHint =>
      'Pannelli pieni invece del vetro sfocato. Più fluido sui telefoni meno recenti.';

  @override
  String get activityPopupsLabel => 'Pop-up per nuove attività';

  @override
  String get requestPopupsLabel => 'Pop-up per le richieste';

  @override
  String get popupsHint =>
      'Tutto arriva comunque nell\'elenco delle notifiche nell\'app. Questi interruttori controllano solo il pop-up sul telefono.';

  @override
  String get loginSubtitle => 'Accedi con il tuo account dell\'asilo.';

  @override
  String get usernameLabel => 'Nome utente';

  @override
  String get passwordLabel => 'Password';

  @override
  String get signInButton => 'Accedi';

  @override
  String get loginFailed => 'Nome utente o password errati.';

  @override
  String get demoAccountsTitle => 'Account di prova';

  @override
  String get demoAccountsHint =>
      'Tocca un account per compilare i suoi dati. Solo per i test.';

  @override
  String get roleParent => 'Genitore';

  @override
  String get tabChildren => 'Bambini';

  @override
  String get tabLog => 'Registro';

  @override
  String get tabToday => 'Oggi';

  @override
  String helloName(String name) {
    return 'Ciao, $name';
  }

  @override
  String signedInAs(String name) {
    return 'Accesso come $name';
  }

  @override
  String get statusAbsent => 'Assente';

  @override
  String get markAbsent => 'Segna assente';

  @override
  String markAbsentTitle(String name) {
    return 'Segna $name assente oggi';
  }

  @override
  String get absentReasonHint => 'Motivo, per esempio malato (facoltativo)';

  @override
  String get absentInformsGuardians =>
      'Ogni genitore di questo bambino riceve una notifica.';

  @override
  String markedAbsentBy(String name) {
    return 'Segnato assente da $name';
  }

  @override
  String absentNotificationTitle(String name) {
    return '$name è assente oggi';
  }

  @override
  String checkedInNotificationTitle(String name) {
    return '$name è arrivato';
  }

  @override
  String checkedOutNotificationTitle(String name) {
    return '$name è stato ritirato';
  }

  @override
  String expectedAt(String time) {
    return 'Atteso alle $time, non ancora arrivato';
  }

  @override
  String get attendancePopupsLabel => 'Pop-up per arrivo, ritiro e assenza';

  @override
  String get takePhoto => 'Scatta foto';

  @override
  String get choosePhoto => 'Scegli foto';

  @override
  String get documentsTitle => 'Documenti';

  @override
  String get downloadPdf => 'Scarica';

  @override
  String get savedToDevice => 'Salvato';

  @override
  String pagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pagine',
      one: '1 pagina',
    );
    return '$_temp0';
  }

  @override
  String get tabInbox => 'Avvisi';

  @override
  String get undo => 'Annulla';

  @override
  String correctionNotificationTitle(String name) {
    return 'Correzione per $name';
  }

  @override
  String eventUndone(String what) {
    return 'Annullato: $what';
  }

  @override
  String get resetDemo => 'Azzera dati demo';

  @override
  String get resetDemoHint =>
      'Cancella entrate, note, richieste e notifiche per ripartire da una giornata pulita. Bambini e account restano.';

  @override
  String get resetDemoDone => 'Dati demo azzerati';

  @override
  String get notArrivedHint => 'Cancella entrata, uscita e assenza di oggi';
}
