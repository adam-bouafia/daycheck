import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/core/widgets/glass.dart';
import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/requests/presentation/requests_viewmodel.dart';
import 'package:daycheck/features/requests/presentation/widgets/new_request_sheet.dart';
import 'package:daycheck/features/roster/data/child.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/features/session/data/role.dart';
import 'package:daycheck/features/session/presentation/session_viewmodel.dart';
import 'package:daycheck/core/widgets/settings_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RequestsScreen extends ConsumerWidget {
  const RequestsScreen({super.key});

  Future<void> _newRequest(
    BuildContext context,
    WidgetRef ref,
    List<Child> myChildren,
    String guardianName,
  ) async {
    final child = myChildren.length == 1
        ? myChildren.first
        : await showDialog<Child>(
            context: context,
            builder: (context) => SimpleDialog(
              children: [
                for (final c in myChildren)
                  SimpleDialogOption(
                    onPressed: () => Navigator.pop(context, c),
                    child: Text(c.name),
                  ),
              ],
            ),
          );
    if (child == null || !context.mounted) return;
    await openNewRequestSheet(context, child.id, guardianName);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final session = ref.watch(sessionViewModelProvider);
    final isStaff = session.role == Role.staff;
    final roster = ref.watch(rosterViewModelProvider);
    final myChildren = isStaff
        ? roster.children
        : roster.children
              .where((c) => c.guardians.contains(session.guardianName))
              .toList();
    final myChildIds = myChildren.map((c) => c.id).toSet();
    final names = {for (final c in roster.children) c.id: c.name};

    final requests = [...ref.watch(requestsViewModelProvider)]
      ..sort((a, b) => b.requestedAt.compareTo(a.requestedAt));
    final visible = isStaff
        ? requests
        : requests.where((r) => myChildIds.contains(r.childId)).toList();

    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text(l10n.requestsTitle),
        actions: const [SettingsButton()],
      ),
      floatingActionButton: isStaff || myChildren.isEmpty
          ? null
          : FloatingActionButton(
              onPressed: () => _newRequest(
                context,
                ref,
                myChildren,
                session.guardianName ?? '',
              ),
              child: const Icon(Icons.add),
            ),
      body: GlassBackground(
        child: SafeArea(
          child: visible.isEmpty
              ? Center(child: Text(l10n.noRequestsYet))
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: visible.length,
                  itemBuilder: (context, index) => _RequestTile(
                    request: visible[index],
                    childName:
                        names[visible[index].childId] ?? l10n.unknownChild,
                    canApprove: isStaff,
                    canCancel:
                        isStaff || myChildIds.contains(visible[index].childId),
                  ),
                ),
        ),
      ),
    );
  }
}

class _RequestTile extends ConsumerWidget {
  const _RequestTile({
    required this.request,
    required this.childName,
    required this.canApprove,
    required this.canCancel,
  });

  final LeaveRequest request;
  final String childName;
  final bool canApprove;
  final bool canCancel;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final scheme = Theme.of(context).colorScheme;
    final (statusLabel, statusColor) = switch (request.status) {
      RequestStatus.pending => (l10n.requestStatusPending, scheme.tertiary),
      RequestStatus.approved => (l10n.requestStatusApproved, scheme.primary),
      RequestStatus.cancelled => (
        l10n.requestStatusCancelled,
        scheme.onSurfaceVariant,
      ),
    };
    final typeIcon = request.type == RequestType.leave
        ? Icons.beach_access_outlined
        : Icons.schedule_outlined;
    final typeLabel = request.type == RequestType.leave
        ? l10n.requestTypeLeave
        : l10n.requestTypeExtraHours;
    final pending = request.status == RequestStatus.pending;

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: GlassPanel(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(typeIcon, color: scheme.primary),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '$typeLabel · $childName',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                        Text(
                          MaterialLocalizations.of(context)
                              .formatMediumDate(request.date),
                          style: TextStyle(color: scheme.onSurfaceVariant),
                        ),
                      ],
                    ),
                  ),
                  Chip(
                    label: Text(statusLabel),
                    backgroundColor: statusColor.withValues(alpha: 0.12),
                    labelStyle: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.w600,
                    ),
                    side: BorderSide.none,
                  ),
                ],
              ),
              if (request.note.isNotEmpty) ...[
                const SizedBox(height: 6),
                Text(request.note),
              ],
              const SizedBox(height: 4),
              Text(
                l10n.requestedBy(request.requestedBy),
                style: TextStyle(color: scheme.onSurfaceVariant, fontSize: 12),
              ),
              if (pending && (canApprove || canCancel)) ...[
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    if (canCancel)
                      TextButton(
                        onPressed: () => ref
                            .read(requestsViewModelProvider.notifier)
                            .cancel(request.id),
                        child: Text(l10n.cancelRequest),
                      ),
                    if (canApprove)
                      FilledButton(
                        onPressed: () => ref
                            .read(requestsViewModelProvider.notifier)
                            .approve(request.id),
                        child: Text(l10n.approve),
                      ),
                  ],
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
