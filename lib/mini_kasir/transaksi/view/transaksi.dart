import 'package:flutter/material.dart';
import 'package:mini_kasir/utils/my_color.dart';
import 'package:mini_kasir/utils/widget/custom_back.dart';
import 'package:mini_kasir/utils/widget/custom_button.dart';
import 'package:mini_kasir/utils/widget/custom_search.dart';
import 'package:mini_kasir/utils/widget/custom_product_card.dart';
import 'package:mini_kasir/utils/widget/custom_show_bottom.dart';
import 'package:mini_kasir/utils/widget/custom_top_header.dart';
import 'package:provider/provider.dart';
import '../provider/transaksi_provider.dart';

class Transaksi extends StatelessWidget {
  const Transaksi({super.key});

  @override
  Widget build(BuildContext context) {
    final transaksiProvider = Provider.of<TransaksiProvider>(context);
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
                products: transaksiProvider.transaksi,
                onPlusPressed: transaksiProvider.incrementQuantity,
                onMinusPressed: transaksiProvider.decrementQuantity,
                onDeletePressed: transaksiProvider.deleteTransaksi,
                showAllQuantityControls: true,
              ),
              // const SizedBox(height: 5),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  label: 'Tambah Produk',
                  showPlusIcon: true,
                  onPressed: () {
                    // Aksi saat tombol Transaksi diklik
                    // Misalnya: Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionPage()));
                  },
                  backgroundColor:
                      MyColor.buttonColorGreen, // Warna tombol sesuai desain
                ),
              ),
            ],
          ),
        ),
      ),

      bottomNavigationBar: ShowBottom(
        totalHarga: 'Rp 100.000', // Ganti dengan data yang sesuai
        onBayarPressed: () {
          // Logika ketika tombol "Bayar" ditekan
          print('Tombol Bayar ditekan!');
        },
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
          CustomBackCard(title: 'Transaksi'),
          const SizedBox(height: 18), // Jarak antara dua baris
          CustomSearchField(),
        ],
      ),
    );
  }
}
