// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hebrew (`he`).
class AppLocalizationsHe extends AppLocalizations {
  AppLocalizationsHe([String locale = 'he']) : super(locale);

  @override
  String get roleStaff => 'צוות';

  @override
  String get todaysLogTooltip => 'יומן היום';

  @override
  String get signOutTooltip => 'התנתקות';

  @override
  String get noChildForGuardian => 'לא נמצא ילד עבור הורה זה.';

  @override
  String get statusNotArrived => 'לא הגיע';

  @override
  String get statusPresent => 'נוכח';

  @override
  String get statusDeparted => 'נאסף';

  @override
  String get notArrivedYet => 'עדיין לא הגיע';

  @override
  String checkedInAtBy(String time, String name) {
    return 'הגיע ב-$time, הובא על ידי $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'יצא ב-$time, נאסף על ידי $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count הערות היום',
      two: 'שתי הערות היום',
      one: 'הערה אחת היום',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count אירועים היום',
      two: 'שני אירועים היום',
      one: 'אירוע אחד היום',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'הגעה';

  @override
  String get checkOut => 'יציאה';

  @override
  String get addNote => 'הוספת הערה';

  @override
  String get todaysActivity => 'הפעילות של היום';

  @override
  String get nothingYetToday => 'עדיין אין כלום היום.';

  @override
  String checkedInBy(String name) {
    return 'הובא על ידי $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'נאסף על ידי $name';
  }

  @override
  String noteBy(String name) {
    return 'הערה מאת $name';
  }

  @override
  String checkInChild(String name) {
    return 'רישום הגעה של $name';
  }

  @override
  String checkOutChild(String name) {
    return 'רישום יציאה של $name';
  }

  @override
  String get droppedOffBy => 'הובא על ידי';

  @override
  String get pickedUpBy => 'נאסף על ידי';

  @override
  String get addActivityNoteTitle => 'הוספת פעילות';

  @override
  String get whatDidTheyDo => 'מה עשו היום?';

  @override
  String get addPhoto => 'הוספת תמונה';

  @override
  String get photoAdded => 'התמונה נוספה';

  @override
  String get save => 'שמירה';

  @override
  String get nothingCheckedToday => 'עדיין לא נרשמו הגעות או יציאות היום.';

  @override
  String get unknownChild => 'ילד לא ידוע';

  @override
  String get activityNoteLabel => 'הערת פעילות';

  @override
  String newActivityNotificationTitle(String name) {
    return 'פעילות חדשה עבור $name';
  }

  @override
  String get requestsTitle => 'בקשות';

  @override
  String get requestTypeLeave => 'היעדרות';

  @override
  String get requestTypeExtraHours => 'שעות נוספות';

  @override
  String get requestStatusPending => 'ממתינה';

  @override
  String get requestStatusApproved => 'אושרה';

  @override
  String get requestStatusCancelled => 'בוטלה';

  @override
  String get newRequestTitle => 'בקשה חדשה';

  @override
  String get pickDate => 'בחירת תאריך';

  @override
  String get noteOptionalHint => 'הערה (לא חובה)';

  @override
  String get submitRequest => 'שליחה';

  @override
  String get approve => 'אישור';

  @override
  String get cancelRequest => 'ביטול';

  @override
  String get noRequestsYet => 'עדיין אין בקשות.';

  @override
  String requestedBy(String name) {
    return 'התבקש על ידי $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'בקשת היעדרות עבור $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'בקשת שעות נוספות עבור $name';
  }

  @override
  String get scheduleTooltip => 'לוח זמנים';

  @override
  String get scheduleTitle => 'לוח זמנים';

  @override
  String scheduledHours(String start, String end) {
    return 'מתוכנן $start–$end';
  }

  @override
  String get notScheduledToday => 'לא מתוכנן ביום זה';

  @override
  String get photosTooltip => 'תמונות';

  @override
  String get photosTitle => 'תמונות';

  @override
  String get noPhotosYet => 'עדיין אין תמונות.';

  @override
  String get addPdf => 'הוספת PDF';

  @override
  String get pdfAdded => 'ה-PDF נוסף';

  @override
  String get attachmentLabel => 'קובץ מצורף';

  @override
  String get openAttachment => 'פתיחה';

  @override
  String get shareAttachment => 'שיתוף';

  @override
  String get couldNotOpenAttachment => 'לא ניתן לפתוח את הקובץ.';

  @override
  String get inboxTitle => 'התראות';

  @override
  String get noNotificationsYet => 'עדיין אין התראות.';

  @override
  String get markAllRead => 'סימון הכול כנקרא';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'הבקשה אושרה עבור $name';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'הבקשה בוטלה עבור $name';
  }

