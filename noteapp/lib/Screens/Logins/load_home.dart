import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'export_login_register.dart';

class LoadHomePage extends StatefulWidget {
  const LoadHomePage({super.key});

  @override
  State<LoadHomePage> createState() => _LoadHomePageState();
}

class _LoadHomePageState extends State<LoadHomePage> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: themeColor,
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: SpinKitChasingDots(
            color: Colors.white,
            size: 40.sp,
          ),
        ),
      ),
    );
  }
}