import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:daycheck/features/session/presentation/sign_in_screen.dart';
import 'package:daycheck/features/settings/data/app_settings.dart';
import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final settings = ref.watch(settingsViewModelProvider);
    final vm = ref.read(settingsViewModelProvider.notifier);
    final signedIn = ref.watch(sessionViewModelProvider).role != null;
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
      appBar: AppBar(title: Text(l10n.settingsTitle)),
      body: GlassBackground(
        child: SafeArea(
          top: false,
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
                  value: settings.requestPopups,
                  onChanged: vm.setRequestPopups,
                  title: Text(l10n.requestPopupsLabel),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 14),
                  child: Text(l10n.popupsHint, style: text.bodySmall),
                ),
              ]),
              if (signedIn)
                FilledButton.tonalIcon(
                  icon: const Icon(Icons.logout),
                  label: Text(l10n.signOutTooltip),
                  onPressed: () {
                    ref.read(sessionViewModelProvider.notifier).signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                      (_) => false,
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
