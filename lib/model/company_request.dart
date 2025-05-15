class CompanyRequest {
  final String id;
  final String companyName;
  final String supervisorName;
  final String status;
  final String email;
  final String phone;
  final String alamat;

  CompanyRequest({
    required this.id,
    required this.companyName,
    required this.supervisorName,
    required this.status,
    required this.email,
    required this.phone,
    required this.alamat,
  });

  factory CompanyRequest.fromMap(Map<String, dynamic> data, String id) {
    return CompanyRequest(
      id: id,
      companyName: data['company'] ?? '',        
      supervisorName: data['name'] ?? '',  
      status: (data['status'] ?? '').toLowerCase() ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      alamat: data['address'] ?? '',
    );
  }
}
