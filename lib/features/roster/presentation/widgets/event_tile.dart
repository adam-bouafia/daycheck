import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/photo_viewer_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

/// One row of a child's day: a check-in, check-out or activity note, with
/// its photo (tap for the viewer) and PDF (open or share).
class EventTile extends StatelessWidget {
  const EventTile({super.key, required this.event});

  final DayEvent event;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final time = TimeOfDay.fromDateTime(event.at);
    final clock =
        '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
    final (icon, title) = switch (event.kind) {
      EventKind.checkIn => (Icons.login, l10n.checkedInBy(event.by)),
      EventKind.checkOut => (Icons.logout, l10n.checkedOutBy(event.by)),
      EventKind.activityNote => (Icons.edit_note, l10n.noteBy(event.by)),
    };
    final photoName = event.photoName;
    final attachmentName = event.attachmentName;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassPanel(
        radius: 14,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(icon),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title),
                        if (event.note != null) Text(event.note!),
                      ],
                    ),
                  ),
                  Text(clock),
                ],
              ),
              if (photoName != null) ...[
                const SizedBox(height: 8),
                _EventPhoto(event: event),
              ],
              if (attachmentName != null) ...[
                const SizedBox(height: 8),
                _EventAttachment(name: attachmentName),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _EventAttachment extends ConsumerWidget {
  const _EventAttachment({required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final folder = ref.watch(attachmentsFolderProvider).value;
    final scheme = Theme.of(context).colorScheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: scheme.surfaceContainerHighest.withValues(alpha: 0.5),
      ),
      child: Row(
        children: [
          Icon(Icons.picture_as_pdf_outlined, color: scheme.error),
          const SizedBox(width: 8),
          Expanded(child: Text(l10n.attachmentLabel)),
          if (folder != null) ...[
            IconButton(
              tooltip: l10n.openAttachment,
              icon: const Icon(Icons.open_in_new),
              onPressed: () async {
                final result = await OpenFilex.open('${folder.path}/$name');
                if (result.type != ResultType.done && context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(l10n.couldNotOpenAttachment)),
                  );
                }
              },
            ),
            IconButton(
              tooltip: l10n.shareAttachment,
              icon: const Icon(Icons.ios_share),
              onPressed: () => SharePlus.instance.share(
                ShareParams(files: [XFile('${folder.path}/$name')]),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _EventPhoto extends ConsumerWidget {
  const _EventPhoto({required this.event});

  final DayEvent event;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folder = ref.watch(photosFolderProvider).value;
    if (folder == null) return const SizedBox.shrink();
    return GestureDetector(
      onTap: () {
        final photos = ref
            .read(rosterViewModelProvider)
            .eventsOf(event.childId)
            .where((e) => e.photoName != null)
            .toList();
        openPhotoViewer(context, photos, photos.indexOf(event));
      },
      child: Hero(
        tag: photoHeroTag(event),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            File('${folder.path}/${event.photoName}'),
            height: 140,
            width: double.infinity,
            fit: BoxFit.cover,
            cacheWidth: 900,
          ),
        ),
      ),
    );
  }
}
