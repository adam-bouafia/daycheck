// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get roleStaff => 'الموظفون';

  @override
  String get todaysLogTooltip => 'سجل اليوم';

  @override
  String get signOutTooltip => 'تسجيل الخروج';

  @override
  String get noChildForGuardian => 'لم يتم العثور على طفل لولي الأمر هذا.';

  @override
  String get statusNotArrived => 'لم يصل';

  @override
  String get statusPresent => 'حاضر';

  @override
  String get statusDeparted => 'غادر';

  @override
  String get notArrivedYet => 'لم يصل بعد';

  @override
  String checkedInAtBy(String time, String name) {
    return 'وصل الساعة $time مع $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'غادر الساعة $time مع $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ملاحظة اليوم',
      many: '$count ملاحظة اليوم',
      few: '$count ملاحظات اليوم',
      two: 'ملاحظتان اليوم',
      one: 'ملاحظة واحدة اليوم',
      zero: 'لا ملاحظات اليوم',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count حدث اليوم',
      many: '$count حدثًا اليوم',
      few: '$count أحداث اليوم',
      two: 'حدثان اليوم',
      one: 'حدث واحد اليوم',
      zero: 'لا أحداث اليوم',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'تسجيل الوصول';

  @override
  String get checkOut => 'تسجيل المغادرة';

  @override
  String get addNote => 'إضافة ملاحظة';

  @override
  String get todaysActivity => 'أنشطة اليوم';

  @override
  String get nothingYetToday => 'لا شيء بعد اليوم.';

  @override
  String checkedInBy(String name) {
    return 'أحضره $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'استلمه $name';
  }

  @override
  String noteBy(String name) {
    return 'ملاحظة من $name';
  }

  @override
  String checkInChild(String name) {
    return 'تسجيل وصول $name';
  }

  @override
  String checkOutChild(String name) {
    return 'تسجيل مغادرة $name';
  }

  @override
  String get droppedOffBy => 'أحضره';

  @override
  String get pickedUpBy => 'استلمه';

  @override
  String get addActivityNoteTitle => 'إضافة نشاط';

  @override
  String get whatDidTheyDo => 'ماذا فعل اليوم؟';

  @override
  String get addPhoto => 'إضافة صورة';

  @override
  String get photoAdded => 'تمت إضافة الصورة';

  @override
  String get save => 'حفظ';

  @override
  String get nothingCheckedToday => 'لم يُسجَّل أي وصول أو مغادرة اليوم بعد.';

  @override
  String get unknownChild => 'طفل غير معروف';

  @override
  String get activityNoteLabel => 'ملاحظة نشاط';

  @override
  String newActivityNotificationTitle(String name) {
    return 'نشاط جديد لـ $name';
  }

  @override
  String get requestsTitle => 'الطلبات';

  @override
  String get requestTypeLeave => 'غياب';

  @override
  String get requestTypeExtraHours => 'ساعات إضافية';

  @override
  String get requestStatusPending => 'قيد الانتظار';

  @override
  String get requestStatusApproved => 'موافق عليه';

  @override
  String get requestStatusCancelled => 'ملغى';

  @override
  String get newRequestTitle => 'طلب جديد';

  @override
  String get pickDate => 'اختر تاريخًا';

  @override
  String get noteOptionalHint => 'ملاحظة (اختياري)';

  @override
  String get submitRequest => 'إرسال';

  @override
  String get approve => 'موافقة';

  @override
  String get cancelRequest => 'إلغاء';

  @override
  String get noRequestsYet => 'لا توجد طلبات بعد.';

  @override
  String requestedBy(String name) {
    return 'مقدم الطلب: $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'طلب غياب لـ $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'طلب ساعات إضافية لـ $name';
  }

  @override
  String get scheduleTooltip => 'الجدول';

  @override
  String get scheduleTitle => 'الجدول';

  @override
  String scheduledHours(String start, String end) {
    return 'مجدول $start–$end';
  }

  @override
  String get notScheduledToday => 'غير مجدول في هذا اليوم';

  @override
  String get photosTooltip => 'الصور';

  @override
  String get photosTitle => 'الصور';

  @override
  String get noPhotosYet => 'لا توجد صور بعد.';

  @override
  String get addPdf => 'إضافة ملف PDF';

  @override
  String get pdfAdded => 'تمت إضافة ملف PDF';

  @override
  String get attachmentLabel => 'مرفق';

  @override
  String get openAttachment => 'فتح';

  @override
  String get shareAttachment => 'مشاركة';

  @override
  String get couldNotOpenAttachment => 'تعذر فتح هذا الملف.';

  @override
  String get inboxTitle => 'الإشعارات';

  @override
  String get noNotificationsYet => 'لا توجد إشعارات بعد.';

  @override
  String get markAllRead => 'تعليم الكل كمقروء';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'تمت الموافقة على الطلب لـ $name';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'تم إلغاء الطلب لـ $name';
  }

  @override
  String get sharePhoto => 'مشاركة الصورة';

  @override
  String photoPosition(int index, int count) {
    return '$index من $count';
  }

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get languageLabel => 'اللغة';

  @override
  String get languageSystem => 'لغة الجهاز';

  @override
  String get themeLabel => 'المظهر';

  @override
  String get themeSystem => 'النظام';

  @override
  String get themeLight => 'فاتح';

  @override
  String get themeDark => 'داكن';

  @override
  String get reduceEffectsLabel => 'تقليل التأثيرات';

  @override
  String get reduceEffectsHint =>
      'لوحات صلبة بدل الزجاج الضبابي. أكثر سلاسة على الهواتف القديمة.';

  @override
  String get activityPopupsLabel => 'نوافذ منبثقة للأنشطة الجديدة';

  @override
  String get requestPopupsLabel => 'نوافذ منبثقة للطلبات';

  @override
  String get popupsHint =>
      'يصل كل شيء إلى قائمة الإشعارات داخل التطبيق في كل الأحوال. هذه المفاتيح تتحكم فقط في النافذة المنبثقة على هاتفك.';

  @override
  String get loginSubtitle => 'سجّل الدخول بحساب الحضانة.';

  @override
  String get usernameLabel => 'اسم المستخدم';

  @override
  String get passwordLabel => 'كلمة المرور';

  @override
  String get signInButton => 'تسجيل الدخول';

  @override
  String get loginFailed => 'اسم المستخدم أو كلمة المرور غير صحيحة.';

  @override
  String get demoAccountsTitle => 'حسابات تجريبية';

  @override
  String get demoAccountsHint => 'اضغط على حساب لملء بياناته. للتجربة فقط.';

  @override
  String get roleParent => 'ولي الأمر';

  @override
  String get tabChildren => 'الأطفال';

  @override
  String get tabLog => 'السجل';

  @override
  String get tabToday => 'اليوم';

  @override
  String helloName(String name) {
    return 'مرحبًا، $name';
  }

  @override
  String signedInAs(String name) {
    return 'تم تسجيل الدخول باسم $name';
  }

  @override
  String get statusAbsent => 'غائب';

  @override
  String get markAbsent => 'تسجيل غياب';

  @override
  String markAbsentTitle(String name) {
    return 'تسجيل غياب $name اليوم';
  }

  @override
  String get absentReasonHint => 'السبب، مثلًا مرض (اختياري)';

  @override
  String get absentInformsGuardians => 'يصل إشعار إلى كل ولي أمر لهذا الطفل.';

  @override
  String markedAbsentBy(String name) {
    return 'سجّل الغياب: $name';
  }

  @override
  String absentNotificationTitle(String name) {
    return '$name غائب اليوم';
  }

  @override
  String checkedInNotificationTitle(String name) {
    return 'وصل $name';
  }

  @override
  String checkedOutNotificationTitle(String name) {
    return 'تم استلام $name';
  }

  @override
  String expectedAt(String time) {
    return 'متوقع الساعة $time، لم يصل بعد';
  }

  @override
  String get attendancePopupsLabel => 'نوافذ منبثقة للوصول والاستلام والغياب';

  @override
  String get takePhoto => 'التقاط صورة';

  @override
  String get choosePhoto => 'اختيار صورة';

  @override
  String get documentsTitle => 'المستندات';

  @override
  String get downloadPdf => 'تنزيل';

  @override
  String get savedToDevice => 'تم الحفظ';

  @override
  String pagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count صفحة',
      many: '$count صفحة',
      few: '$count صفحات',
      two: 'صفحتان',
      one: 'صفحة واحدة',
      zero: 'لا صفحات',
    );
    return '$_temp0';
  }

  @override
  String get tabInbox => 'الإشعارات';

  @override
  String get undo => 'تراجع';

  @override
  String correctionNotificationTitle(String name) {
    return 'تصحيح لـ $name';
  }

  @override
  String eventUndone(String what) {
    return 'تم التراجع عن: $what';
  }

  @override
  String get resetDemo => 'إعادة ضبط بيانات العرض';

  @override
  String get resetDemoHint =>
      'يحذف كل تسجيلات الوصول والملاحظات والطلبات والإشعارات لبدء يوم جديد. يبقى الأطفال والحسابات.';

  @override
  String get resetDemoDone => 'تمت إعادة ضبط بيانات العرض';

  @override
  String get notArrivedHint => 'مسح وصول اليوم واستلامه وغيابه';
}
