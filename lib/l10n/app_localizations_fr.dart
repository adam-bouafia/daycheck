// ignore: unused_import
import 'package:intl/intl.dart' as intl;

import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get roleStaff => 'Personnel';

  @override
  String get todaysLogTooltip => 'Journal du jour';

  @override
  String get signOutTooltip => 'Se déconnecter';

  @override
  String get noChildForGuardian => 'Aucun enfant trouvé pour ce parent.';

  @override
  String get statusNotArrived => 'Pas arrivé';

  @override
  String get statusPresent => 'Présent';

  @override
  String get statusDeparted => 'Parti';

  @override
  String get notArrivedYet => 'Pas encore arrivé';

  @override
  String checkedInAtBy(String time, String name) {
    return 'Arrivée à $time, déposé par $name';
  }

  @override
  String checkedOutAtBy(String time, String name) {
    return 'Départ à $time, récupéré par $name';
  }

  @override
  String notesToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count notes aujourd\'hui',
      one: '1 note aujourd\'hui',
    );
    return '$_temp0';
  }

  @override
  String eventsToday(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count événements aujourd\'hui',
      one: '1 événement aujourd\'hui',
    );
    return '$_temp0';
  }

  @override
  String get checkIn => 'Arrivée';

  @override
  String get checkOut => 'Départ';

  @override
  String get addNote => 'Ajouter une note';

  @override
  String get todaysActivity => 'Activités du jour';

  @override
  String get nothingYetToday => 'Rien pour l\'instant aujourd\'hui.';

  @override
  String checkedInBy(String name) {
    return 'Déposé par $name';
  }

  @override
  String checkedOutBy(String name) {
    return 'Récupéré par $name';
  }

  @override
  String noteBy(String name) {
    return 'Note de $name';
  }

  @override
  String checkInChild(String name) {
    return 'Arrivée de $name';
  }

  @override
  String checkOutChild(String name) {
    return 'Départ de $name';
  }

  @override
  String get droppedOffBy => 'Déposé par';

  @override
  String get pickedUpBy => 'Récupéré par';

  @override
  String get addActivityNoteTitle => 'Ajouter une activité';

  @override
  String get whatDidTheyDo => 'Qu\'a-t-il fait aujourd\'hui ?';

  @override
  String get addPhoto => 'Ajouter une photo';

  @override
  String get photoAdded => 'Photo ajoutée';

  @override
  String get save => 'Enregistrer';

  @override
  String get nothingCheckedToday =>
      'Aucune arrivée ni aucun départ aujourd\'hui.';

  @override
  String get unknownChild => 'Enfant inconnu';

  @override
  String get activityNoteLabel => 'Note d\'activité';

  @override
  String newActivityNotificationTitle(String name) {
    return 'Nouvelle activité pour $name';
  }

  @override
  String get requestsTitle => 'Demandes';

  @override
  String get requestTypeLeave => 'Absence';

  @override
  String get requestTypeExtraHours => 'Heures supplémentaires';

  @override
  String get requestStatusPending => 'En attente';

  @override
  String get requestStatusApproved => 'Approuvée';

  @override
  String get requestStatusCancelled => 'Annulée';

  @override
  String get newRequestTitle => 'Nouvelle demande';

  @override
  String get pickDate => 'Choisir une date';

  @override
  String get noteOptionalHint => 'Note (facultatif)';

  @override
  String get submitRequest => 'Envoyer';

  @override
  String get approve => 'Approuver';

  @override
  String get cancelRequest => 'Annuler';

  @override
  String get noRequestsYet => 'Aucune demande pour l\'instant.';

  @override
  String requestedBy(String name) {
    return 'Demandé par $name';
  }

  @override
  String newLeaveRequestTitle(String name) {
    return 'Demande d\'absence pour $name';
  }

  @override
  String newExtraHoursRequestTitle(String name) {
    return 'Demande d\'heures supplémentaires pour $name';
  }

  @override
  String get scheduleTooltip => 'Planning';

  @override
  String get scheduleTitle => 'Planning';

  @override
  String scheduledHours(String start, String end) {
    return 'Prévu $start–$end';
  }

  @override
  String get notScheduledToday => 'Pas prévu ce jour-là';

  @override
  String get photosTooltip => 'Photos';

  @override
  String get photosTitle => 'Photos';

  @override
  String get noPhotosYet => 'Aucune photo pour l\'instant.';

  @override
  String get addPdf => 'Ajouter un PDF';

  @override
  String get pdfAdded => 'PDF ajouté';

  @override
  String get attachmentLabel => 'Pièce jointe';

  @override
  String get openAttachment => 'Ouvrir';

  @override
  String get shareAttachment => 'Partager';

  @override
  String get couldNotOpenAttachment => 'Impossible d\'ouvrir ce fichier.';

  @override
  String get inboxTitle => 'Notifications';

  @override
  String get noNotificationsYet => 'Aucune notification pour l\'instant.';

  @override
  String get markAllRead => 'Tout marquer comme lu';

  @override
  String requestApprovedNotificationTitle(String name) {
    return 'Demande approuvée pour $name';
  }

  @override
  String requestCancelledNotificationTitle(String name) {
    return 'Demande annulée pour $name';
  }

  @override
  String get sharePhoto => 'Partager la photo';

  @override
  String photoPosition(int index, int count) {
    return '$index sur $count';
  }

  @override
  String get settingsTitle => 'Paramètres';

  @override
  String get languageLabel => 'Langue';

  @override
  String get languageSystem => 'Langue de l\'appareil';

  @override
  String get themeLabel => 'Apparence';

  @override
  String get themeSystem => 'Système';

  @override
  String get themeLight => 'Clair';

  @override
  String get themeDark => 'Sombre';

  @override
  String get reduceEffectsLabel => 'Réduire les effets';

  @override
  String get reduceEffectsHint =>
      'Panneaux opaques au lieu du verre flou. Plus fluide sur les anciens téléphones.';

  @override
  String get activityPopupsLabel => 'Pop-ups pour les nouvelles activités';

  @override
  String get requestPopupsLabel => 'Pop-ups pour les demandes';

  @override
  String get popupsHint =>
      'Tout arrive quand même dans la liste des notifications de l\'application. Ces interrupteurs ne règlent que le pop-up sur votre téléphone.';

  @override
  String get loginSubtitle => 'Connectez-vous avec votre compte de la crèche.';

  @override
  String get usernameLabel => 'Nom d\'utilisateur';

  @override
  String get passwordLabel => 'Mot de passe';

  @override
  String get signInButton => 'Se connecter';

  @override
  String get loginFailed => 'Nom d\'utilisateur ou mot de passe incorrect.';

  @override
  String get demoAccountsTitle => 'Comptes de test';

  @override
  String get demoAccountsHint =>
      'Touchez un compte pour remplir ses identifiants. Pour les tests uniquement.';

  @override
  String get roleParent => 'Parent';

  @override
  String get tabChildren => 'Enfants';

  @override
  String get tabLog => 'Journal';

  @override
  String get tabToday => 'Aujourd\'hui';

  @override
  String helloName(String name) {
    return 'Bonjour, $name';
  }

  @override
  String signedInAs(String name) {
    return 'Connecté en tant que $name';
  }

  @override
  String get statusAbsent => 'Absent';

  @override
  String get markAbsent => 'Signaler absent';

  @override
  String markAbsentTitle(String name) {
    return 'Signaler $name absent aujourd\'hui';
  }

  @override
  String get absentReasonHint => 'Motif, par exemple malade (facultatif)';

  @override
  String get absentInformsGuardians =>
      'Chaque parent de cet enfant reçoit une notification.';

  @override
  String markedAbsentBy(String name) {
    return 'Signalé absent par $name';
  }

  @override
  String absentNotificationTitle(String name) {
    return '$name est absent aujourd\'hui';
  }

  @override
  String checkedInNotificationTitle(String name) {
    return '$name est arrivé';
  }

  @override
  String checkedOutNotificationTitle(String name) {
    return '$name a été récupéré';
  }

  @override
  String expectedAt(String time) {
    return 'Attendu à $time, pas encore arrivé';
  }

  @override
  String get attendancePopupsLabel =>
      'Pop-ups pour l\'arrivée, le départ et l\'absence';

  @override
  String get takePhoto => 'Prendre une photo';

  @override
  String get choosePhoto => 'Choisir une photo';

  @override
  String get documentsTitle => 'Documents';

  @override
  String get downloadPdf => 'Télécharger';

  @override
  String get savedToDevice => 'Enregistré';

  @override
  String pagesCount(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count pages',
      one: '1 page',
    );
    return '$_temp0';
  }

  @override
  String get tabInbox => 'Alertes';
}
