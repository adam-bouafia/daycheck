import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DailyLogScreen extends ConsumerWidget {
  const DailyLogScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(rosterViewModelProvider);
    final events = [...state.events]..sort((a, b) => b.at.compareTo(a.at));
    final names = {for (final c in state.children) c.id: c.name};
    return Scaffold(
      appBar: AppBar(title: const Text('Today\'s log')),
      body: events.isEmpty
          ? const Center(child: Text('Nothing checked in or out yet today.'))
          : ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                final event = events[index];
                final time = TimeOfDay.fromDateTime(event.at);
                return ListTile(
                  leading: Icon(
                    event.kind.name == 'checkIn' ? Icons.login : Icons.logout,
                  ),
                  title: Text(names[event.childId] ?? 'Unknown child'),
                  subtitle: Text(
                    '${event.kind.name == 'checkIn' ? 'Checked in' : 'Checked out'} by ${event.by}',
                  ),
                  trailing: Text(
                    '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}',
                  ),
                );
              },
            ),
    );
  }
}
