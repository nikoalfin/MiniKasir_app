import 'package:flutter/material.dart';
import 'package:mini_kasir/mini_kasir/product/models/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> _products = [
    ProductModel(
      imageUrl: 'assets/images/product/kopi_tubruk.png',
      productName: 'Kopi Tubruk',
      stock: '200',
      price: 'Rp 12.000',
      showQuantityControls: true,
      quantity: 1,
    ),
    ProductModel(
      imageUrl: 'assets/images/product/kentang_goreng.png',
      productName: 'Kentang Goreng',
      stock: '150',
      price: 'Rp 15.000',
      showQuantityControls: true,
      quantity: 2,
    ),
  ];

  List<ProductModel> get products => _products;

  void addProduct(ProductModel newProduct) {
    _products.add(newProduct);
    notifyListeners(); // Memberi tahu UI untuk di-update
  }

  void deleteProduct(int index) {
    _products.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (_products[index].quantity < int.parse(_products[index].stock)) {
      _products[index] = _products[index].copyWith(
        quantity: _products[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (_products[index].quantity > 0) {
      _products[index] = _products[index].copyWith(
        quantity: _products[index].quantity - 1,
      );
      notifyListeners();
    }
  }
}
