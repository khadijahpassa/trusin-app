abstract class RegisterSupervisorEvent {}

class RegisterSupervisorSubmitted extends RegisterSupervisorEvent {
  final String name;
  final String email;
  final String phone;
  final String company;
  final String companyType;
  final String username;
  final String password;
  final String displayRole;

  RegisterSupervisorSubmitted({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.companyType,
    required this.username,
    required this.password,
    required this.displayRole,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisterSupervisorSubmitted &&
          other.name == name &&
          other.email == email &&
          other.phone == phone &&
          other.company == company &&
          other.companyType == companyType &&
          other.username == username &&
          other.password == password &&
          other.displayRole == displayRole);

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      company.hashCode ^
      companyType.hashCode ^
      username.hashCode ^
      password.hashCode ^
      displayRole.hashCode;
}
