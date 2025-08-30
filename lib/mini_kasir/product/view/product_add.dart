import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:mini_kasir/mini_kasir/product/provider/product_add_provider.dart';
import 'package:mini_kasir/utils/my_color.dart';
import 'package:mini_kasir/utils/my_textstyle.dart';
import 'package:mini_kasir/utils/widget/custom_back.dart';
import 'package:mini_kasir/utils/widget/custom_button.dart';
import 'package:mini_kasir/utils/widget/custom_top_header.dart';
import 'package:provider/provider.dart';
import 'package:mini_kasir/utils/number_input_formatter.dart';

class ProductAdd extends StatelessWidget {
  const ProductAdd({super.key});

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
                child: _buildProductForm(
                  context,
                ), // <--- _buildProductForm yang akan digulir
              ),
            ), // <--- Remove SingleChildScrollView here
            ],
          ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomButton(
          label: 'Produk Baru',
          onPressed: () {
            // Aksi saat tombol Transaksi diklik
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
      child: Column(children: [CustomBackCard(title: 'Tambah Produk')]),
    );
  }


  Widget _buildProductForm(BuildContext context) {
    final provider = context.watch<ProductAddProvider>();

    // Gunakan `SingleChildScrollView` di sini
    return Container(
        // Tambahkan Container untuk membungkus konten yang dapat digulir
        margin: const EdgeInsets.symmetric(horizontal: 34, vertical: 30),
        padding: const EdgeInsets.all(20),
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(child: Text('Foto Produk', style: fontMediumBlack12)),
            const SizedBox(height: 10),
            GestureDetector(
              onTap: provider.pickImage,
              child: Center(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1),
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
              ),
            ),
            const SizedBox(height: 10),
            _buildTextFieldWithLabel('Nama Produk', 'masukan nama produk'),
            const SizedBox(height: 16),
            _buildStockInput(),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel('Satuan Produk', 'PCS', isNumber: true),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel(
              'Harga Beli',
              'masukan harga beli',
              isNumber: true,
            ),
            const SizedBox(height: 16),
            _buildTextFieldWithLabel(
              'Harga Jual',
              'masukan harga jual',
              isNumber: true,
            ),
            const SizedBox(height: 16),
            _buildCategoryDropdown(),
          ],
        ),
      );
  }

  Widget _buildTextField(String hintText, {bool isNumber = false}) {
    return TextField(
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber
          ? <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,
           NumberInputFormatter(locale: 'id_ID')]
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
        hintStyle: fontHintText12
      ),
      style: fontMediumBlack12,
    );
  }

  Widget _buildTextFieldWithLabel(
    String label,
    String hintText, {
    bool isNumber = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: fontMediumBlack14),
        const SizedBox(height: 8),
        _buildTextField(
          hintText,
          isNumber: isNumber,
        ), // <-- Meneruskan parameter di sini
      ],
    );
  }

  Widget _buildStockInput() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Stok', style: fontMediumBlack12),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: _buildTextField('0', isNumber: true)),
            const SizedBox(width: 16),
            Row(
              children: [
                Radio(value: false, groupValue: true, onChanged: (value) {}),
                Text('Tanpa Stok', style: fontMediumBlack12),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildCategoryDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Kategori', style: fontMediumBlack12),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: MyColor.basicColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              isExpanded: true,
              value: 'Makanan',
              items: <String>['Makanan', 'Minuman', 'Elektronik']
                  .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, style: fontMediumBlack12),
                    );
                  })
                  .toList(),
              onChanged: (String? newValue) {},
            ),
          ),
        ),
      ],
    );
  }
}
