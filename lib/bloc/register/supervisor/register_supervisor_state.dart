abstract class RegisterSupervisorState {}

class RegisterSupervisorInitial extends RegisterSupervisorState {}

class RegisterSupervisorLoading extends RegisterSupervisorState {}

class RegisterSupervisorSuccess extends RegisterSupervisorState {}

class RegisterSupervisorFailure extends RegisterSupervisorState {
  final String error;

  RegisterSupervisorFailure({required this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisterSupervisorFailure && other.error == error);

  @override
  int get hashCode => error.hashCode;
}
