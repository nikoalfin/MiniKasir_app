// import 'package:flutter/material.dart';
// import 'package:mini_kasir/utils/my_textstyle.dart';

// class CustomButton extends StatelessWidget {
//   final String label;
//   final VoidCallback onPressed;
//   final Color backgroundColor;

//   const CustomButton({
//     Key? key,
//     required this.label,
//     required this.onPressed,
//     required this.backgroundColor, // Nilai default jika tidak diberikan
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//    return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//       child: SizedBox(
//         width: double.infinity,
//         height: 50,
//         child: ElevatedButton(
//           onPressed: onPressed,
//           style: ElevatedButton.styleFrom(
//             backgroundColor: backgroundColor,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             elevation: 5,
//           ),
//           child: Text(label, style: fontBoldWhite14),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:mini_kasir/utils/my_textstyle.dart';

class CustomButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final Color backgroundColor;
  // Tambahkan parameter baru untuk ikon
  final bool showPlusIcon;
   final IconData? icon;

  const CustomButton({
    Key? key,
    required this.label,
    required this.onPressed,
    required this.backgroundColor,
    this.showPlusIcon = false, // Nilai default: false
      this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            elevation: 5,
          ),
          // Ubah child menjadi Row
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center, // Pusatkan isi Row
            mainAxisSize: MainAxisSize.min, // Agar Row tidak melebar penuh
            children: [
              // Tampilkan ikon hanya jika showPlusIcon adalah true
              if (showPlusIcon)
                const Icon(Icons.add, size: 16, color: Colors.white),
              // Beri jarak antara ikon dan teks jika ikon ditampilkan
              if (showPlusIcon) const SizedBox(width: 8),
              Text(label, style: fontBoldWhite14),
            ],
          ),
        ),
      ),
    );
  }
}
