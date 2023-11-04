import 'package:flutter/material.dart';
import 'package:noteapp/Constant/themes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReusedSnackBar {
  static void showCustomSnackBar(BuildContext context, String text, Color themeColor, Duration duration,) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: themeColor,
        content: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Container(
            decoration: BoxDecoration(
              color: const Color.fromRGBO(93, 93, 149, 1),
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text(
                text,
                textAlign: TextAlign.center,
                style: textFonts.copyWith(fontSize: 17.sp),
              ),
            ),
          ),
        ),
        duration: duration,
      ),
    );
  }

}
