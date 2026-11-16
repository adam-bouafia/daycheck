import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> openAbsentSheet(BuildContext context, Child child) =>
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (_) => _AbsentSheet(child: child),
    );

class _AbsentSheet extends ConsumerStatefulWidget {
  const _AbsentSheet({required this.child});

  final Child child;

  @override
  ConsumerState<_AbsentSheet> createState() => _AbsentSheetState();
}

class _AbsentSheetState extends ConsumerState<_AbsentSheet> {
  final _reason = TextEditingController();

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    await ref
        .read(rosterViewModelProvider.notifier)
        .markAbsent(
          widget.child.id,
          ref.read(sessionViewModelProvider).displayName,
          reason: _reason.text,
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Padding(
      padding: EdgeInsets.fromLTRB(
        20,
        0,
        20,
        20 + MediaQuery.viewInsetsOf(context).bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.markAbsentTitle(widget.child.name),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 4),
          Text(l10n.absentInformsGuardians),
          const SizedBox(height: 12),
          TextField(
            controller: _reason,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: l10n.absentReasonHint,
              border: const OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: FilledButton(onPressed: _save, child: Text(l10n.markAbsent)),
          ),
        ],
      ),
    );
  }
}
