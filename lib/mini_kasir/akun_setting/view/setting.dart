import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_kasir/mini_kasir/product/provider/product_add_provider.dart';
import 'package:mini_kasir/utils/my_color.dart';
import 'package:mini_kasir/utils/my_textstyle.dart';
import 'package:mini_kasir/utils/widget/custom_back.dart';
import 'package:mini_kasir/utils/widget/custom_button.dart';
import 'package:mini_kasir/utils/widget/custom_svg_button.dart';
import 'package:mini_kasir/utils/widget/custom_top_header.dart';
import 'package:provider/provider.dart';
import 'package:mini_kasir/utils/number_input_formatter.dart';


class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: MyColor.basicColor,
      body: SafeArea(
        // Place SingleChildScrollView here to make the entire body scrollable
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
            const SizedBox(height: 10),
            Expanded(
              // Expanded akan membuat SingleChildScrollView mengambil sisa ruang yang tersedia
              child: SingleChildScrollView(
                child: _buildDataTokoForm(
                  context,
                ), // <--- _buildProductForm yang akan digulir
              ),
            ), // <--- Remove SingleChildScrollView here
          ],
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
      child: Column(children: [CustomBackCard(title: 'Pengaturan')]),
    );
  }

  Widget _buildDataTokoForm(BuildContext context) {
    final provider = context.watch<ProductAddProvider>();

    // Gunakan `SingleChildScrollView` di sini
    return Container(
      // Tambahkan Container untuk membungkus konten yang dapat digulir
      margin: const EdgeInsets.symmetric(horizontal: 34, vertical: 30),
      // padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: MyColor.basicColor,
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          _buildCustomCard(child: _buildStoreLogoSection(context)),
          const SizedBox(height: 10),
          _buildCustomCard(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Pastikan ini ada agar rata kiri
              children: [
                Text('Nama Toko', style: fontMediumBlack14),
                _buildTextField('masukan nama toko anda'),
                const SizedBox(height: 16),
                Text('Alamat Toko', style: fontMediumBlack14),
                _buildTextField('Jl Mawar Melati, rt 04 rw 03', maxLines: 4),
                // Anda bisa menambahkan widget lain di sini
              ],
            ),
          ),
          const SizedBox(height: 10),
          _buildCustomCard(child: _buildPrintPaperCard(context)),
          const SizedBox(height: 10),
          CustomSvgButton(
            label: 'Test Print',
            onPressed: () {
              // Tambahkan logika untuk melakukan test print
            },
            svgPath: 'assets/images/setting/print.svg', // Ganti dengan path SVG Anda
            backgroundColor: MyColor.buttonColorRed, // Ganti dengan MyColor.red jika ada
          ),
          const SizedBox(height: 16),

          // Tombol "Simpan Settings" (Hijau)
          CustomSvgButton(
            label: 'Simpan Settings',
            onPressed: () {
              // Tambahkan logika untuk menyimpan pengaturan
            },
            svgPath: 'assets/images/setting/save.svg', // Ganti dengan path SVG Anda
            backgroundColor:
                MyColor.buttonColorGreen, // Ganti dengan MyColor.green jika ada
          ),
        ],
      ),
    );
  }

  Widget _buildCustomCard({required Widget child}) {
    return Container(
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: MyColor.textWhite, // Ganti MyColor.BaseColor menjadi Colors.white agar sesuai dengan desain Anda
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
      child: child,
    );
  }

  // Ini adalah metode baru yang akan Anda gunakan
  Widget _buildStoreLogoSection(BuildContext context) {
    final provider = context.watch<ProductAddProvider>();
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text('Logo Usaha', style: fontMediumBlack14),
          const SizedBox(height: 10),
          Container(
            width: 90,
            height: 90,
            decoration: BoxDecoration(
              color: MyColor.basicColor,
              borderRadius: BorderRadius.circular(10),
              image: provider.selectedImage != null
                  ? DecorationImage(
                      image: FileImage(provider.selectedImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: provider.selectedImage == null
                ? const Center(
                    child: Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: Colors.grey,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: 200,
            height: 40, // Ganti dengan lebar yang Anda inginkan
            child: CustomButton(
              label: 'Uploud Logo',
              onPressed: provider.pickImage,
              backgroundColor: MyColor.BaseColor,
              showPlusIcon: true,
            ),
          ),
        ],
      );
  }

  Widget _buildTextField(
    String hintText, {
    bool isNumber = false,
    int? maxLines,
  }) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      maxLines: maxLines, // Gunakan parameter di sini
      inputFormatters: isNumber
          ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
              NumberInputFormatter(locale: 'id_ID'),
            ]
          : null,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: MyColor.basicColor,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 14,
        ),
        hintStyle: fontHintText12,
      ),
      style: fontMediumBlack12,
    );
  }

  Widget _buildTextFieldWithLabel(
    String label,
    String hintText, {
    bool isNumber = false,
    int? maxLines,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: fontMediumBlack14),
        const SizedBox(height: 8),
        _buildTextField(
          hintText,
          isNumber: isNumber,
          maxLines: maxLines,
        ), // <-- Meneruskan parameter di sini
      ],
    );
  }

  Widget _buildPrintPaperCard(BuildContext context) {
    // Ganti dengan provider yang sesuai jika Anda mengelolanya dengan Provider
    // final settingsProvider = context.watch<SettingsProvider>();

    // Variabel dummy untuk contoh
    final selectedPrinter =
        'Eppos'; // Ganti dengan variabel state dari provider
    final printerOptions = ['Eppos', 'Bluebamboo', 'Thermal', 'Custom'];

    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Text('Kertas Print', style: fontMediumBlack14)),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: MyColor.basicColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                isExpanded: true,
                value: selectedPrinter,
                icon: const Icon(Icons.keyboard_arrow_down, color: Colors.grey),
                items: printerOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Row(
                      children: [
                        const Icon(Icons.print, size: 20, color: Colors.grey),
                        const SizedBox(width: 10),
                        Text(value, style: fontMediumBlack12),
                      ],
                    ),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  // Tambahkan logika untuk mengubah state provider
                  // settingsProvider.setSelectedPrinter(newValue!);
                },
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text('Custom Kertas', style: fontMediumBlack12),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(child: _buildTextField('Lebar Kertas', isNumber: true)),
              const SizedBox(width: 10),
              Expanded(
                child: _buildTextField('Panjang Kertas', isNumber: true),
              ),
            ],
          ),
        ],
      );
  }
}
