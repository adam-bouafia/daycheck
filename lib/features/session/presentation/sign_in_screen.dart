import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/roster/presentation/roster_screen.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A demo stand-in for real sign-in: pick a role, and if it's a parent,
/// pick which guardian. A real app would do this with an actual login.
class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  void _enterRoster(BuildContext context) => Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (_) => const RosterScreen()));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final children = ref.watch(rosterViewModelProvider).children;
    final guardians = {for (final c in children) ...c.guardians}.toList()
      ..sort();
    return Scaffold(
      appBar: AppBar(title: const Text('DayCheck')),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Text(
            l10n.signInPrompt,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(
            l10n.signInDemoNotice,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 20),
          Card(
            child: ListTile(
              leading: const Icon(Icons.badge_outlined),
              title: Text(l10n.roleStaff),
              subtitle: Text(l10n.roleStaffSubtitle),
              onTap: () {
                ref.read(sessionViewModelProvider.notifier).signInAsStaff();
                _enterRoster(context);
              },
            ),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.roleParentPrompt,
            style: Theme.of(context).textTheme.titleSmall,
          ),
          const SizedBox(height: 8),
          for (final guardian in guardians)
            Card(
              child: ListTile(
                leading: const Icon(Icons.family_restroom_outlined),
                title: Text(guardian),
                subtitle: Text(l10n.roleParentSubtitle),
                onTap: () {
                  ref
                      .read(sessionViewModelProvider.notifier)
                      .signInAsParent(guardian);
                  _enterRoster(context);
                },
              ),
            ),
        ],
      ),
    );
  }
}
