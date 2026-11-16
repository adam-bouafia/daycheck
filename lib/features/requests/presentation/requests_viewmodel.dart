import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/inbox/data/inbox_item.dart';
import 'package:daycheck/features/inbox/presentation/inbox_viewmodel.dart';
import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/requests/data/request_repository.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
import 'package:daycheck/l10n/app_localizations.dart';
import 'package:daycheck/features/settings/presentation/settings_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// DI seam: tests override this with a fake repository.
final requestRepositoryProvider = Provider<RequestRepository>(
  (ref) => RequestRepository(),
);

/// Holds every leave/extra-hours request. Unlike the roster's event log,
/// a request has a state that transitions - [submit] creates it
/// `pending`, [approve]/[cancel] move it to a final state - so it's
/// stored and updated in place, not appended to forever.
class RequestsViewModel extends Notifier<List<LeaveRequest>> {
  RequestRepository get _repo => ref.read(requestRepositoryProvider);

  @override
  List<LeaveRequest> build() {
    _load();
    return const [];
  }

  Future<void> _load() async {
    state = await _repo.loadRequests();
  }

  Future<void> submit(
    String childId,
    RequestType type,
    DateTime date, {
    String note = '',
    required String requestedBy,
  }) async {
    final request = LeaveRequest(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      childId: childId,
      type: type,
      date: date,
      note: note,
      requestedBy: requestedBy,
      requestedAt: DateTime.now(),
    );
    state = [...state, request];
    await _repo.saveRequests(state);

    final l10n = localizationsFor(
      ref.read(settingsViewModelProvider).languageCode,
    );
    final title = switch (type) {
      RequestType.leave => l10n.newLeaveRequestTitle(_nameOf(childId)),
      RequestType.extraHours => l10n.newExtraHoursRequestTitle(
        _nameOf(childId),
      ),
    };
    await _notify(
      title,
      l10n.requestedBy(requestedBy),
      childId,
      forStaff: true,
    );
  }

  Future<void> approve(String requestId) =>
      _setStatus(requestId, RequestStatus.approved, (l10n, name) {
        return l10n.requestApprovedNotificationTitle(name);
      });

  Future<void> cancel(String requestId) =>
      _setStatus(requestId, RequestStatus.cancelled, (l10n, name) {
        return l10n.requestCancelledNotificationTitle(name);
      });

  /// Demo only.
  Future<void> clearAll() async {
    state = const [];
    await _repo.saveRequests(state);
  }

  String _nameOf(String childId) => ref
      .read(rosterViewModelProvider)
      .children
      .firstWhere((c) => c.id == childId)
      .name;

  Future<void> _setStatus(
    String requestId,
    RequestStatus status,
    String Function(AppLocalizations l10n, String childName) titleFor,
  ) async {
    final request = state.firstWhere((r) => r.id == requestId);
    state = [
      for (final r in state)
        if (r.id == requestId) r.copyWith(status: status) else r,
    ];
    await _repo.saveRequests(state);

    final l10n = localizationsFor(
      ref.read(settingsViewModelProvider).languageCode,
    );
    final title = titleFor(l10n, _nameOf(request.childId));
    await _notify(title, '', request.childId, forStaff: false);
  }

  /// A new request is for staff to act on; a decision is news for the
  /// family, made by staff, so it stays out of the staff list.
  Future<void> _notify(
    String title,
    String body,
    String childId, {
    required bool forStaff,
  }) async {
    if (ref.read(settingsViewModelProvider).requestPopups) {
      await ref
          .read(notificationServiceProvider)
          .showActivityNotification(title, body);
    }
    await ref
        .read(inboxViewModelProvider.notifier)
        .add(
          title,
          body,
          childId: childId,
          forStaff: forStaff,
          link: InboxLink.request,
        );
  }
}

final requestsViewModelProvider =
    NotifierProvider<RequestsViewModel, List<LeaveRequest>>(
      RequestsViewModel.new,
    );
