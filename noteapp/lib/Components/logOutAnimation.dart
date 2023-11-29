import 'package:flutter/material.dart';
import 'package:noteapp/Screens/Logins/export_login_register.dart';

class LogOutAnimation extends StatefulWidget {
  const LogOutAnimation({super.key});

  @override
  State<LogOutAnimation> createState() => _LogOutAnimationState();
}

class _LogOutAnimationState extends State<LogOutAnimation> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return WillPopScope(
        // Prevent dialog from closing if the user clicks outside the dialog

        onWillPop: () async {
          return false;
        },
        child: AlertDialog(
          backgroundColor: const Color.fromARGB(255, 133, 135, 181),
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
        ));
  }
}
