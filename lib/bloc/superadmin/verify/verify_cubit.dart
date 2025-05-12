import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:trusin_app/bloc/superadmin/verify/verify_state.dart';


class VerifyCubit extends Cubit<VerifyState> {
  VerifyCubit() : super(VerifyInitial());

  List<CompanyRequest> _requests = [
    CompanyRequest(companyName: 'PT. Indotex', supervisor: 'Nama Supervisor', statusApproval: 'Pending'),

  ];

  List<CompanyRequest> get requests => _requests;

  void acceptRequest(int index) {
    _requests[index] = _requests[index].copyWith(statusApproval: 'Accepted');
    emit(VerifyUpdated(_requests));
  }

  void rejectRequest(int index) {
    _requests[index] = _requests[index].copyWith(statusApproval: 'Rejected');
    emit(VerifyUpdated(_requests));
  }
}

class CompanyRequest {
  final String companyName;
  final String supervisor;
  final String statusApproval;

  CompanyRequest({
    required this.companyName,
    required this.supervisor,
    required this.statusApproval,
  });

  CompanyRequest copyWith({String? companyName, String? supervisor, String? statusApproval}) {
    return CompanyRequest(
      companyName: companyName ?? this.companyName,
      supervisor: supervisor ?? this.supervisor,
      statusApproval: statusApproval ?? this.statusApproval,
    );
  }
}
