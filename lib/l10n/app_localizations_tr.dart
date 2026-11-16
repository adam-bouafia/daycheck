// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Turkish (`tr`).
class AppLocalizationsTr extends AppLocalizations {
  AppLocalizationsTr([String locale = 'tr']) : super(locale);

  @override
  String get signInPrompt => 'DayCheck\'i kim kullanıyor?';

  @override
  String get signInDemoNotice =>
      'Yalnızca demo girişi, gerçek bir oturum açma değil.';

  @override
  String get roleStaff => 'Personel';

  @override
  String get roleStaffSubtitle =>
      'Tüm çocukları gör, giriş ve çıkış yap, etkinlik ekle';

  @override
  String get roleParentPrompt => 'Veli — adını seç';

  @override
  String get roleParentSubtitle => 'Çocuğunu gör, yalnızca okuma';

  @override
  String get appBarStaff => 'DayCheck · Personel';

  @override
  String appBarParent(String name) {
    return 'DayCheck · $name';
  }

  @override
  String get todaysLogTooltip => 'Bugünün kaydı';

  @override
  String get signOutTooltip => 'Çıkış yap';

  @override
  String get noChildForGuardian => 'Bu veli için çocuk bulunamadı.';

  @override
  String get statusNotArrived => 'Gelmedi';

  @override
  String get statusPresent => 'Burada';

  @override
  String get statusDeparted => 'Ayrıldı';

  @override
  String get notArrivedYet => 'Henüz gelmedi';

  @override
  String checkedInAtBy(String time, String name) {
    return '$time saatinde $name getirdi';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return '$time saatinde $name aldı';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bugün $count not',
      one: 'Bugün 1 not',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Bugün $count olay',
      one: 'Bugün 1 olay',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'Giriş';

  @override
  String get checkOut => 'Çıkış';

  @override
  String get addNote => 'Not ekle';

  @override
  String get todaysActivity => 'Bugünün etkinlikleri';

  @override
  String get nothingYetToday => 'Bugün henüz bir şey yok.';

  @override
  String checkedInBy(String name) {
    return 'Getiren: $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'Alan: $name';
  }

  @override
  String noteBy(String name) {
    return 'Notu yazan: $name';
  }

  @override
  String checkInChild(String name) {
    return '$name giriş';
  }

  @override
  String checkOutChild(String name) {
    return '$name çıkış';
  }

  @override
  String get droppedOffBy => 'Getiren';

  @override
  String get pickedUpBy => 'Alan';

  @override
  String get addActivityNoteTitle => 'Etkinlik ekle';

  @override
  String get whatDidTheyDo => 'Bugün neler yaptı?';

  @override
  String get addPhoto => 'Fotoğraf ekle';

  @override
  String get photoAdded => 'Fotoğraf eklendi';

  @override
  String get save => 'Kaydet';

  @override
  String get nothingCheckedToday => 'Bugün henüz giriş veya çıkış yok.';

  @override
  String get unknownChild => 'Bilinmeyen çocuk';

  @override
  String get activityNoteLabel => 'Etkinlik notu';

  @override
  String newActivityNotificationTitle(String name) {
    return '$name için yeni etkinlik';
  }

  @override
  String get requestsTooltip => 'Talepler';

  @override
  String get requestsTitle => 'Talepler';

  @override
  String get requestTypeLeave => 'İzin';

  @override
  String get requestTypeExtraHours => 'Ek saat';

  @override
  String get requestStatusPending => 'Beklemede';

  @override
  String get requestStatusApproved => 'Onaylandı';

  @override
  String get requestStatusCancelled => 'İptal edildi';

  @override
  String get newRequestTitle => 'Yeni talep';

  @override
  String get pickDate => 'Tarih seç';

  @override
  String get noteOptionalHint => 'Not (isteğe bağlı)';

  @override
  String get submitRequest => 'Gönder';

  @override
  String get approve => 'Onayla';

  @override
  String get cancelRequest => 'İptal et';

  @override
  String get noRequestsYet => 'Henüz talep yok.';

  @override
  String requestedBy(String name) {
    return 'Talep eden: $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return '$name için izin talebi';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return '$name için ek saat talebi';
  }

  @override
  String get scheduleTooltip => 'Program';

  @override
  String get scheduleTitle => 'Program';

  @override
  String scheduledHours(String start, String end) {
    return 'Planlanan $start–$end';
  }

  @override
  String get notScheduledToday => 'Bu gün için plan yok';

  @override
  String get photosTooltip => 'Fotoğraflar';

  @override
  String get photosTitle => 'Fotoğraflar';

  @override
  String get noPhotosYet => 'Henüz fotoğraf yok.';

  @override
  String get addPdf => 'PDF ekle';

  @override
  String get pdfAdded => 'PDF eklendi';

  @override
  String get attachmentLabel => 'Ek';

  @override
  String get openAttachment => 'Aç';

  @override
  String get shareAttachment => 'Paylaş';

  @override
  String get couldNotOpenAttachment => 'Bu dosya açılamadı.';

  @override
  String get inboxTitle => 'Bildirimler';

  @override
  String get inboxTooltip => 'Bildirimler';

  @override
  String get noNotificationsYet => 'Henüz bildirim yok.';

  @override
  String get markAllRead => 'Tümünü okundu işaretle';

  @override
  String requestApprovedNotificationTitle(String name) {
    return '$name için talep onaylandı';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return '$name için talep iptal edildi';
  }

  @override
  String get sharePhoto => 'Fotoğrafı paylaş';

  @override
  String photoPosition(int index, int count) {
    return '$index / $count';
  }

  @override
  String get settingsTitle => 'Ayarlar';

  @override
  String get languageLabel => 'Dil';

  @override
  String get languageSystem => 'Cihaz dili';

  @override
  String get themeLabel => 'Görünüm';

  @override
  String get themeSystem => 'Sistem';

  @override
  String get themeLight => 'Açık';

  @override
  String get themeDark => 'Koyu';

  @override
  String get reduceEffectsLabel => 'Efektleri azalt';

  @override
  String get reduceEffectsHint =>
      'Bulanık cam yerine düz paneller. Eski telefonlarda daha akıcı.';

  @override
  String get activityPopupsLabel => 'Yeni etkinlikler için açılır bildirim';

  @override
  String get requestPopupsLabel => 'Talepler için açılır bildirim';

  @override
  String get popupsHint =>
      'Her şey yine uygulamadaki bildirim listesine düşer. Bu anahtarlar yalnızca telefondaki açılır bildirimi kontrol eder.';
}
