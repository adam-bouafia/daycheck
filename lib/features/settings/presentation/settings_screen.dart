import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:daycheck/features/settings/data/app_settings.dart';
import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/requests/presentation/requests_viewmodel.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _confirmReset(BuildContext context, WidgetRef ref) async {
    final l10n = context.l10n;
    final ok = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.resetDemo),
        content: Text(l10n.resetDemoHint),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.cancelRequest),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.resetDemo),
          ),
        ],
      ),
    );
    if (ok != true) return;
    await ref.read(rosterViewModelProvider.notifier).resetDemoData();
    await ref.read(requestsViewModelProvider.notifier).clearAll();
    await ref.read(inboxViewModelProvider.notifier).clearAll();
    if (context.mounted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(l10n.resetDemoDone)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsViewModelProvider);
    final vm = ref.read(settingsViewModelProvider.notifier);
    final signedIn = ref.watch(sessionViewModelProvider).signedIn;
    final text = Theme.of(context).textTheme;

    Widget section(String title, List<Widget> children) => Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: GlassPanel(
        radius: 16,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 4),
              child: Text(title, style: text.titleSmall),
            ),
            ...children,
          ],
        ),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: GlassBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(12),
            children: [
              section(l10n.languageLabel, [
                RadioGroup<String?>(
                  groupValue: settings.languageCode,
                  onChanged: vm.setLanguage,
                  child: Column(
                    children: [
                      RadioListTile<String?>(
                        value: null,
                        title: Text(l10n.languageSystem),
                      ),
                      for (final (code, name) in appLanguages)
                        RadioListTile<String?>(value: code, title: Text(name)),
                    ],
                  ),
                ),
              ]),
              section(l10n.themeLabel, [
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 4, 16, 14),
                  child: SegmentedButton<ThemeMode>(
                    segments: [
                      ButtonSegment(
                        value: ThemeMode.system,
                        icon: const Icon(Icons.brightness_auto),
                        label: Text(l10n.themeSystem),
                      ),
                      ButtonSegment(
                        value: ThemeMode.light,
                        icon: const Icon(Icons.light_mode),
                        label: Text(l10n.themeLight),
                      ),
                      ButtonSegment(
                        value: ThemeMode.dark,
                        icon: const Icon(Icons.dark_mode),
                        label: Text(l10n.themeDark),
                      ),
                    ],
                    selected: {settings.themeMode},
                    onSelectionChanged: (s) => vm.setThemeMode(s.single),
                  ),
                ),
                SwitchListTile(
                  value: settings.reduceEffects,
                  onChanged: vm.setReduceEffects,
                  title: Text(l10n.reduceEffectsLabel),
                  subtitle: Text(l10n.reduceEffectsHint),
                ),
              ]),
              section(l10n.inboxTitle, [
                SwitchListTile(
                  value: settings.activityPopups,
                  onChanged: vm.setActivityPopups,
                  title: Text(l10n.activityPopupsLabel),
                ),
                SwitchListTile(
                  value: settings.attendancePopups,
                  onChanged: vm.setAttendancePopups,
                  title: Text(l10n.attendancePopupsLabel),
                ),
                SwitchListTile(
                  value: settings.requestPopups,
                  onChanged: vm.setRequestPopups,
                  title: Text(l10n.requestPopupsLabel),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Text(l10n.popupsHint, style: text.bodySmall),
                ),
              ]),
              if (signedIn) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Text(
                    l10n.signedInAs(
                      ref.watch(sessionViewModelProvider).displayName,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                if (ref.watch(sessionViewModelProvider).role == Role.staff)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.restart_alt),
                      label: Text(l10n.resetDemo),
                      onPressed: () => _confirmReset(context, ref),
                    ),
                  ),
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.logout),
                  label: Text(l10n.signOutTooltip),
                  onPressed: () {
                    ref.read(sessionViewModelProvider.notifier).signOut();
                    Navigator.of(context).popUntil((r) => r.isFirst);
                  },
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
