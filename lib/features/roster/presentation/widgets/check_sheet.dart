import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/data/day_status.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Picks a guardian, then checks a child in or out as that guardian.
Future<void> openCheckSheet(
  BuildContext context,
  Child child,
  DayStatus current,
) async {
  await showModalBottomSheet<void>(
    context: context,
    showDragHandle: true,
    builder: (_) =>
        _CheckSheet(child: child, checkingIn: current != DayStatus.present),
  );
}

class _CheckSheet extends ConsumerStatefulWidget {
  const _CheckSheet({required this.child, required this.checkingIn});

  final Child child;
  final bool checkingIn;

  @override
  ConsumerState<_CheckSheet> createState() => _CheckSheetState();
}

class _CheckSheetState extends ConsumerState<_CheckSheet> {
  String? _guardian;

  @override
  void initState() {
    super.initState();
    _guardian = widget.child.guardians.first;
  }

  Future<void> _confirm() async {
    final guardian = _guardian;
    if (guardian == null) return;
    final notifier = ref.read(rosterViewModelProvider.notifier);
    if (widget.checkingIn) {
      await notifier.checkIn(widget.child.id, guardian);
    } else {
      await notifier.checkOut(widget.child.id, guardian);
    }
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.checkingIn
                  ? 'Check in ${widget.child.name}'
                  : 'Check out ${widget.child.name}',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              widget.checkingIn ? 'Dropped off by' : 'Picked up by',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            RadioGroup<String>(
              groupValue: _guardian,
              onChanged: (value) => setState(() => _guardian = value),
              child: Column(
                children: [
                  for (final guardian in widget.child.guardians)
                    RadioListTile<String>(
                      contentPadding: EdgeInsets.zero,
                      value: guardian,
                      title: Text(guardian),
                    ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _confirm,
                child: Text(widget.checkingIn ? 'Check in' : 'Check out'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
