import 'package:daycheck/features/session/data/account.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/data/session_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI seam: tests override this with a fake repository.
final sessionRepositoryProvider = Provider<SessionRepository>(
  (ref) => SessionRepository(),
);

class SessionState {
  const SessionState({this.account, this.restoring = false});

  /// Null when nobody is signed in.
  final Account? account;

  /// True while the saved session is read at startup, so the app shows a
  /// spinner instead of flashing the login screen.
  final bool restoring;

  Role? get role => account?.role;
  bool get signedIn => account != null;
  String get displayName => account?.displayName ?? '';

  /// The name on a parent's children; null for staff.
  String? get guardianName =>
      account?.role == Role.parent ? account!.displayName : null;
}

class SessionViewModel extends Notifier<SessionState> {
  SessionRepository get _repo => ref.read(sessionRepositoryProvider);

  @override
  SessionState build() {
    _restore();
    return const SessionState(restoring: true);
  }

  Future<void> _restore() async {
    final username = await _repo.loadUsername();
    if (!state.restoring) return;
    state = SessionState(account: _find(username));
  }

  Account? _find(String? username) {
    for (final a in _repo.accounts) {
      if (a.username == username) return a;
    }
    return null;
  }

  /// Returns false, and changes nothing, when the username or password is
  /// wrong. The username is case-insensitive; the password is not.
  Future<bool> signIn(String username, String password) async {
    final account = _find(username.trim().toLowerCase());
    if (account == null || account.password != password) return false;
    state = SessionState(account: account);
    await _repo.saveUsername(account.username);
    return true;
  }

  Future<void> signOut() async {
    state = const SessionState();
    await _repo.saveUsername(null);
  }
}

final sessionViewModelProvider =
    NotifierProvider<SessionViewModel, SessionState>(SessionViewModel.new);
