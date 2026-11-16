import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/child_detail_screen.dart';
import 'package:daycheck/features/roster/presentation/daily_log_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/child_tile.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:daycheck/features/session/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RosterScreen extends ConsumerWidget {
  const RosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rosterViewModelProvider);
    final session = ref.watch(sessionViewModelProvider);
    final isStaff = session.role == Role.staff;
    final visibleChildren = isStaff
        ? state.children
        : state.children
              .where((c) => c.guardians.contains(session.guardianName))
              .toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isStaff ? 'DayCheck · Staff' : 'DayCheck · ${session.guardianName}',
        ),
        actions: [
          if (isStaff)
            IconButton(
              tooltip: "Today's log",
              icon: const Icon(Icons.history),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DailyLogScreen()),
              ),
            ),
          IconButton(
            tooltip: 'Sign out',
            icon: const Icon(Icons.logout),
            onPressed: () {
              ref.read(sessionViewModelProvider.notifier).signOut();
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (_) => const SignInScreen()),
              );
            },
          ),
        ],
      ),
      body: state.children.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : visibleChildren.isEmpty
          ? const Center(child: Text('No child found for this guardian.'))
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                for (final child in visibleChildren)
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
