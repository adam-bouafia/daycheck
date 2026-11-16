import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

/// Opens the PDF in the phone's own viewer.
Future<void> openPdf(BuildContext context, String path) async {
  final result = await OpenFilex.open(path, type: 'application/pdf');
  if (result.type != ResultType.done && context.mounted) {
    _say(context, context.l10n.couldNotOpenAttachment);
  }
}

/// Lets the user pick where to save a copy (Downloads, Drive, ...),
/// through the system's save dialog, so the app needs no storage
/// permission.
Future<void> downloadPdf(
  BuildContext context,
  String path,
  String fileName,
) async {
  final saved = await FilePicker.saveFile(
    fileName: fileName,
    bytes: await File(path).readAsBytes(),
    mimeType: 'application/pdf',
  );
  if (saved != null && context.mounted) {
    _say(context, context.l10n.savedToDevice);
  }
}

Future<void> sharePdf(String path) => SharePlus.instance.share(
  ShareParams(files: [XFile(path, mimeType: 'application/pdf')]),
);

void _say(BuildContext context, String text) =>
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));

/// Open, download and share buttons for one PDF.
class PdfActions extends StatelessWidget {
  const PdfActions({super.key, required this.path, required this.fileName});

  final String path;
  final String fileName;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          tooltip: l10n.openAttachment,
          icon: const Icon(Icons.open_in_new),
          onPressed: () => openPdf(context, path),
        ),
        IconButton(
          tooltip: l10n.downloadPdf,
          icon: const Icon(Icons.download_outlined),
          onPressed: () => downloadPdf(context, path, fileName),
        ),
        IconButton(
          tooltip: l10n.shareAttachment,
          icon: const Icon(Icons.ios_share),
          onPressed: () => sharePdf(path),
        ),
      ],
    );
  }
}
