import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/calendar_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/event_tile.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The parent home tab: where each of their children is right now, and
/// everything staff shared about them today. Read-only by design.
class ParentTodayScreen extends ConsumerWidget {
  const ParentTodayScreen({super.key, required this.children});

  final List<Child> children;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(rosterViewModelProvider);
    final name = ref.watch(sessionViewModelProvider).displayName;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.helloName(name.split(' ').first)),
        actions: const [SettingsButton()],
      ),
      body: GlassBackground(
        child: SafeArea(
          child: children.isEmpty
              ? Center(child: Text(l10n.noChildForGuardian))
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    for (final child in children) ...[
                      _StatusCard(child: child),
                      const SizedBox(height: 16),
                      Text(
                        l10n.todaysActivity,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 8),
                      if (state.eventsOf(child.id).isEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Text(
                            l10n.nothingYetToday,
                            style: TextStyle(color: scheme.onSurfaceVariant),
                          ),
                        )
                      else
                        for (final e in state.eventsOf(child.id))
                          EventTile(event: e),
                      const SizedBox(height: 20),
                    ],
                  ],
                ),
        ),
      ),
    );
  }
}

class _StatusCard extends ConsumerWidget {
  const _StatusCard({required this.child});

  final Child child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(rosterViewModelProvider);
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final status = state.statusOf(child.id);
    final last = state.attendanceOf(child.id).firstOrNull;
    final schedule = state.scheduleOf(child.id);
    final today = DateTime.now();
    final loc = MaterialLocalizations.of(context);
    String clock(DateTime t) => loc.formatTimeOfDay(
      TimeOfDay.fromDateTime(t),
      alwaysUse24HourFormat: true,
    );
    String minutes(int m) => loc.formatTimeOfDay(
      TimeOfDay(hour: m ~/ 60, minute: m % 60),
      alwaysUse24HourFormat: true,
    );

    final (label, color, icon) = switch (status) {
      DayStatus.notArrived => (
        l10n.statusNotArrived,
        scheme.onSurfaceVariant,
        Icons.home_outlined,
      ),
      DayStatus.present => (
        l10n.statusPresent,
        scheme.primary,
        Icons.child_care,
      ),
      DayStatus.departed => (
        l10n.statusDeparted,
        scheme.tertiary,
        Icons.directions_walk,
      ),
    };
    final detail = switch (last?.kind) {
      EventKind.checkIn => l10n.checkedInAtBy(clock(last!.at), last.by),
      EventKind.checkOut => l10n.checkedOutAtBy(clock(last!.at), last.by),
      _ => l10n.notArrivedYet,
    };

    return GlassPanel(
      radius: 20,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 26,
                  backgroundColor: color.withValues(alpha: 0.15),
                  child: Icon(icon, color: color),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(child.name, style: text.titleLarge),
                      Text(
                        label,
                        style: TextStyle(
                          color: color,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(detail),
            const SizedBox(height: 4),
            Text(
              schedule != null && schedule.isScheduledOn(today)
                  ? l10n.scheduledHours(
                      minutes(schedule.startMinutes),
                      minutes(schedule.endMinutes),
                    )
                  : l10n.notScheduledToday,
              style: TextStyle(color: scheme.onSurfaceVariant),
            ),
            Align(
              alignment: AlignmentDirectional.centerEnd,
              child: TextButton.icon(
                icon: const Icon(Icons.calendar_month_outlined),
                label: Text(l10n.scheduleTitle),
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CalendarScreen(child: child),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
