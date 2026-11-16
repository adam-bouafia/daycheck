import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/home/presentation/home_scaffold.dart';
import 'package:daycheck/features/inbox/presentation/inbox_screen.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/requests/presentation/requests_screen.dart';
import 'package:daycheck/features/requests/presentation/requests_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/daily_log_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The daycare's side of the app: attendance and posting first.
class StaffHomeScreen extends ConsumerWidget {
  const StaffHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final pending = ref
        .watch(requestsViewModelProvider)
        .where((r) => r.status == RequestStatus.pending)
        .length;
    final unread = ref.watch(inboxViewModelProvider).where((i) => !i.read);
    return HomeScaffold(
      tabs: [
        HomeTab(
          icon: Icons.groups_outlined,
          selectedIcon: Icons.groups,
          label: l10n.tabChildren,
          screen: const RosterScreen(),
        ),
        HomeTab(
          icon: Icons.history,
          selectedIcon: Icons.history,
          label: l10n.tabLog,
          screen: const DailyLogScreen(),
        ),
        HomeTab(
          icon: Icons.event_note_outlined,
          selectedIcon: Icons.event_note,
          label: l10n.requestsTitle,
          screen: const RequestsScreen(),
          badge: pending,
        ),
        HomeTab(
          icon: Icons.notifications_outlined,
          selectedIcon: Icons.notifications,
          label: l10n.inboxTitle,
          screen: const InboxScreen(),
          badge: unread.length,
        ),
      ],
    );
  }
}
