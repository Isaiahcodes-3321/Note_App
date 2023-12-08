import 'export_login_register.dart';
import 'package:flutter/material.dart';


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