import 'package:daycheck/features/session/data/role.dart';

class Account {
  const Account({
    required this.username,
    required this.password,
    required this.displayName,
    required this.role,
  });

  final String username;
  final String password;

  /// For a parent this is also the guardian name on their children, which
  /// is how the parent home finds which children are theirs.
  final String displayName;
  final Role role;
}

/// Test accounts for the demo. A real app checks credentials on a server
/// and never ships passwords in the binary; these exist so every role and
/// family can be tried on one phone.
const demoAccounts = [
  Account(
    username: 'sara',
    password: 'sara123',
    displayName: 'Sara Bakker',
    role: Role.staff,
  ),
  Account(
    username: 'tim',
    password: 'tim123',
    displayName: 'Tim Visser',
    role: Role.staff,
  ),
  Account(
    username: 'amina',
    password: 'amina123',
    displayName: 'Amina El Amrani',
    role: Role.parent,
  ),
  Account(
    username: 'karim',
    password: 'karim123',
    displayName: 'Karim El Amrani',
    role: Role.parent,
  ),
  Account(
    username: 'sanne',
    password: 'sanne123',
    displayName: 'Sanne de Vries',
    role: Role.parent,
  ),
  Account(
    username: 'tom',
    password: 'tom123',
    displayName: 'Tom de Vries',
    role: Role.parent,
  ),
  Account(
    username: 'lotte',
    password: 'lotte123',
    displayName: 'Lotte Jansen',
    role: Role.parent,
  ),
];
