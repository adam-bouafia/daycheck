import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
import 'package:daycheck/features/home/presentation/parent_today_screen.dart';
import 'package:daycheck/features/requests/presentation/requests_screen.dart';
import 'package:daycheck/features/roster/presentation/child_detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  /// Marks the item read and opens what it is about: the request list
  /// for a request, the child (staff) or that child's day (parent).
  void _open(BuildContext context, WidgetRef ref, InboxItem item, bool staff) {
    final username = ref.read(sessionViewModelProvider).account?.username;
    if (username != null) {
      ref.read(inboxViewModelProvider.notifier).markRead(item.id, username);
    }
    final child = ref
        .read(rosterViewModelProvider)
        .children
        .where((c) => c.id == item.childId)
        .firstOrNull;
    final Widget? target = switch (item.link) {
      InboxLink.request => const RequestsScreen(),
      InboxLink.child when child != null =>
        staff
            ? ChildDetailScreen(child: child)
            : ParentTodayScreen(children: [child]),
      _ => null,
    };
    if (target != null) {
      Navigator.push(context, MaterialPageRoute(builder: (_) => target));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionViewModelProvider);
    final isStaff = session.role == Role.staff;
    final username = session.account?.username ?? '';
    final items = ref.watch(myInboxProvider);

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.inboxTitle),
        actions: [
          if (items.any((i) => !i.isReadBy(username)))
            TextButton(
              onPressed: () => ref
                  .read(inboxViewModelProvider.notifier)
                  .markAllRead(username, {for (final i in items) i.id}),
              child: Text(l10n.markAllRead),
            ),
          const SettingsButton(),
        ],
      ),
      body: GlassBackground(
        child: SafeArea(
          child: items.isEmpty
              ? Center(child: Text(l10n.noNotificationsYet))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final time = TimeOfDay.fromDateTime(item.at);
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GlassPanel(
                        onTap: () => _open(context, ref, item, isStaff),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              if (!item.isReadBy(username))
                                Container(
                                  width: 8,
                                  height: 8,
                                  margin: const EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .primary,
                                  ),
                                ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.title,
                                      style: TextStyle(
                                        fontWeight: item.isReadBy(username)
                                            ? FontWeight.normal
                                            : FontWeight.bold,
                                      ),
                                    ),
                                    Text(item.body),
                                  ],
                                ),
                              ),
                              Text(
                                '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                              ),
                              if (item.link != InboxLink.none)
                                const Icon(Icons.chevron_right),
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
