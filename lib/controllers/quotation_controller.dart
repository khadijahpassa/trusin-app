import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'dart:ui' as ui;
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/rendering.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';

import 'package:trusin_app/models/product_model.dart';
import 'package:trusin_app/models/quotation_model.dart';
import 'package:trusin_app/ui/customer-services/quotation/quotation-screen/components/calendar.dart';

class QuotationController extends GetxController {
  RxList<ProductModel> productList = <ProductModel>[].obs;
  var quotationList = <QuotationModel>[].obs;
  final currentQuotationId = ''.obs;


  final collection = FirebaseFirestore.instance.collection('products');
  final GlobalKey previewContainerKey = GlobalKey();

  final fromCompany = TextEditingController();
  final fromNumber = TextEditingController();
  final fromSocial = TextEditingController();
  final fromAddress = TextEditingController();
  final toCompany = TextEditingController();
  final toSeller = TextEditingController();
  final toNumber = TextEditingController();
  final bank = TextEditingController();
  final receiver = TextEditingController();
  final rekening = TextEditingController();
  final terms = TextEditingController();
  final products = TextEditingController();

  Rxn<File> logoImage = Rxn<File>();
  var selectedDate = Rx<DateTime?>(null);
  var formattedDate = RxString('');

  var selectedDateTime = DateTime.now().obs;
  var selectedCategory = "Follow Up".obs;

  @override
  void onInit() {
    super.onInit();
    fetchProductsForQuotation(currentQuotationId.value);
  }

 Future<void> submitQuotationToFirebase() async {
  try {
    final docRef = FirebaseFirestore.instance.collection('quotation').doc();
    final quotation = getQuotationModel(id: docRef.id);

    await docRef.set(quotation.toMap());

    // simpan ID quotation ke variable
    currentQuotationId.value = docRef.id;

    await saveProductsToQuotation(docRef.id);

    print('Quotation dan produk berhasil disimpan dengan ID: ${docRef.id}');
  } catch (e) {
    print('Gagal menyimpan quotation: $e');
  }
}


  Future<void> saveProductsToQuotation(String quotationId) async {
    for (var product in productList) {
      await FirebaseFirestore.instance.collection('products').add({
        ...product.toMap(),
        'handledBy': quotationId,
      });
    }
  }

  QuotationModel getQuotationModel({required String id}) {
    return QuotationModel(
      id: id,
      fromCompany: fromCompany.text,
      fromPhone: fromNumber.text,
      fromSocialMedia: fromSocial.text,
      fromAddress: fromAddress.text,
      toCompany: toCompany.text,
      toSeller: toSeller.text,
      toPhone: toNumber.text,
      terms: terms.text,
      bank: bank.text,
      receiver: receiver.text,
      rekening: rekening.text,
      logoImagePath: logoImage.value?.path,
      selectedDate: selectedDate.value,
    );
  }

  Future<Uint8List?> captureImage(GlobalKey previewContainer) async {
    try {
      final boundary = previewContainer.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;

      if (boundary == null || boundary.debugNeedsPaint) {
        await Future.delayed(const Duration(milliseconds: 100));
        return captureImage(previewContainer);
      }

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      return byteData?.buffer.asUint8List();
    } catch (e) {
      print('❌ Gagal mengambil gambar: $e');
      return null;
    }
  }

  Future<void> downloadQuotationAsPDF(
      GlobalKey previewContainer, QuotationModel quotation) async {
    try {
      final imageBytes = await captureImage(previewContainer);
      if (imageBytes == null) return;

      final pdf = pw.Document();
      final image = pw.MemoryImage(imageBytes);

      pdf.addPage(
        pw.Page(
          pageFormat: PdfPageFormat.a4,
          build: (pw.Context context) => pw.Center(child: pw.Image(image)),
        ),
      );

      final dateStr = quotation.selectedDate != null
          ? "${quotation.selectedDate!.year}-${quotation.selectedDate!.month.toString().padLeft(2, '0')}-${quotation.selectedDate!.day.toString().padLeft(2, '0')}"
          : "no_date";

      final fileName =
          "${quotation.toSeller}_${dateStr}_quotation.pdf".replaceAll(' ', '_');

      final directory = await getApplicationDocumentsDirectory();
      final filePath = '${directory.path}/$fileName';
      final file = File(filePath);
      await file.writeAsBytes(await pdf.save());

      Get.snackbar('Berhasil', 'Quotation disimpan sebagai PDF');
      await OpenFile.open(filePath);
    } catch (e) {
      print('❌ Error simpan PDF: $e');
      Get.snackbar('Error', 'Gagal menyimpan PDF: $e');
    }
  }

