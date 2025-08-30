import 'package:flutter/material.dart';
import 'package:mini_kasir/utils/my_textstyle.dart';
import 'package:mini_kasir/utils/my_color.dart';
// import 'package:mini_kasir/models/product_model.dart'; // Pastikan ini diimpor jika ProductGrid menggunakan ProductModel

// --- Widget ProductCard (Internal) ---
class ProductCard extends StatelessWidget {
  final String imageUrl;
  final String productName;
  final String stock;
  final String price;
  final bool showQuantityControls;
  final VoidCallback? onMinusPressed;
  final VoidCallback? onPlusPressed;
  final VoidCallback? onDeletePressed;
  final int quantity;

  const ProductCard({
    Key? key,
    required this.imageUrl,
    required this.productName,
    required this.stock,
    required this.price,
    this.showQuantityControls = true,
    this.onMinusPressed,
    this.onPlusPressed,
    this.onDeletePressed,
    this.quantity = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(12),
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
      child: Row(
        // <-- Ini adalah perubahan utama: Menggunakan Row
        crossAxisAlignment:
            CrossAxisAlignment.center, // Pusatkan secara vertikal
        children: [
          // Gambar Produk
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              imageUrl,
              width: 70, // Tetapkan lebar gambar
              height: 70, // Tetapkan tinggi gambar
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          // Detail Produk (Nama, Stok, Harga)
          Expanded(
            // Expanded agar teks mengisi ruang yang tersedia
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize
                  .min, // Agar kolom tidak memakan ruang lebih dari yang dibutuhkan
              children: [
                Text(
                  productName,
                  style: fontMediumBlack14,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Stok : $stock',
                  style: fontMediumGrey12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  'Harga : $price',
                  style: fontMediumGrey12,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          // Kontrol Kuantitas dan Tombol Hapus
          Column(
            // Row terpisah untuk kontrol agar mudah diatur
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end, 

            children: [
              if (showQuantityControls)
                Row( // Baris untuk tombol (- 2 +)
                  children: [
                    InkWell(
                      onTap: onMinusPressed,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: MyColor.cardColorRed,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.remove, size: 16, color: Colors.white),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(quantity.toString(), style: fontMediumBlack14),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: onPlusPressed,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: BoxDecoration(
                          color: MyColor.buttonColorBlue,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: const Icon(Icons.add, size: 16, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 8), // Memberi jarak vertikal
              // Tombol Hapus (berada di bawah)
              InkWell(
                onTap: onDeletePressed,
                child: const Icon(Icons.delete, color: Colors.red, size: 24),
              ),
            ],

          ),
        ],
      ),
    );
  }
}

// --- Widget ProductGrid (Public) ---
class ProductGrid extends StatelessWidget {
  final List<dynamic> products;
  final int crossAxisCount;
  final double crossAxisSpacing;
  final double mainAxisSpacing;
  final bool showAllQuantityControls;
  final Function(int) onPlusPressed;
  final Function(int) onMinusPressed;
  final Function(int) onDeletePressed;

  const ProductGrid({
    super.key,
    required this.products,
    this.crossAxisCount = 1,
    this.crossAxisSpacing = 16,
    this.mainAxisSpacing = 0,
    required this.onPlusPressed,
    required this.onMinusPressed,
    required this.onDeletePressed,
     this.showAllQuantityControls = false,
  });

  @override
  Widget build(BuildContext context) {
    // Jika crossAxisCount adalah 1, gunakan ListView.builder
    if (crossAxisCount == 1) {
      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: crossAxisSpacing,
              vertical:
                  mainAxisSpacing /
                  2, // Menggunakan setengah mainAxisSpacing sebagai padding vertikal
            ),
            child: ProductCard(
              imageUrl: product.imageUrl,
              productName: product.productName,
              stock: product.stock,
              price: product.price,
              showQuantityControls: showAllQuantityControls,
              quantity: product.quantity,
               onDeletePressed: () => onDeletePressed(index),
              onMinusPressed: () => onMinusPressed(index),
              onPlusPressed: () => onPlusPressed(index),
            ),
          );
        },
      );
    }
    // Jika crossAxisCount lebih dari 1, gunakan GridView.builder
    else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: crossAxisSpacing,
            mainAxisSpacing: mainAxisSpacing,
            childAspectRatio:
                0.7, // Nilai rasio yang lebih cocok untuk layout grid
          ),
          itemCount: products.length,
          itemBuilder: (context, index) {
            final product = products[index];
            return ProductCard(
              imageUrl: product.imageUrl,
              productName: product.productName,
              stock: product.stock,
              price: product.price,
              showQuantityControls: product.showQuantityControls,
              onDeletePressed: () {},
              onMinusPressed: () {},
              onPlusPressed: () {},
              quantity: product.quantity,
            );
          },
        ),
      );
    }
  }
}
