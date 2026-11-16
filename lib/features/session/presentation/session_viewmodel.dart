import 'package:daycheck/features/session/data/role.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Who is signed in. This is a demo stand-in for real authentication: no
/// password, no server, nothing persisted across app restarts. It exists
/// to gate what the roster and child detail screens show and allow, the
/// same way a real app would gate it after a real login.
class SessionState {
  const SessionState({this.role, this.guardianName});

  /// Null until someone has signed in.
  final Role? role;

  /// Set only when [role] is [Role.parent]: which guardian is signed in,
  /// so the roster can be filtered to their child or children.
  final String? guardianName;

  bool get signedIn => role != null;
}

class SessionViewModel extends Notifier<SessionState> {
  @override
  SessionState build() => const SessionState();

  void signInAsStaff() => state = const SessionState(role: Role.staff);

  void signInAsParent(String guardianName) =>
      state = SessionState(role: Role.parent, guardianName: guardianName);

  void signOut() => state = const SessionState();
}

final sessionViewModelProvider =
    NotifierProvider<SessionViewModel, SessionState>(SessionViewModel.new);
