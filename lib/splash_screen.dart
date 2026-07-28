import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // بعد از ۳ ثانیه به صفحه اصلی برو
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // رنگ پس‌زمینه ثابت
      body: Center(
        child: Image.asset(
          'assets/images/iraj_logo.png', // 👈 تصویر ثابت
          fit: BoxFit.contain,
          width: 400,
          height: 400,
        ),
      ),
    );
  }
}