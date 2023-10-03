import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

var fontFamily = 'BodoniModa-VariableFont_opsz,wght';
var themeColor = Color.fromRGBO(42, 42, 92, 1.0);
var textFonts = TextStyle(
  fontWeight: FontWeight.bold,
  fontFamily: fontFamily,
  fontSize: 20.sp,
);

var outlineInputBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(18.sp),
    borderSide: BorderSide(
      color: Colors.white,
    ));


class Backgroundcolor {
  static Color ligthmode = Colors.white;
  static Color darkhmode = Colors.black;

  static Color themeColorLigthmode = Color.fromRGBO(42, 42, 92, 1.0);
  static Color themeColorDarkmode = Color.fromRGBO(7, 7, 17, 1);
}

class AppTextStyle {
  // Appbar text and add button white color 
 static Color appbarTextcolor = Colors.white;

  static TextStyle textStyle() {
    return TextStyle(
      fontWeight: FontWeight.bold,
      fontFamily: fontFamily,
      fontSize: 20.sp,
      color: appbarTextcolor,
    );
  }
}
