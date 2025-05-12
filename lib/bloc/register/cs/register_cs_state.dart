abstract class RegisterCsState {}

class RegisterCsInitial extends RegisterCsState {}

class RegisterCsLoading extends RegisterCsState {}

class RegisterCsSuccess extends RegisterCsState {}

class RegisterCsFailure extends RegisterCsState {
  final String error;

  RegisterCsFailure({required this.error});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisterCsFailure && other.error == error);

  @override
  int get hashCode => error.hashCode;
}
