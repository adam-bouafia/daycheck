// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Polish (`pl`).
class AppLocalizationsPl extends AppLocalizations {
  AppLocalizationsPl([String locale = 'pl']) : super(locale);

  @override
  String get signInPrompt => 'Kto korzysta z DayCheck?';

  @override
  String get signInDemoNotice =>
      'To tylko logowanie demonstracyjne, nie prawdziwe.';

  @override
  String get roleStaff => 'Personel';

  @override
  String get roleStaffSubtitle =>
      'Widzisz każde dziecko, rejestrujesz przyjście i wyjście, dodajesz aktywności';

  @override
  String get roleParentPrompt => 'Rodzic — wybierz swoje imię';

  @override
  String get roleParentSubtitle => 'Widzisz swoje dziecko, tylko do odczytu';

  @override
  String get appBarStaff => 'DayCheck · Personel';

  @override
  String appBarParent(String name) {
    return 'DayCheck · $name';
  }

  @override
  String get todaysLogTooltip => 'Dzisiejszy dziennik';

  @override
  String get signOutTooltip => 'Wyloguj';

  @override
  String get noChildForGuardian => 'Nie znaleziono dziecka dla tego rodzica.';

  @override
  String get statusNotArrived => 'Nieobecne';

  @override
  String get statusPresent => 'Obecne';

  @override
  String get statusDeparted => 'Odebrane';

  @override
  String get notArrivedYet => 'Jeszcze nie przyszło';

  @override
  String checkedInAtBy(String time, String name) {
    return 'Przyprowadzone o $time przez: $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'Odebrane o $time przez: $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notatki dzisiaj',
      many: '$count notatek dzisiaj',
      few: '$count notatki dzisiaj',
      one: '1 notatka dzisiaj',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count zdarzenia dzisiaj',
      many: '$count zdarzeń dzisiaj',
      few: '$count zdarzenia dzisiaj',
      one: '1 zdarzenie dzisiaj',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'Przyjście';

  @override
  String get checkOut => 'Wyjście';

  @override
  String get addNote => 'Dodaj notatkę';

  @override
  String get todaysActivity => 'Dzisiejsze aktywności';

  @override
  String get nothingYetToday => 'Dzisiaj jeszcze nic.';

  @override
  String checkedInBy(String name) {
    return 'Przyprowadzone przez: $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'Odebrane przez: $name';
  }

  @override
  String noteBy(String name) {
    return 'Notatka: $name';
  }

  @override
  String checkInChild(String name) {
    return 'Przyjście: $name';
  }

  @override
  String checkOutChild(String name) {
    return 'Wyjście: $name';
  }

  @override
  String get droppedOffBy => 'Przyprowadzone przez';

  @override
  String get pickedUpBy => 'Odebrane przez';

  @override
  String get addActivityNoteTitle => 'Dodaj aktywność';

  @override
  String get whatDidTheyDo => 'Co dziecko dzisiaj robiło?';

  @override
  String get addPhoto => 'Dodaj zdjęcie';

  @override
  String get photoAdded => 'Dodano zdjęcie';

  @override
  String get save => 'Zapisz';

  @override
  String get nothingCheckedToday =>
      'Dzisiaj nikt jeszcze nie przyszedł ani nie wyszedł.';

  @override
  String get unknownChild => 'Nieznane dziecko';

  @override
  String get activityNoteLabel => 'Notatka z aktywności';

  @override
  String newActivityNotificationTitle(String name) {
    return 'Nowa aktywność: $name';
  }

  @override
  String get requestsTooltip => 'Wnioski';

  @override
  String get requestsTitle => 'Wnioski';

  @override
  String get requestTypeLeave => 'Nieobecność';

  @override
  String get requestTypeExtraHours => 'Dodatkowe godziny';

  @override
  String get requestStatusPending => 'Oczekuje';

  @override
  String get requestStatusApproved => 'Zatwierdzony';

  @override
  String get requestStatusCancelled => 'Anulowany';

  @override
  String get newRequestTitle => 'Nowy wniosek';

  @override
  String get pickDate => 'Wybierz datę';

  @override
  String get noteOptionalHint => 'Notatka (opcjonalnie)';

  @override
  String get submitRequest => 'Wyślij';

  @override
  String get approve => 'Zatwierdź';

  @override
  String get cancelRequest => 'Anuluj';

  @override
  String get noRequestsYet => 'Brak wniosków.';

  @override
  String requestedBy(String name) {
    return 'Wnioskuje: $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'Wniosek o nieobecność: $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'Wniosek o dodatkowe godziny: $name';
  }

  @override
  String get scheduleTooltip => 'Plan';

  @override
  String get scheduleTitle => 'Plan';

  @override
  String scheduledHours(String start, String end) {
    return 'Zaplanowane $start–$end';
  }

  @override
  String get notScheduledToday => 'Brak planu na ten dzień';

  @override
  String get photosTooltip => 'Zdjęcia';

  @override
  String get photosTitle => 'Zdjęcia';

  @override
  String get noPhotosYet => 'Brak zdjęć.';

  @override
  String get addPdf => 'Dodaj PDF';

  @override
  String get pdfAdded => 'Dodano PDF';

  @override
  String get attachmentLabel => 'Załącznik';

  @override
  String get openAttachment => 'Otwórz';

  @override
  String get shareAttachment => 'Udostępnij';

  @override
  String get couldNotOpenAttachment => 'Nie można otworzyć tego pliku.';

  @override
  String get inboxTitle => 'Powiadomienia';

  @override
  String get inboxTooltip => 'Powiadomienia';

  @override
  String get noNotificationsYet => 'Brak powiadomień.';

  @override
  String get markAllRead => 'Oznacz wszystkie jako przeczytane';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'Wniosek zatwierdzony: $name';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'Wniosek anulowany: $name';
  }

  @override
  String get sharePhoto => 'Udostępnij zdjęcie';

  @override
  String photoPosition(int index, int count) {
    return '$index z $count';
  }

  @override
  String get settingsTitle => 'Ustawienia';

  @override
  String get languageLabel => 'Język';

  @override
  String get languageSystem => 'Język urządzenia';

  @override
  String get themeLabel => 'Wygląd';

  @override
  String get themeSystem => 'Systemowy';

  @override
  String get themeLight => 'Jasny';

  @override
  String get themeDark => 'Ciemny';

  @override
  String get reduceEffectsLabel => 'Ogranicz efekty';

  @override
  String get reduceEffectsHint =>
      'Pełne panele zamiast rozmytego szkła. Płynniej na starszych telefonach.';

  @override
  String get activityPopupsLabel => 'Wyskakujące powiadomienia o aktywnościach';

  @override
  String get requestPopupsLabel => 'Wyskakujące powiadomienia o wnioskach';

  @override
  String get popupsHint =>
      'Wszystko i tak trafia na listę powiadomień w aplikacji. Te przełączniki dotyczą tylko wyskakującego powiadomienia w telefonie.';
}
