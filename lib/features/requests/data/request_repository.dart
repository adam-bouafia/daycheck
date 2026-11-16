import 'dart:convert';

import 'package:daycheck/features/requests/data/leave_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _requestsKey = 'leave_requests';

class RequestRepository {
  Future<List<LeaveRequest>> loadRequests() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(_requestsKey) ?? [];
    return raw
        .map(
          (s) => LeaveRequest.fromJson(jsonDecode(s) as Map<String, dynamic>),
        )
        .toList();
  }

  Future<void> saveRequests(List<LeaveRequest> requests) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _requestsKey,
      requests.map((r) => jsonEncode(r.toJson())).toList(),
    );
  }
}
