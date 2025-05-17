class CSModel {
  final String id;
  final String displayRole;
  final String name;
  final String email;
  final String phone;
  final String avatar;  

  CSModel( {
    required this.id,
    required this.displayRole,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar = 'assets/images/role_cs.png',
  });

  factory CSModel.fromMap(Map<String, dynamic> data) {
    return CSModel(
      
      id: data['id'] ?? '-',
      displayRole: data['displayRole'] ?? '-', 
      name: data['name'] ?? '-', 
      email: data['email'] ?? '-', 
      phone: data['phone'] ?? '-',
      avatar: data['avatar'] ?? 'assets/images/role_cs.png',
    );
  }
}
