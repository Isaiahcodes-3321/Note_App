import '../Constant/themes.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ReUsedTextField extends StatelessWidget {
  const ReUsedTextField({super.key, 
    required this.controller,
    required this.keyboardType,
    required this.hintText,
    required this.onChanged,
    required this.obscureText,
    this.prefixIcon,
    this.suffixIcon
  });

  final TextInputType keyboardType;
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final Icon? prefixIcon;
  final GestureDetector? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20.sp)),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.5), 
            spreadRadius: 1, 
            blurRadius: 2, 
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        children: [
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            decoration: InputDecoration(
              focusColor: Colors.white,
              hintText: hintText,
              hintStyle: const TextStyle(
                color: Color.fromARGB(255, 104, 104, 104),
              ),
               focusedBorder: outlineInputBorder,
              enabledBorder: outlineInputBorder,
              fillColor: Colors.white,
              filled: true,
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon
            ),
            onChanged: onChanged,
          ),
          SizedBox(height: 6.sp),
        ],
      ),
    );
  }
}
