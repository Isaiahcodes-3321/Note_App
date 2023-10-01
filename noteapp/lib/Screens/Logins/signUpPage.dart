import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Constant/themes.dart';
import '../../Utils/reUsedTextField.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  var signUpPasswordController = TextEditingController();
  var signUpUsernameController = TextEditingController();
  var signUpEmailController = TextEditingController();
  bool signUpHidePassword = true;

  void ShowSnackbar(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: themeColor,
        content: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Container(
            decoration: BoxDecoration( color: Color.fromRGBO(93, 93, 149, 1),
            borderRadius: BorderRadius.circular(10.sp)),
           
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text("All inputs are required",
               textAlign: TextAlign.center,
              style: textFonts.copyWith(fontSize: 15.sp)),
            ),
          ),
        ),
        duration: Duration(seconds: 3),
      ),
    );
  }


  @override
  void dispose() {
    signUpPasswordController.dispose();
    signUpUsernameController.dispose();
    signUpEmailController.dispose();
    super.dispose();
  }

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
                    "Creat An Account",
                    style:
                        textFonts.copyWith(fontSize: 23.sp, color: themeColor),
                  ),
                  SizedBox(height: 5.h),
                  Container(
                    child: Column(
                      children: [
                        ReUsedTextField(
                          obscureText: false,
                          controller: signUpUsernameController,
                          keyboardType: TextInputType.text,
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.person_3_outlined,
                              color: Colors.black),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 3.h),
                        ReUsedTextField(
                          obscureText: false,
                          controller: signUpEmailController,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded,
                              color: Colors.black),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 3.h),
                        ReUsedTextField(
                          controller: signUpPasswordController,
                          obscureText: signUpHidePassword,
                          keyboardType: TextInputType.text,
                          hintText: "Password",
                          prefixIcon:
                              Icon(Icons.lock_outlined, color: Colors.black),
                          suffixIcon: GestureDetector(
                            onTap: () {
                              setState(() {
                                signUpHidePassword = !signUpHidePassword;
                              });
                            },
                            child: Icon(
                              signUpHidePassword
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
                          onPressed: () {
                            if (signUpPasswordController.text.isEmpty ||
                                signUpUsernameController.text.isEmpty ||
                                signUpEmailController.text.isEmpty) {
                                ShowSnackbar(context);
                            } else {
                              signUpPasswordController.clear();
                              signUpUsernameController.clear();
                              signUpEmailController.clear();
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Text("Sign Up",
                                style: textFonts.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
