import 'package:daycheck/features/session/data/account.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _usernameKey = 'signed_in_username';

/// Remembers who is signed in across app restarts. Only the username is
/// stored, never the password.
class SessionRepository {
  List<Account> get accounts => demoAccounts;

  Future<String?> loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_usernameKey);
  }

  Future<void> saveUsername(String? username) async {
    final prefs = await SharedPreferences.getInstance();
    if (username == null) {
      await prefs.remove(_usernameKey);
    } else {
      await prefs.setString(_usernameKey, username);
    }
  }
}
