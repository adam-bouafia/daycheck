import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import '../support.dart';

void main() {
  late FakeRosterRepository repo;
  late ProviderContainer container;

  setUp(() {
    repo = FakeRosterRepository();
    container = ProviderContainer(
      overrides: [rosterRepositoryProvider.overrideWithValue(repo)],
    );
    addTearDown(container.dispose);
  });

  test("loads the repository's children on first read", () async {
    container.read(rosterViewModelProvider);
    await Future<void>.delayed(Duration.zero);

    final state = container.read(rosterViewModelProvider);
    expect(state.children, hasLength(1));
    expect(state.children.first.name, 'Mila de Vries');
  });

  test('checking in adds an event and makes the child present', () async {
    container.read(rosterViewModelProvider);
    await Future<void>.delayed(Duration.zero);

    await container
        .read(rosterViewModelProvider.notifier)
        .checkIn('1', 'Sanne de Vries');

    final state = container.read(rosterViewModelProvider);
    expect(state.statusOf('1'), DayStatus.present);
    expect(repo.events, hasLength(1));
    expect(repo.events.single.by, 'Sanne de Vries');
  });

  test('checking out after checking in makes the child departed', () async {
    final notifier = container.read(rosterViewModelProvider.notifier);
    await Future<void>.delayed(Duration.zero);

    await notifier.checkIn('1', 'Sanne de Vries');
    await notifier.checkOut('1', 'Tom de Vries');

    final state = container.read(rosterViewModelProvider);
    expect(state.statusOf('1'), DayStatus.departed);
    expect(state.eventsOf('1'), hasLength(2));
  });
}