  Future<void> shareQuotationAsPDF(
      Uint8List imageBytes, String fileName) async {
    final pdf = pw.Document();
    final image = pw.MemoryImage(imageBytes);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) =>
            pw.Center(child: pw.Image(image, fit: pw.BoxFit.contain)),
      ),
    );

    await Printing.sharePdf(bytes: await pdf.save(), filename: fileName);
  }

  void reset() {
    fromCompany.clear();
    fromNumber.clear();
    fromSocial.clear();
    fromAddress.clear();
    toCompany.clear();
    toSeller.clear();
    toNumber.clear();
    terms.clear();
    bank.clear();
    receiver.clear();
    rekening.clear();
    logoImage.value = null;
    selectedDate.value = null;
    selectedDateTime.value = DateTime.now();
    selectedCategory.value = "Follow Up";
  }

  Future<void> fetchProductsForQuotation(String quotationId) async {
  try {
    final snapshot = await FirebaseFirestore.instance
        .collection('products')
        .where('handledBy', isEqualTo: quotationId)
        .get();

    productList.value = snapshot.docs
        .map((doc) => ProductModel.fromFirestore(doc.id, doc.data()))
        .toList();
  } catch (e) {
    print('Error fetching products for quotation: $e');
  }
}


  void addProduct({
  required String name,
  required int quantity,
  required int price,
  required String descProduct,
  required int discount,
  required String handledBy, // tambah parameter handledBy
}) {
  final newProduct = ProductModel(
    id: '',
    name: name,
    quantity: quantity,
    price: price,
    descProduct: descProduct,
    discount: discount,
    handledBy: handledBy, // set handledBy di sini
  );
  productList.add(newProduct);
}


  void deleteProduct(String id) async {
  try {
    await FirebaseFirestore.instance.collection('products').doc(id).delete();
    productList.removeWhere((product) => product.id == id);
  } catch (e) {
    print('❌ Gagal menghapus produk: $e');
  }
}

void editProduct(String id, ProductModel updatedProduct) async {
  try {
    await FirebaseFirestore.instance.collection('products').doc(id).update(updatedProduct.toMap());
    int index = productList.indexWhere((product) => product.id == id);
    if (index != -1) {
      productList[index] = updatedProduct.copyWith(id: id);
    }
  } catch (e) {
    print('❌ Gagal mengedit produk: $e');
  }
}

  void showDateTimePicker() async {
    final result = await Get.dialog<Map<String, dynamic>>(
      const Calendar(),
    );

    if (result != null) {
      final pickedDate = result['selectedDate'] as DateTime;
      final pickedTime = result['selectedTime'] as TimeOfDay;
      final pickedCategory = result['selectedCategory'] as String;

      final combined = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );

      selectedDateTime.value = combined;
      selectedCategory.value = pickedCategory;
      selectedDate.value = combined;
    }
  }

  void editQuotation(QuotationModel quotation, List<ProductModel> products) {
    fromCompany.text = quotation.fromCompany;
    fromNumber.text = quotation.fromPhone;
    fromSocial.text = quotation.fromSocialMedia;
    fromAddress.text = quotation.fromAddress;

    toCompany.text = quotation.toCompany;
    toSeller.text = quotation.toSeller;
    toNumber.text = quotation.toPhone;

    terms.text = quotation.terms;
    bank.text = quotation.bank;
    receiver.text = quotation.receiver;
    rekening.text = quotation.rekening;

    logoImage.value =
        quotation.logoImagePath != null ? File(quotation.logoImagePath!) : null;
    selectedDate.value = quotation.selectedDate;

    productList.value = products;

    Get.back();
  }

  void clearForm() {
    fromCompany.clear();
    fromNumber.clear();
    fromSocial.clear();
    fromAddress.clear();
    toCompany.clear();
    toSeller.clear();
    toNumber.clear();
    terms.clear();
    products.clear();
    bank.clear();
    receiver.clear();
    rekening.clear();
    logoImage.value = null;
    selectedDate.value = null;
  }

  void clearProducts() {
    productList.clear();
  }
}
