import 'package:flutter/material.dart';
import 'package:mini_kasir/mini_kasir/product/view/product_add.dart';
import 'package:mini_kasir/utils/my_color.dart';
import 'package:mini_kasir/utils/widget/custom_back.dart';
import 'package:mini_kasir/utils/widget/custom_button.dart';
import 'package:mini_kasir/utils/widget/custom_search.dart';
import 'package:mini_kasir/utils/widget/custom_product_card.dart';
import 'package:mini_kasir/utils/widget/custom_top_header.dart';
import 'package:provider/provider.dart';
import '../provider/product_provider.dart';


class Product extends StatelessWidget {
  const Product({super.key});

  @override
  Widget build(BuildContext context) {
       final productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: MyColor.basicColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Menggunakan Stack untuk menumpuk header dan kartu
              Stack(
                clipBehavior: Clip.none, // Mengizinkan widget keluar dari batas
                children: [
                   const CustomTopHeader(),
                  Positioned(
                    top: 70,
                    left: 16,
                    right: 16,
                    child: _buildStoreInfoCard(context),
                  ),
                ],
              ),
              const SizedBox(height: 90), // Memberikan ruang di bawah tumpukan
              ProductGrid(
                products: productProvider.products,
                onPlusPressed: productProvider.incrementQuantity,
                onMinusPressed: productProvider.decrementQuantity,
                onDeletePressed: productProvider.deleteProduct,
                 showAllQuantityControls: false,
              )
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          label: 'Tambah Produk',
          onPressed: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductAdd(),
              ), // Ganti ProductPage() dengan nama kelas halaman yang benar
            );
            // Aksi saat tombol Transaksi diklik
            // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage()));
          },
          backgroundColor: MyColor.BaseColor, // Warna tombol sesuai desain
        ),
      ),
    );
  }

  Widget _buildStoreInfoCard(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          CustomBackCard(title: 'Tambah Produk'),
          const SizedBox(height: 18), // Jarak antara dua baris
          CustomSearchField(),
        ],
      ),
    );
  }
}
