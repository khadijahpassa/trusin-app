class CSModel {
  final String name;
  final String details;
  final String avatar;

  CSModel({required this.name, required this.details, this.avatar = 'assets/images/role_cs.png' });

  factory CSModel.fromMap(Map<String, dynamic> data) {
    return CSModel(
      name: data['name'] ?? '',
      details: data['details'] ?? '',
      avatar: data['avatar'] ?? 'assets/images/role_cs.png',
    );
  }
}
