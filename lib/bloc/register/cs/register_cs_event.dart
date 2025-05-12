abstract class RegisterCsEvent {}

class RegisterCsSubmitted extends RegisterCsEvent {
  final String name;
  final String email;
  final String phone;
  final String company;
  final String username;
  final String password;

  RegisterCsSubmitted({
    required this.name,
    required this.email,
    required this.phone,
    required this.company,
    required this.username,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RegisterCsSubmitted &&
          other.name == name &&
          other.email == email &&
          other.phone == phone &&
          other.company == company &&
          other.username == username &&
          other.password == password);

  @override
  int get hashCode =>
      name.hashCode ^
      email.hashCode ^
      phone.hashCode ^
      company.hashCode ^
      username.hashCode ^
      password.hashCode;
}
