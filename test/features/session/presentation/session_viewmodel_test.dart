import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_session_repository.dart';

void main() {
  late FakeSessionRepository repo;
  late ProviderContainer container;

  Future<void> start([String? saved]) async {
    repo = FakeSessionRepository(saved);
    container = ProviderContainer(
      overrides: [sessionRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
    container.read(sessionViewModelProvider);
    await Future<void>.delayed(Duration.zero);
  }

  test('nobody is signed in when nothing is saved', () async {
    await start();
    final s = container.read(sessionViewModelProvider);
    expect(s.signedIn, isFalse);
    expect(s.restoring, isFalse);
  });

  test('restores a saved session', () async {
    await start('amina');
    final s = container.read(sessionViewModelProvider);
    expect(s.role, Role.parent);
    expect(s.guardianName, 'Amina El Amrani');
  });

  test('a staff login has a name but no guardian name', () async {
    await start();
    final ok = await container
        .read(sessionViewModelProvider.notifier)
        .signIn(' Sara ', 'sara123');

    final s = container.read(sessionViewModelProvider);
    expect(ok, isTrue);
    expect(s.role, Role.staff);
    expect(s.displayName, 'Sara Bakker');
    expect(s.guardianName, isNull);
    expect(repo.username, 'sara');
  });

  test('a wrong password changes nothing', () async {
    await start();
    final ok = await container
        .read(sessionViewModelProvider.notifier)
        .signIn('sara', 'SARA123');

    expect(ok, isFalse);
    expect(container.read(sessionViewModelProvider).signedIn, isFalse);
    expect(repo.username, isNull);
  });

  test('signing out clears the saved session', () async {
    await start('tom');
    await container.read(sessionViewModelProvider.notifier).signOut();

    expect(container.read(sessionViewModelProvider).signedIn, isFalse);
    expect(repo.username, isNull);
  });
}
