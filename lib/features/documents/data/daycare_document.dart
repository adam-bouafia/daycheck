import 'dart:io';

import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';

/// A document the daycare shares with every family: a newsletter, a menu,
/// a form to fill in.
class DaycareDocument {
  const DaycareDocument({
    required this.title,
    required this.fileName,
    required this.published,
    required this.pages,
  });

  final String title;
  final String fileName;
  final DateTime published;
  final int pages;

  String get asset => 'assets/documents/$fileName';
}

/// Demo documents bundled with the app (built by tool/make_demo_pdfs.py).
/// A real app would list these from the server.
class DocumentRepository {
  List<DaycareDocument> get documents => [
    DaycareDocument(
      title: 'Newsletter November 2026',
      fileName: 'newsletter_november_2026.pdf',
      published: DateTime(2026, 11, 2),
      pages: 2,
    ),
    DaycareDocument(
      title: 'Weekly menu, week 47',
      fileName: 'weekly_menu_week_47.pdf',
      published: DateTime(2026, 11, 13),
      pages: 1,
    ),
    DaycareDocument(
      title: 'Permission form: petting zoo visit',
      fileName: 'permission_petting_zoo.pdf',
      published: DateTime(2026, 11, 16),
      pages: 1,
    ),
  ];

  /// A real file for the viewer and the share sheet, which cannot read
  /// from inside the app bundle. Copied once, then reused.
  Future<String> fileFor(DaycareDocument doc) async {
    final dir = Directory('${(await getTemporaryDirectory()).path}/documents');
    final file = File('${dir.path}/${doc.fileName}');
    if (!await file.exists()) {
      await dir.create(recursive: true);
      final data = await rootBundle.load(doc.asset);
      await file.writeAsBytes(data.buffer.asUint8List(), flush: true);
    }
    return file.path;
  }
}
