import 'package:daycheck/core/files/pdf_actions.dart';
import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
import 'package:daycheck/features/documents/data/daycare_document.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI seam: tests override this with a fake repository.
final documentRepositoryProvider = Provider<DocumentRepository>(
  (ref) => DocumentRepository(),
);

/// Each document as a ready-to-open file on the device.
final documentFileProvider = FutureProvider.family<String, DaycareDocument>(
  (ref, doc) => ref.read(documentRepositoryProvider).fileFor(doc),
);

class DocumentsScreen extends ConsumerWidget {
  const DocumentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final docs = ref.watch(documentRepositoryProvider).documents;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.documentsTitle),
        actions: const [SettingsButton()],
      ),
      body: GlassBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              for (final doc in docs)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _DocumentTile(doc: doc),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DocumentTile extends ConsumerWidget {
  const _DocumentTile({required this.doc});

  final DaycareDocument doc;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final path = ref.watch(documentFileProvider(doc)).value;
    final date = MaterialLocalizations.of(context)
        .formatMediumDate(doc.published);
    return GlassPanel(
      radius: 16,
      onTap: path == null ? null : () => openPdf(context, path),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 4, 12),
        child: Row(
          children: [
            Icon(Icons.picture_as_pdf, color: scheme.error, size: 34),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    doc.title,
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  Text(
                    '$date · ${l10n.pagesCount(doc.pages)}',
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            if (path != null) PdfActions(path: path, fileName: doc.fileName),
          ],
        ),
      ),
    );
  }
}
