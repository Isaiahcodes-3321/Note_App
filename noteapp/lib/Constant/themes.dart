
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


var fontFamily = 'BodoniModa-VariableFont_opsz,wght';
var themeColor = const Color.fromRGBO(42, 42, 92, 1.0);
var textFonts = TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: fontFamily,
  fontSize: 20.sp,
);

var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.sp),
    borderSide: const BorderSide(
      color: Colors.white,
    ));


class BackgroundColor {
  
  static Color lightMode = Colors.white;
  static Color darkMode = const Color.fromARGB(255, 20, 20, 20);

  static Color themeColorLightMode = const Color.fromRGBO(42, 42, 92, 1.0);
  static Color themeColorDarkMode = const Color.fromRGBO(7, 7, 17, 1);
}

class AppTextStyle {
  // Appbar text and add floatingButton white color 
 static Color appBarTextColor = Colors.white;

  static TextStyle textStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
      fontSize: 20.sp,
      color: appBarTextColor,
    );
  }
}
