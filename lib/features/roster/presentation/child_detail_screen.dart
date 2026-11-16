import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/calendar_screen.dart';
import 'package:daycheck/features/roster/presentation/photo_gallery_screen.dart';
import 'package:daycheck/features/roster/presentation/photo_viewer_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/add_note_sheet.dart';
import 'package:daycheck/features/roster/presentation/widgets/check_sheet.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_filex/open_filex.dart';
import 'package:share_plus/share_plus.dart';

/// One child's full day: status, check-in/out, and the activity feed
/// (notes and photos) shared by staff. Staff can check in/out and add
/// notes; a parent gets the same feed read-only.
class ChildDetailScreen extends ConsumerWidget {
  const ChildDetailScreen({super.key, required this.child});

  final Child child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(rosterViewModelProvider);
    final isStaff = ref.watch(sessionViewModelProvider).role == Role.staff;
    final status = state.statusOf(child.id);
    final events = state.eventsOf(child.id);
    final scheme = Theme.of(context).colorScheme;
    final (label, color) = switch (status) {
      DayStatus.notArrived => (l10n.statusNotArrived, scheme.onSurfaceVariant),
      DayStatus.present => (l10n.statusPresent, scheme.primary),
      DayStatus.departed => (l10n.statusDeparted, scheme.tertiary),
    };
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(child.name),
        actions: [
          IconButton(
            tooltip: l10n.scheduleTooltip,
            icon: const Icon(Icons.calendar_month_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CalendarScreen(child: child)),
            ),
          ),
          IconButton(
            tooltip: l10n.photosTooltip,
            icon: const Icon(Icons.photo_library_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PhotoGalleryScreen(child: child),
              ),
            ),
          ),
        ],
      ),
      body: GlassBackground(
        child: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 96),
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 28,
                    child: Text(
                      child.name.characters.first,
                      style: const TextStyle(fontSize: 22),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Chip(
                          label: Text(label),
                          backgroundColor: color.withValues(alpha: 0.12),
                          labelStyle: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w600,
                          ),
                          side: BorderSide.none,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.eventsToday(events.length),
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (isStaff) ...[
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () => openCheckSheet(context, child, status),
                        icon: Icon(
                          status == DayStatus.present
                              ? Icons.logout
                              : Icons.login,
                        ),
                        label: Text(
                          status == DayStatus.present
                              ? l10n.checkOut
                              : l10n.checkIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton.tonalIcon(
                        onPressed: () => openAddNoteSheet(context, child.id),
                        icon: const Icon(Icons.edit_note),
                        label: Text(l10n.addNote),
                      ),
                    ),
                  ],
                ),
              ],
              const SizedBox(height: 20),
              Text(
                l10n.todaysActivity,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              if (events.isEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  child: Text(
                    l10n.nothingYetToday,
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                )
              else
                for (final event in events) _EventTile(event: event),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventTile extends StatelessWidget {
  const _EventTile({required this.event});

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
