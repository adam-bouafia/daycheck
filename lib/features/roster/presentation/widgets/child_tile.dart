import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class ChildTile extends StatelessWidget {
  const ChildTile({
    super.key,
    required this.child,
    required this.status,
    required this.lastAttendance,
    required this.noteCount,
    required this.onTap,
  });

  final Child child;
  final DayStatus status;

  /// The most recent check-in/out event, if any.
  final DayEvent? lastAttendance;
  final int noteCount;
  final VoidCallback onTap;

  String _attendanceLine(AppLocalizations l10n) {
    final event = lastAttendance;
    if (event == null) return l10n.notArrivedYet;
    final time = TimeOfDay.fromDateTime(event.at).format24();
    return switch (status) {
      DayStatus.present => l10n.checkedInAtBy(time, event.by),
      DayStatus.departed => l10n.checkedOutAtBy(time, event.by),
      DayStatus.notArrived => l10n.notArrivedYet,
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final (label, color) = switch (status) {
      DayStatus.notArrived => (l10n.statusNotArrived, scheme.onSurfaceVariant),
      DayStatus.present => (l10n.statusPresent, scheme.primary),
      DayStatus.departed => (l10n.statusDeparted, scheme.tertiary),
    };
    final attendanceLine = _attendanceLine(l10n);
    return GlassPanel(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Row(
          children: [
            CircleAvatar(child: Text(child.name.characters.first)),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    child.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 2),
                  Text(
                    noteCount == 0
                        ? attendanceLine
                        : '$attendanceLine · ${l10n.notesToday(noteCount)}',
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Chip(
              label: Text(label),
              backgroundColor: color.withValues(alpha: 0.12),
              labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
              side: BorderSide.none,
            ),
          ],
        ),
      ),
    );
  }
}

extension on TimeOfDay {
  String format24() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
