import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/settings/presentation/settings_screen.dart';
import 'package:flutter/material.dart';

class SettingsButton extends StatelessWidget {
  const SettingsButton({super.key});

  @override
  Widget build(BuildContext context) => IconButton(
    tooltip: context.l10n.settingsTitle,
    icon: const Icon(Icons.settings_outlined),
    onPressed: () => Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const SettingsScreen()),
    ),
  );
}
