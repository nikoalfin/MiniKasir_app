import 'package:flutter/material.dart';
import 'dart:async';
import 'package:go_router/go_router.dart';
import 'package:mini_kasir/utils/my_color.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _startSplashTimer();
    });
  }

  void _startSplashTimer() {
    // Timer untuk menunggu animasi selesai sebelum navigasi
    Timer(const Duration(seconds: 3), () {
      context.goNamed('home'); // Navigasi ke halaman "home"
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: MyColor.basicColor,
        child: Image.asset('assets/images/splash.png', 
        fit: BoxFit.cover),
      ),
    );
  }
}
