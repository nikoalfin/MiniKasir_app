import 'package:flutter/material.dart';
import 'package:mini_kasir/mini_kasir/transaksi/models/model/transaksi_model.dart';

class TransaksiProvider extends ChangeNotifier {
  List<TransaksiModel> _transaksi = [
    TransaksiModel(
      imageUrl: 'assets/images/product/kopi_tubruk.png',
      productName: 'Kopi Tubruk',
      stock: '200',
      price: 'Rp 12.000',
      showQuantityControls: true,
      quantity: 1,
    ),
    TransaksiModel(
      imageUrl: 'assets/images/product/kentang_goreng.png',
      productName: 'Kentang Goreng',
      stock: '150',
      price: 'Rp 15.000',
      showQuantityControls: true,
      quantity: 2,
    ),
    TransaksiModel(
      imageUrl: 'assets/images/product/kentang_goreng.png',
      productName: 'Kentang Goreng',
      stock: '150',
      price: 'Rp 15.000',
      showQuantityControls: true,
      quantity: 2,
    ),
  ];

  List<TransaksiModel> get transaksi => _transaksi;

  void addTransaksi(TransaksiModel newTransaksi) {
    _transaksi.add(newTransaksi);
    notifyListeners(); // Memberi tahu UI untuk di-update
  }

  void deleteTransaksi(int index) {
    _transaksi.removeAt(index);
    notifyListeners();
  }

  void incrementQuantity(int index) {
    if (_transaksi[index].quantity < int.parse(_transaksi[index].stock)) {
      _transaksi[index] = _transaksi[index].copyWith(
        quantity: _transaksi[index].quantity + 1,
      );
      notifyListeners();
    }
  }

  void decrementQuantity(int index) {
    if (_transaksi[index].quantity > 0) {
      _transaksi[index] = _transaksi[index].copyWith(
        quantity: _transaksi[index].quantity - 1,
      );
      notifyListeners();
    }
  }
}
