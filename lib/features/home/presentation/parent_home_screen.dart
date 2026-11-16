import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
import 'package:daycheck/features/documents/presentation/documents_screen.dart';
import 'package:daycheck/features/home/presentation/home_scaffold.dart';
import 'package:daycheck/features/home/presentation/parent_today_screen.dart';
import 'package:daycheck/features/inbox/presentation/inbox_screen.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/requests/presentation/requests_screen.dart';
import 'package:daycheck/features/roster/presentation/photo_gallery_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// The family's side of the app: their own children only, read-only,
/// with what parents open the app for first (is my child there, what did
/// they do, photos) and nothing staff use.
class ParentHomeScreen extends ConsumerWidget {
  const ParentHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final guardian = ref.watch(sessionViewModelProvider).guardianName;
    final children = ref
        .watch(rosterViewModelProvider)
        .children
        .where((c) => c.guardians.contains(guardian))
        .toList();
    final ids = children.map((c) => c.id).toSet();
    final unread = visibleInboxItems(
      ref.watch(inboxViewModelProvider),
      false,
      ids,
    ).where((i) => !i.read).length;
    return HomeScaffold(
      tabs: [
        HomeTab(
          icon: Icons.wb_sunny_outlined,
          selectedIcon: Icons.wb_sunny,
          label: l10n.tabToday,
          screen: ParentTodayScreen(children: children),
        ),
        HomeTab(
          icon: Icons.photo_library_outlined,
          selectedIcon: Icons.photo_library,
          label: l10n.photosTitle,
          screen: PhotoGalleryScreen(
            children: children,
            actions: const [SettingsButton()],
          ),
        ),
        HomeTab(
          icon: Icons.description_outlined,
          selectedIcon: Icons.description,
          label: l10n.documentsTitle,
          screen: const DocumentsScreen(),
        ),
        HomeTab(
          icon: Icons.event_note_outlined,
          selectedIcon: Icons.event_note,
          label: l10n.requestsTitle,
          screen: const RequestsScreen(),
        ),
        HomeTab(
          icon: Icons.notifications_outlined,
          selectedIcon: Icons.notifications,
          label: l10n.tabInbox,
          screen: const InboxScreen(),
          badge: unread,
        ),
      ],
    );
  }
}
