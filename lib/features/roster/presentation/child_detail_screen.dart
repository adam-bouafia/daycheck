import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/calendar_screen.dart';
import 'package:daycheck/features/roster/presentation/photo_gallery_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/add_note_sheet.dart';
import 'package:daycheck/features/roster/presentation/widgets/check_sheet.dart';
import 'package:daycheck/features/roster/presentation/widgets/event_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Staff view of one child's day: status, check in or out, add a note
/// with a photo or PDF, and the feed. Parents never reach this screen;
/// they have their own Today tab.
class ChildDetailScreen extends ConsumerWidget {
  const ChildDetailScreen({super.key, required this.child});

  final Child child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(rosterViewModelProvider);
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
      extendBodyBehindAppBar: true,
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
                builder: (_) => PhotoGalleryScreen(children: [child]),
              ),
            ),
          ),
        ],
      ),
      body: GlassBackground(
        child: SafeArea(
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
              ...[
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
                for (final event in events) EventTile(event: event),
            ],
          ),
        ),
      ),
    );
  }
}
