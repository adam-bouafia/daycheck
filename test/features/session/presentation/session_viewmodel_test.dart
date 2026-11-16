import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
    addTearDown(container.dispose);
  });

  test('nobody is signed in to start with', () {
    final state = container.read(sessionViewModelProvider);
    expect(state.signedIn, isFalse);
    expect(state.role, isNull);
  });

  test('signing in as staff carries no guardian name', () {
    container.read(sessionViewModelProvider.notifier).signInAsStaff();

    final state = container.read(sessionViewModelProvider);
    expect(state.role, Role.staff);
    expect(state.guardianName, isNull);
  });

  test('signing in as a parent records which guardian', () {
    container
        .read(sessionViewModelProvider.notifier)
        .signInAsParent('Sanne de Vries');

    final state = container.read(sessionViewModelProvider);
    expect(state.role, Role.parent);
    expect(state.guardianName, 'Sanne de Vries');
  });

  test('signing out clears the role', () {
    final notifier = container.read(sessionViewModelProvider.notifier);
    notifier.signInAsStaff();
    notifier.signOut();

    expect(container.read(sessionViewModelProvider).signedIn, isFalse);
  });
}
