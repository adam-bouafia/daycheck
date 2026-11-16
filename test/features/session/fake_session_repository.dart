import 'package:daycheck/features/session/data/account.dart';
import 'package:daycheck/features/session/data/session_repository.dart';

class FakeSessionRepository implements SessionRepository {
  FakeSessionRepository([this.username]);

  String? username;

  @override
  List<Account> get accounts => demoAccounts;

  @override
  Future<String?> loadUsername() async => username;

  @override
  Future<void> saveUsername(String? value) async => username = value;
}
