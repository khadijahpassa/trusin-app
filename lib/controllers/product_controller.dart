import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:trusin_app/models/product_model.dart';

class ProductController extends GetxController {
  final productList = <ProductModel>[].obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    final snapshot = await _firestore.collection('products').get();
    final data = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.id, doc.data()))
        .toList();

    productList.assignAll(data);
  }

   // Fungsi untuk mengambil produk dari Firestore
  void fetchProductsByQuotationId(String quotationId) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('handledBy', isEqualTo: quotationId)
        .get();

    productList.value = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.id, doc.data()))
        .toList();
  } catch (e) {
    print('Error fetching filtered products: $e');
  }
}

   Future<void> addProduct(ProductModel product) async {
  final doc = await _firestore.collection('products').add(product.toMap());

  productList.add(ProductModel(
    id: doc.id,
    name: product.name,
    quantity: product.quantity,
    price: product.price,
    descProduct: product.descProduct,
    discount: product.discount,
    handledBy: product.handledBy,
  ));
}


 Future<void> updateProduct(ProductModel updatedProduct) async {
  final index = productList.indexWhere((p) => p.id == updatedProduct.id);
  if (index != -1) {
    productList[index] = updatedProduct;
    productList.refresh(); 
  }
}


  Future<void> deleteProduct(String id) async {
    await _firestore.collection('products').doc(id).delete();
    productList.removeWhere((p) => p.id == id);
  }

int getTotalQuantity(List<ProductModel> products) {
    return products.fold(0, (sum, item) => sum + item.quantity);
  }

  int getTotalPrice(List<ProductModel> products) {
  return products.fold(0, (sum, item) {
    final priceAfterDiscount =
        item.price * item.quantity * (1 - (item.discount / 100));
    return sum + priceAfterDiscount.round();
  });
}

void reset() {
  productList.clear();
}

  
  
}