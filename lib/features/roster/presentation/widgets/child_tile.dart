import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
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

  String get _subtitle {
    final event = lastAttendance;
    if (event == null) return 'Not arrived yet';
    final time = TimeOfDay.fromDateTime(event.at).format24();
    return switch (status) {
      DayStatus.present => 'Checked in at $time by ${event.by}',
      DayStatus.departed => 'Checked out at $time by ${event.by}',
      DayStatus.notArrived => 'Not arrived yet',
    };
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final (label, color) = switch (status) {
      DayStatus.notArrived => ('Not arrived', scheme.onSurfaceVariant),
      DayStatus.present => ('Present', scheme.primary),
      DayStatus.departed => ('Departed', scheme.tertiary),
    };
    return Card(
      child: ListTile(
        onTap: onTap,
        leading: CircleAvatar(child: Text(child.name.characters.first)),
        title: Text(child.name),
        subtitle: Text(
          noteCount == 0
              ? _subtitle
              : '$_subtitle · $noteCount ${noteCount == 1 ? 'note' : 'notes'} today',
        ),
        trailing: Chip(
          label: Text(label),
          backgroundColor: color.withValues(alpha: 0.12),
          labelStyle: TextStyle(color: color, fontWeight: FontWeight.w600),
          side: BorderSide.none,
        ),
      ),
    );
  }
}

extension on TimeOfDay {
  String format24() =>
      '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}
