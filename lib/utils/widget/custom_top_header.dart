// lib/widget/custom_top_header.dart

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomTopHeader extends StatelessWidget {
  const CustomTopHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Container(
      width: screenWidth,
      height: 100,
      child: SvgPicture.asset(
        'assets/images/home/logo_header.svg',
        fit: BoxFit.fill,
      ),
    );
  }
}
