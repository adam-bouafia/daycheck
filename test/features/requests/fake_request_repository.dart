import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:daycheck/features/requests/data/request_repository.dart';

class FakeRequestRepository implements RequestRepository {
  List<LeaveRequest> requests = [];

  @override
  Future<List<LeaveRequest>> loadRequests() async => requests;

  @override
  Future<void> saveRequests(List<LeaveRequest> value) async => requests = value;
}
