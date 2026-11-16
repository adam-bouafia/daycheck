import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/roster/data/day_event.dart';
import 'package:daycheck/features/roster/presentation/child_detail_screen.dart';
import 'package:daycheck/features/roster/presentation/daily_log_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/widgets/child_tile.dart';
import 'package:daycheck/features/requests/presentation/requests_screen.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:daycheck/features/session/presentation/sign_in_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RosterScreen extends ConsumerWidget {
  const RosterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final state = ref.watch(rosterViewModelProvider);
    final session = ref.watch(sessionViewModelProvider);
    final isStaff = session.role == Role.staff;
    final visibleChildren = isStaff
        ? state.children
        : state.children
              .where((c) => c.guardians.contains(session.guardianName))
              .toList();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        title: Text(
          isStaff
              ? l10n.appBarStaff
              : l10n.appBarParent(session.guardianName ?? ''),
        ),
        actions: [
          if (isStaff)
            IconButton(
              tooltip: l10n.todaysLogTooltip,
              icon: const Icon(Icons.history),
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const DailyLogScreen()),
              ),
            ),
          IconButton(
            tooltip: l10n.requestsTooltip,
            icon: const Icon(Icons.event_note_outlined),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RequestsScreen()),
            ),
          ),
          IconButton(
            tooltip: l10n.signOutTooltip,
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
      body: GlassBackground(
        child: SafeArea(
          top: false,
          child: state.children.isEmpty
              ? const Center(child: CircularProgressIndicator())
              : visibleChildren.isEmpty
              ? Center(child: Text(l10n.noChildForGuardian))
              : ListView(
                  padding: const EdgeInsets.all(12),
                  children: [
                    for (final child in visibleChildren)
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
