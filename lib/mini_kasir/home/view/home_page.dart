import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_kasir/mini_kasir/akun_setting/view/setting.dart';
import 'package:mini_kasir/mini_kasir/product/view/product.dart';
import 'package:mini_kasir/mini_kasir/transaksi/view/transaksi.dart';
import 'package:mini_kasir/utils/my_textstyle.dart';
import 'package:mini_kasir/utils/my_color.dart';
import 'package:mini_kasir/utils/widget/custom_button.dart';
import 'package:mini_kasir/utils/widget/custom_top_header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
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
              const SizedBox(height: 120), // Memberikan ruang di bawah tumpukan
              _buildMainContentCard(),
            ],
          ),
        ),
      ),

      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          label: 'Transaksi',
          onPressed: () {
             Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Transaksi(),
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
          // Widget pertama: Baris untuk informasi toko
          Row(
            children: [
              // Dengan pemanggilan _buildUserLogo
              // Anda bisa berikan path aset atau URL yang didapat dari API
              _buildUserLogo(
                logoPath: 'assets/images/home/logo_shop.png',
              ), // Contoh dengan aset lokal

              const SizedBox(width: 10),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('DayTrans Mart', style: fontMediumBlack14),
                    Text(
                      'Rt 04 Rw 03, Kec Kesamben, Kab. Blitar',
                      style: fontMediumGrey10,
                    ),
                  ],
                ),
              ),
              Container(
                width: 25,
                height: 25,
                child: SvgPicture.asset(
                  'assets/images/home/edit.svg',
                  fit: BoxFit.cover, // Atur sesuai kebutuhan
                ),
              ),
            ],
          ),

          const SizedBox(height: 15), // Jarak antara dua baris
          // Widget kedua: Baris untuk kartu metrik omset dan profit
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildMetricCard(
                title: 'Omset',
                amount: 'Rp 5.000.000',
                backgroundColor: MyColor.cardColorRed,
                borderColor: MyColor.borderColorRed,
              ),
              _buildMetricCard(
                title: 'Profit',
                amount: 'Rp 2.000.000',
                backgroundColor: MyColor.cardColorGreen,
                borderColor: MyColor.borderColorGreen,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMainContentCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        // color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 0,
            blurRadius: 0,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [const SizedBox(height: 20), _buildFeatureGrid()],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String amount,
    required Color backgroundColor,
    required Color borderColor,
  }) {
    return Expanded(
      child: Container(
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 5),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(title, style: fontMediumGrey12),
            const SizedBox(height: 5),
            Text(amount, style: fontMediumBlack14),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureGrid() {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      children: [
        _buildFeatureItem(
          label: 'Produk',
          svgPath: 'assets/images/home/logo_produk.svg',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Product(),
              ), // Ganti ProductPage() dengan nama kelas halaman yang benar
            );
          },
        ),
        _buildFeatureItem(
          label: 'Riwayat',
          svgPath: 'assets/images/home/logo_riwayat.svg',
        ),
        _buildFeatureItem(
          label: 'Pengeluaran',
          svgPath: 'assets/images/home/logo_pengeluaran.svg',
        ),
        _buildFeatureItem(
          label: 'Laporan',
          svgPath: 'assets/images/home/logo_laporan.svg',
        ),
        _buildFeatureItem(
          label: 'Tambah Stok',
          svgPath: 'assets/images/home/logo_tambahStok.svg',
        ),
        _buildFeatureItem(
          label: 'Pengaturan',
          svgPath: 'assets/images/home/logo_pengaturan.svg',
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Setting(),
              ), // Ganti ProductPage() dengan nama kelas halaman yang benar
            );
          },
        ),
      ],
    );
  }

  Widget _buildFeatureItem({
    required String label,
    required String svgPath,
    VoidCallback? onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = constraints.maxWidth;
        return InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            decoration: BoxDecoration(
              color: MyColor.basicColor,
              borderRadius: BorderRadius.circular(10),
              // boxShadow: [
              //   BoxShadow(
              //     color: Colors.grey.withOpacity(0.1),
              //     spreadRadius: 1,
              //     blurRadius: 5,
              //     offset: const Offset(0, 3),
              //   ),
              // ],
            ),
            child: Padding(
              padding: EdgeInsets.all(itemWidth * 0.1), // Padding responsif
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    svgPath,
                    height: itemWidth * 0.4, // Ukuran SVG responsif
                    width: itemWidth * 0.4,
                  ),
                  SizedBox(height: itemWidth * 0.1), // Jarak responsif
                  Text(label, style: fontMediumBlack12),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// Fungsi baru untuk menampilkan logo
Widget _buildUserLogo({String? logoPath, String? networkUrl}) {
  ImageProvider imageProvider;

  if (networkUrl != null) {
    imageProvider = NetworkImage(networkUrl);
  } else if (logoPath != null) {
    if (logoPath.startsWith('http')) {
      // Cek jika path adalah URL
      imageProvider = NetworkImage(logoPath);
    } else {
      imageProvider = AssetImage(logoPath);
    }
  } else {
    // Placeholder jika tidak ada gambar
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: const Center(
        child: Icon(Icons.person, color: Colors.grey, size: 30),
      ),
    );
  }

  return Container(
    width: 50,
    height: 50,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey.shade300),
      image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
    ),
  );
}
