import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/home/presentation/parent_home_screen.dart';
import 'package:daycheck/features/home/presentation/staff_home_screen.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/login_screen.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Picks the first screen from the session: login, the staff home or the
/// parent home. Signing in or out only changes the session; this widget
/// swaps the screen, so no screen has to navigate to another role's home.
class HomeGate extends ConsumerWidget {
  const HomeGate({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(sessionViewModelProvider);
    if (session.restoring) {
      return const Scaffold(
        body: GlassBackground(
          child: Center(child: CircularProgressIndicator()),
        ),
      );
    }
    return switch (session.role) {
      null => const LoginScreen(),
      Role.staff => const StaffHomeScreen(key: ValueKey('staff')),
      Role.parent => ParentHomeScreen(key: ValueKey(session.account!.username)),
    };
  }
}
