// lib/widget/show_bottom.dart

import 'package:flutter/material.dart';
import 'package:mini_kasir/utils/my_color.dart';
import 'package:mini_kasir/utils/my_textstyle.dart';
import 'package:mini_kasir/utils/widget/custom_button.dart';

class ShowBottom extends StatelessWidget {
  final String totalHarga;
  final VoidCallback? onBayarPressed;

  const ShowBottom({Key? key, required this.totalHarga, this.onBayarPressed})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
      decoration: BoxDecoration(
        color: MyColor.BaseColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.black.withOpacity(0.1),
        //     blurRadius: 10,
        //     spreadRadius: 5,
        //     offset: const Offset(0, -3),
        //   ),
        // ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Total', style: fontBoldWhite14),
              const SizedBox(height: 4),
              Text(totalHarga, style: fontBoldWhite14),
            ],
          ),
          SizedBox(
            width: 150, // Sesuaikan lebar tombol
            height: 40,
            child: ElevatedButton(
              onPressed: onBayarPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: MyColor.buttonColorBlue2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(7),
                ),
                elevation: 5,
              ),
              child: Text('Bayar', style: fontBoldWhite14),
            ),
          ),
        ],
      ),
    );
  }
}