  @override
  String get sharePhoto => 'שיתוף התמונה';

  @override
  String photoPosition(int index, int count) {
    return '$index מתוך $count';
  }

  @override
  String get settingsTitle => 'הגדרות';

  @override
  String get languageLabel => 'שפה';

  @override
  String get languageSystem => 'שפת המכשיר';

  @override
  String get themeLabel => 'מראה';

  @override
  String get themeSystem => 'מערכת';

  @override
  String get themeLight => 'בהיר';

  @override
  String get themeDark => 'כהה';

  @override
  String get reduceEffectsLabel => 'הפחתת אפקטים';

  @override
  String get reduceEffectsHint =>
      'לוחות אטומים במקום זכוכית מטושטשת. חלק יותר בטלפונים ישנים.';

  @override
  String get activityPopupsLabel => 'חלונות קופצים לפעילות חדשה';

  @override
  String get requestPopupsLabel => 'חלונות קופצים לבקשות';

  @override
  String get popupsHint =>
      'הכול עדיין מגיע לרשימת ההתראות באפליקציה. המתגים האלה קובעים רק את החלון הקופץ בטלפון.';

  @override
  String get loginSubtitle => 'התחברו עם החשבון של המעון.';

  @override
  String get usernameLabel => 'שם משתמש';

  @override
  String get passwordLabel => 'סיסמה';

  @override
  String get signInButton => 'התחברות';

  @override
  String get loginFailed => 'שם המשתמש או הסיסמה שגויים.';

  @override
  String get demoAccountsTitle => 'חשבונות בדיקה';

  @override
  String get demoAccountsHint =>
      'הקישו על חשבון כדי למלא את פרטיו. לבדיקה בלבד.';

  @override
  String get roleParent => 'הורה';

  @override
  String get tabChildren => 'ילדים';

  @override
  String get tabLog => 'יומן';

  @override
  String get tabToday => 'היום';

  @override
  String helloName(String name) {
    return 'שלום, $name';
  }

  @override
  String signedInAs(String name) {
    return 'מחובר/ת בתור $name';
  }

  @override
  String get statusAbsent => 'נעדר';

  @override
  String get markAbsent => 'סימון היעדרות';

  @override
  String markAbsentTitle(String name) {
    return 'סימון $name כנעדר היום';
  }

  @override
  String get absentReasonHint => 'סיבה, למשל מחלה (לא חובה)';

  @override
  String get absentInformsGuardians => 'כל הורה של הילד יקבל התראה.';

  @override
  String markedAbsentBy(String name) {
    return 'סומן כנעדר על ידי $name';
  }

  @override
  String absentNotificationTitle(String name) {
    return '$name נעדר היום';
  }

  @override
  String checkedInNotificationTitle(String name) {
    return '$name הגיע';
  }

  @override
  String checkedOutNotificationTitle(String name) {
    return '$name נאסף';
  }

  @override
  String expectedAt(String time) {
    return 'צפוי ב-$time, עדיין לא הגיע';
  }

  @override
  String get attendancePopupsLabel => 'חלונות קופצים להגעה, איסוף והיעדרות';

  @override
  String get takePhoto => 'צילום תמונה';

  @override
  String get choosePhoto => 'בחירת תמונה';

  @override
  String get documentsTitle => 'מסמכים';

  @override
  String get downloadPdf => 'הורדה';

  @override
  String get savedToDevice => 'נשמר';

  @override
  String pagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count עמודים',
      two: 'שני עמודים',
      one: 'עמוד אחד',
    );
    return '$_temp0';
  }

  @override
  String get tabInbox => 'התראות';

  @override
  String get undo => 'ביטול פעולה';

  @override
  String correctionNotificationTitle(String name) {
    return 'תיקון עבור $name';
  }

  @override
  String eventUndone(String what) {
    return 'בוטל: $what';
  }

  @override
  String get resetDemo => 'איפוס נתוני הדגמה';

  @override
  String get resetDemoHint =>
      'מוחק את כל רישומי ההגעה, ההערות, הבקשות וההתראות כדי להתחיל יום נקי. הילדים והחשבונות נשארים.';

  @override
  String get resetDemoDone => 'נתוני ההדגמה אופסו';
}
