import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Constant/themes.dart';
import '../../Utils/reUsedTextField.dart';
import 'signUpPage.dart';

class LoginPage extends StatefulWidget {
  final Function(int) switchTab; 
  const LoginPage({super.key, required this.switchTab});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var loginPasswordController = TextEditingController();
  bool loginHidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: SingleChildScrollView(
        child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
            child: Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SizedBox(height: 5.h),
                  Text(
                    "Welcome Back!",
                    style: textFonts.copyWith(fontSize: 25.sp, color: themeColor),
                  ),
                  SizedBox(height: 3.h),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 3.h),
                        ReUsedTextField(
                          obscureText: true,
                          controller: TextEditingController(),
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded,
                              color: Colors.black),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 3.h),
                        ReUsedTextField(
                          controller: loginPasswordController,
                          obscureText: loginHidePassword,
                          keyboardType: TextInputType.text,
                          hintText: "Password",
                          prefixIcon:
                              Icon(Icons.lock_outlined, color: Colors.black),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                loginHidePassword = !loginHidePassword;
                              });
                            },
                            child: Icon(
                              loginHidePassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: const Color.fromARGB(255, 88, 88, 88),
                            ),
                          ),
                          onChanged: (value) {},
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: themeColor,
                            borderRadius: BorderRadius.circular(25.sp)),
                        child: TextButton(
                          onPressed: () {},
                          child: Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Text("Login",
                                style: textFonts.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
