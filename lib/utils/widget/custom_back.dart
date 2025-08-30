// lib/widget/custom_header_card.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mini_kasir/utils/my_color.dart';
import 'package:mini_kasir/utils/my_textstyle.dart';

class CustomBackCard extends StatelessWidget {
  final String title;
  final VoidCallback? onBackPress;

  const CustomBackCard({Key? key, required this.title, this.onBackPress})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      // padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: MyColor.textWhite,
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: onBackPress ?? () => context.pop(),
            child: const Row(
              children: [
                Icon(Icons.arrow_back, size: 20, color: MyColor.textGrey),
                SizedBox(width: 8),
                Text(
                  'Kembali',
                  style: fontMediumGrey12, // Sesuaikan dengan gaya teks Anda
                ),
              ],
            ),
          ),
          Text(
            title,
            style: fontMediumBlack14, // Sesuaikan dengan gaya teks Anda
          ),
        ],
      ),
    );
  }
}
