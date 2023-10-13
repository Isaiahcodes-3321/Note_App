import 'package:flutter/material.dart';
import 'export_login_register.dart';

class LoadHomePage extends StatefulWidget {
  const LoadHomePage({super.key});

  @override
  State<LoadHomePage> createState() => _LoadHomePageState();
}

class _LoadHomePageState extends State<LoadHomePage> {
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
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