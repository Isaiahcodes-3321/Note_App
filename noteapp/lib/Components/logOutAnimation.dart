import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noteapp/Screens/Logins/export_login_register.dart';

class LogOutAnimation extends StatefulWidget {
  const LogOutAnimation({super.key});

  @override
  State<LogOutAnimation> createState() => _LogOutAnimationState();
}

class _LogOutAnimationState extends State<LogOutAnimation> {
  // @override
  // void initState() {
  //   super.initState();
  //   Future.delayed(const Duration(seconds: 10), () {
  //     Navigator.pop(context);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Color.fromARGB(255, 133, 135, 181),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(20),
        ),
      ),
      content: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: themeColor,
        ),
        height: 40.h,
        width: double.infinity,
        child: SpinKitChasingDots(
          color: Colors.white,
          size: 40.sp,
        ),
      ),
    );
  }
}
