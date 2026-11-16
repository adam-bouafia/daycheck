import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
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
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.todaysLogTooltip),
        actions: const [SettingsButton()],
      ),
      body: GlassBackground(
        child: SafeArea(
          child: events.isEmpty
              ? Center(child: Text(l10n.nothingCheckedToday))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
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
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassPanel(
                        radius: 14,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          child: Row(
                            children: [
                              Icon(icon),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      names[event.childId] ?? l10n.unknownChild,
                                    ),
                                    Text(subtitle),
                                  ],
                                ),
                              ),
                              Text(
                                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
        ),
      ),
    );
  }
}
