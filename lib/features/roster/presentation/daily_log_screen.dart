import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyLogScreen extends ConsumerWidget {
  const DailyLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(rosterViewModelProvider);
    final events = [...state.events]..sort((a, b) => b.at.compareTo(a.at));
    final names = {for (final c in state.children) c.id: c.name};
    return Scaffold(
      appBar: AppBar(title: Text(l10n.todaysLogTooltip)),
      body: events.isEmpty
          ? Center(child: Text(l10n.nothingCheckedToday))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final time = TimeOfDay.fromDateTime(event.at);
                final (icon, subtitle) = switch (event.kind) {
                  EventKind.checkIn => (
                    Icons.login,
                    l10n.checkedInBy(event.by),
                  ),
                  EventKind.checkOut => (
                    Icons.logout,
                    l10n.checkedOutBy(event.by),
                  ),
                  EventKind.activityNote => (
                    Icons.edit_note,
                    l10n.noteBy(event.by),
                  ),
                };
                return ListTile(
                  leading: Icon(icon),
                  title: Text(names[event.childId] ?? l10n.unknownChild),
                  subtitle: Text(subtitle),
                  trailing: Text(
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  ),
                );
              },
            ),
    );
  }
}
