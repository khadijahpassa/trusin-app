class UserModel {
  final String name;
  final String email;
  final String role;
  final String phone;
  final String company;

  UserModel({
    required this.name,
    required this.email,
    required this.role,
    required this.phone,
    required this.company,
  });

  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      email: data['email'] ?? '',
      role: data['displayRole'] ?? '',
      phone: data['phone'] ?? '',
      company: data['company'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'displayRole': role,
      'phone': phone,
      'company': company,
    };
  }
}
