import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
import 'package:daycheck/features/session/data/account.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _username = TextEditingController();
  final _password = TextEditingController();
  bool _hidePassword = true;
  bool _failed = false;
  bool _busy = false;

  @override
  void dispose() {
    _username.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _signIn() async {
    setState(() => _busy = true);
    final ok = await ref
        .read(sessionViewModelProvider.notifier)
        .signIn(_username.text, _password.text);
    if (!mounted) return;
    setState(() {
      _busy = false;
      _failed = !ok;
    });
  }

  void _fill(Account account) => setState(() {
    _username.text = account.username;
    _password.text = account.password;
    _failed = false;
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;
    final accounts = ref.read(sessionRepositoryProvider).accounts;

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(actions: const [SettingsButton()]),
      body: GlassBackground(
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
            children: [
              Icon(Icons.child_care, size: 56, color: scheme.primary),
              const SizedBox(height: 8),
              Text(
                'DayCheck',
                textAlign: TextAlign.center,
                style: text.headlineMedium,
              ),
              Text(
                l10n.loginSubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 20),
              GlassPanel(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: AutofillGroup(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        TextField(
                          key: const Key('username'),
                          controller: _username,
                          autofillHints: const [AutofillHints.username],
                          textInputAction: TextInputAction.next,
                          autocorrect: false,
                          decoration: InputDecoration(
                            labelText: l10n.usernameLabel,
                            prefixIcon: const Icon(Icons.person_outline),
                          ),
                        ),
                        const SizedBox(height: 12),
                        TextField(
                          key: const Key('password'),
                          controller: _password,
                          obscureText: _hidePassword,
                          autofillHints: const [AutofillHints.password],
                          onSubmitted: (_) => _signIn(),
                          decoration: InputDecoration(
                            labelText: l10n.passwordLabel,
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _hidePassword
                                    ? Icons.visibility_outlined
                                    : Icons.visibility_off_outlined,
                              ),
                              onPressed: () => setState(
                                () => _hidePassword = !_hidePassword,
                              ),
                            ),
                          ),
                        ),
                        if (_failed) ...[
                          const SizedBox(height: 10),
                          Text(
                            l10n.loginFailed,
                            style: TextStyle(color: scheme.error),
                          ),
                        ],
                        const SizedBox(height: 16),
                        FilledButton(
                          onPressed: _busy ? null : _signIn,
                          child: Text(l10n.signInButton),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Text(l10n.demoAccountsTitle, style: text.titleSmall),
              Text(
                l10n.demoAccountsHint,
                style: text.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
              ),
              const SizedBox(height: 8),
              GlassPanel(
                radius: 16,
                child: Column(
                  children: [
                    for (final a in accounts)
                      ListTile(
                        leading: Icon(
                          a.role == Role.staff
                              ? Icons.badge_outlined
                              : Icons.family_restroom_outlined,
                          color: scheme.primary,
                        ),
                        title: Text(a.displayName),
                        subtitle: Text(
                          '${a.role == Role.staff ? l10n.roleStaff : l10n.roleParent}'
                          ' · ${a.username} / ${a.password}',
                        ),
                        onTap: () => _fill(a),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
