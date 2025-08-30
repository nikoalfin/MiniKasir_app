// lib/models/product_model.dart
class TransaksiModel {
  final String imageUrl;
  final String productName;
  final String stock;
  final String price;
  final bool showQuantityControls;
  final int quantity;

  TransaksiModel({
    required this.imageUrl,
    required this.productName,
    required this.stock,
    required this.price,
    this.showQuantityControls = true,
    this.quantity = 0,
  });

  // Tambahkan metode copyWith di sini
  TransaksiModel copyWith({
    String? imageUrl,
    String? productName,
    String? stock,
    String? price,
    bool? showQuantityControls,
    int? quantity,
  }) {
    return TransaksiModel(
      imageUrl: imageUrl ?? this.imageUrl,
      productName: productName ?? this.productName,
      stock: stock ?? this.stock,
      price: price ?? this.price,
      showQuantityControls: showQuantityControls ?? this.showQuantityControls,
      quantity: quantity ?? this.quantity,
    );
  }
}
