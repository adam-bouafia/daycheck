import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/child_detail_screen.dart';
import 'package:daycheck/features/roster/presentation/daily_log_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/child_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RosterScreen extends ConsumerWidget {
  const RosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rosterViewModelProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('DayCheck'),
        actions: [
          IconButton(
            tooltip: "Today's log",
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const DailyLogScreen()),
            ),
          ),
        ],
      ),
      body: state.children.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                for (final child in state.children)
                  ChildTile(
                    child: child,
                    status: state.statusOf(child.id),
                    lastAttendance: state.attendanceOf(child.id).firstOrNull,
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
              ],
            ),
    );
  }
}
