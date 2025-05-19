class UserModel {
  final String name;
  final String username;
  final String email;
  final String role;
  final String phone;
  final String company;

  UserModel({
    required this.name,
    required this.username,
    required this.email,
    required this.role,
    required this.phone,
    required this.company,
  });

  UserModel copyWith({
    String? name,
    String? username,
    String? email,
    String? role,
    String? phone,
    String? company,
  }) {
    return UserModel(
      name: name ?? this.name,
      username: username ?? this.username,
      email: email ?? this.email,
      role: role ?? this.role,
      phone: phone ?? this.phone,
      company: company ?? this.company,
    );
  }


  factory UserModel.fromMap(Map<String, dynamic> data) {
    return UserModel(
      name: data['name'] ?? '',
      username: data['username'] ?? '',
      email: data['email'] ?? '',
      role: data['displayRole'] ?? '',
      phone: data['phone'] ?? '',
      company: data['company'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'username': username,
      'email': email,
      'displayRole': role,
      'phone': phone,
      'company': company,
    };
  }
}
