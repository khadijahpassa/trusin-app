class ProductModel {
  final String id;
  final String name;
  final int quantity;
  final int price;
  final String descProduct;
  final int discount;
  final String handledBy; // tambahkan ini

  ProductModel({
    required this.id,
    required this.name,
    required this.quantity,
    required this.price,
    required this.descProduct,
    required this.discount,
    required this.handledBy, // wajib di constructor
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'quantity': quantity,
      'price': price,
      'descProduct': descProduct,
      'discount': discount,
      'handledBy': handledBy,
    };
  }

  factory ProductModel.fromFirestore(String id, Map<String, dynamic> data) {
    return ProductModel(
      id: id,
      name: data['name'],
      quantity: data['quantity'],
      price: data['price'],
      descProduct: data['descProduct'],
      discount: data['discount'],
      handledBy: data['handledBy'],
    );
  }

  ProductModel copyWith({
    String? id,
    String? name,
    int? quantity,
    int? price,
    String? descProduct,
    int? discount,
    String? handledBy,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      descProduct: descProduct ?? this.descProduct,
      discount: discount ?? this.discount,
      handledBy: handledBy ?? this.handledBy,
    );
  }
}