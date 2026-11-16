import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/child_detail_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/child_tile.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The staff home tab: today's attendance at a glance, then every child.
/// Tapping a child opens the screen to check them in or out and post
/// notes, photos and PDFs.
class RosterScreen extends ConsumerWidget {
  const RosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(rosterViewModelProvider);
    final name = ref.watch(sessionViewModelProvider).displayName;
    final counts = {
      for (final s in DayStatus.values)
        s: state.children.where((c) => state.statusOf(c.id) == s).length,
    };
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.helloName(name.split(' ').first)),
        actions: const [SettingsButton()],
      ),
      body: GlassBackground(
        child: SafeArea(
          child: state.children.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    _Summary(counts: counts),
                    const SizedBox(height: 14),
                    for (final child in state.children)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: ChildTile(
                          child: child,
                          status: state.statusOf(child.id),
                          lastAttendance: state
                              .attendanceOf(child.id)
                              .firstOrNull,
                          noteCount: state
                              .eventsOf(child.id)
                              .where((e) => e.kind == EventKind.activityNote)
                              .length,
                          onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ChildDetailScreen(child: child),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.counts});

  final Map<DayStatus, int> counts;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    Widget cell(DayStatus status, String label, Color color) => Expanded(
      child: Column(
        children: [
          Text(
            '${counts[status]}',
            style: text.headlineMedium?.copyWith(
              color: color,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(label, textAlign: TextAlign.center, style: text.bodySmall),
        ],
      ),
    );
    return GlassPanel(
      radius: 18,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        child: Row(
          children: [
            cell(DayStatus.present, l10n.statusPresent, scheme.primary),
            cell(
              DayStatus.notArrived,
              l10n.statusNotArrived,
              scheme.onSurfaceVariant,
            ),
            cell(DayStatus.departed, l10n.statusDeparted, scheme.tertiary),
          ],
        ),
      ),
    );
  }
}
