import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
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
    final scheme = Theme.of(context).colorScheme;
    final children = ref.watch(rosterViewModelProvider).children;
    final guardians = {for (final c in children) ...c.guardians}.toList()
      ..sort();
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(title: const Text('DayCheck')),
      body: GlassBackground(
        child: SafeArea(
          top: false,
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              Text(
                l10n.signInPrompt,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 4),
              Text(
                l10n.signInDemoNotice,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              _RoleCard(
                icon: Icons.badge_outlined,
                title: l10n.roleStaff,
                subtitle: l10n.roleStaffSubtitle,
                onTap: () {
                  ref.read(sessionViewModelProvider.notifier).signInAsStaff();
                  _enterRoster(context);
                },
              ),
              const SizedBox(height: 16),
              Text(
                l10n.roleParentPrompt,
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              for (final guardian in guardians)
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: _RoleCard(
                    icon: Icons.family_restroom_outlined,
                    title: guardian,
                    subtitle: l10n.roleParentSubtitle,
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
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  const _RoleCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return GlassPanel(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Icon(icon, color: scheme.primary),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: TextStyle(color: scheme.onSurfaceVariant),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
