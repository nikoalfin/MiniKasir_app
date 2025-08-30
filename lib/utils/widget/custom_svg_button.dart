import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mini_kasir/utils/my_textstyle.dart'; // Sesuaikan dengan path file Anda

class CustomSvgButton extends StatelessWidget {
  final String label;
  final String svgPath;
  final VoidCallback onPressed;
  final Color backgroundColor;

  const CustomSvgButton({
    Key? key,
    required this.label,
    required this.svgPath,
    required this.onPressed,
    required this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 5,
        padding: const EdgeInsets.symmetric(vertical: 16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            svgPath,
            height: 18, // Sesuaikan ukuran ikon
            width: 18,
            color: Colors
                .white, // Warna ikon putih agar terlihat pada tombol berwarna
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: fontMediumWhite12, // Pastikan gaya teks ini ada
          ),
        ],
      ),
    ),
    );  
  }
}
