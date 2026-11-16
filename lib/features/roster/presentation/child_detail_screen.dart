import 'dart:io';

import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/add_note_sheet.dart';
import 'package:daycheck/features/roster/presentation/widgets/check_sheet.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      appBar: AppBar(title: Text(child.name)),
      body: ListView(
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
                      status == DayStatus.present ? Icons.logout : Icons.login,
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
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: Icon(icon),
              title: Text(title),
              subtitle: event.note == null ? null : Text(event.note!),
              trailing: Text(clock),
            ),
            if (photoName != null) _EventPhoto(name: photoName),
          ],
        ),
      ),
    );
  }
}

class _EventPhoto extends ConsumerWidget {
  const _EventPhoto({required this.name});

  final String name;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final folder = ref.watch(photosFolderProvider).value;
    if (folder == null) return const SizedBox.shrink();
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Image.file(
        File('${folder.path}/$name'),
        height: 140,
        fit: BoxFit.cover,
      ),
    );
  }
}
