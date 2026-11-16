import 'package:daycheck/core/localization/app_locale.dart';
import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/requests/data/request_repository.dart';
import 'package:daycheck/features/roster/presentation/roster_viewmodel.dart';
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

    final childName = ref
        .read(rosterViewModelProvider)
        .children
        .firstWhere((c) => c.id == childId)
        .name;
    final l10n = deviceLocalizations();
    final title = switch (type) {
      RequestType.leave => l10n.newLeaveRequestTitle(childName),
      RequestType.extraHours => l10n.newExtraHoursRequestTitle(childName),
    };
    await ref
        .read(notificationServiceProvider)
        .showActivityNotification(title, l10n.requestedBy(requestedBy));
  }

  Future<void> approve(String requestId) =>
      _setStatus(requestId, RequestStatus.approved);

  Future<void> cancel(String requestId) =>
      _setStatus(requestId, RequestStatus.cancelled);

  Future<void> _setStatus(String requestId, RequestStatus status) async {
    state = [
      for (final r in state)
        if (r.id == requestId) r.copyWith(status: status) else r,
    ];
    await _repo.saveRequests(state);
  }
}

final requestsViewModelProvider =
    NotifierProvider<RequestsViewModel, List<LeaveRequest>>(
      RequestsViewModel.new,
    );
