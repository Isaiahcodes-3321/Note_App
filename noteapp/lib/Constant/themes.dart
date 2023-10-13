import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../ThemeStore/theme.dart';

//my storage Make Hive accessible anywhere,
late Box<Theme_check> themestorage;

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
  
  static Color lightmode = Colors.white;
  static Color darkhmode = Color.fromARGB(255, 20, 20, 20);

  static Color themeColorLightmode = Color.fromRGBO(42, 42, 92, 1.0);
  static Color themeColorDarkmode = Color.fromRGBO(7, 7, 17, 1);
}

class AppTextStyle {
  // Appbar text and add floatingButton white color 
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
