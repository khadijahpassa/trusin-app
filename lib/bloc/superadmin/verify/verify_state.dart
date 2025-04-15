import 'package:trusin_app/bloc/superadmin/verify/verify_cubit.dart';

abstract class VerifyState {}

class VerifyInitial extends VerifyState {}

class VerifyUpdated extends VerifyState {
  final List<CompanyRequest> requests;
  VerifyUpdated(this.requests);
}
