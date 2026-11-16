import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/requests/presentation/requests_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> openNewRequestSheet(
  BuildContext context,
  String childId,
  String requestedBy,
) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (_) =>
        _NewRequestSheet(childId: childId, requestedBy: requestedBy),
  );
}

class _NewRequestSheet extends ConsumerStatefulWidget {
  const _NewRequestSheet({required this.childId, required this.requestedBy});

  final String childId;
  final String requestedBy;

  @override
  ConsumerState<_NewRequestSheet> createState() => _NewRequestSheetState();
}

class _NewRequestSheetState extends ConsumerState<_NewRequestSheet> {
  RequestType _type = RequestType.leave;
  DateTime? _date;
  final _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: now,
      lastDate: now.add(const Duration(days: 90)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _submit() async {
    final date = _date;
    if (date == null) return;
    await ref
        .read(requestsViewModelProvider.notifier)
        .submit(
          widget.childId,
          _type,
          date,
          note: _note.text.trim(),
          requestedBy: widget.requestedBy,
        );
    if (mounted) Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final date = _date;
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.fromLTRB(
          20,
          0,
          20,
          20 + MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.newRequestTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            SegmentedButton<RequestType>(
              segments: [
                ButtonSegment(
                  value: RequestType.leave,
                  label: Text(l10n.requestTypeLeave),
                ),
                ButtonSegment(
                  value: RequestType.extraHours,
                  label: Text(l10n.requestTypeExtraHours),
                ),
              ],
              selected: {_type},
              onSelectionChanged: (s) => setState(() => _type = s.first),
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: _pickDate,
              icon: const Icon(Icons.event),
              label: Text(
                date == null
                    ? l10n.pickDate
                    : MaterialLocalizations.of(context).formatMediumDate(date),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _note,
              minLines: 1,
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
              decoration: InputDecoration(
                hintText: l10n.noteOptionalHint,
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: date == null ? null : _submit,
                child: Text(l10n.submitRequest),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
