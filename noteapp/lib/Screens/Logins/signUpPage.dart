import 'package:flutter/material.dart';
import 'package:noteapp/Constant/global_controllers.dart';
import 'package:noteapp/Screens/Logins/export_login_register.dart';

LoginAndRegistrationControllers registrationControllers = LoginAndRegistrationControllers();
class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool signUpHidePassword = true;
 

  @override
  void initState() {
     GlobalControllersRegister.registerCheck = true;
    GlobalControllersRegister.email = TextEditingController();
    GlobalControllersRegister.password = TextEditingController();
    GlobalControllersRegister.userName = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    GlobalControllersRegister.email = TextEditingController();
    GlobalControllersRegister.password = TextEditingController();
    GlobalControllersRegister.userName = TextEditingController();

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
                          controller: GlobalControllersRegister.userName,
                          keyboardType: TextInputType.text,
                          hintText: "User Name",
                          prefixIcon: Icon(Icons.person_3_outlined,
                              color: Colors.black),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 3.h),
                        ReUsedTextField(
                          obscureText: false,
                          controller: GlobalControllersRegister.email,
                          keyboardType: TextInputType.emailAddress,
                          hintText: "Email",
                          prefixIcon: Icon(Icons.mail_outline_rounded,
                              color: Colors.black),
                          onChanged: (value) {},
                        ),
                        SizedBox(height: 3.h),
                        ReUsedTextField(
                          controller: GlobalControllersRegister.password,
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
                            if (GlobalControllersRegister.password.text.isEmpty ||
                                GlobalControllersRegister.userName.text.isEmpty ||
                                GlobalControllersRegister.email.text.isEmpty) {
                              registrationControllers.inputsRequiredSnackbar(context);
                            } else {
                               registrationControllers.registerCheckInternetConnection(context);

                              // GlobalControllersRegister.password.clear();
                              // GlobalControllersRegister.userName.clear();
                              // GlobalControllersRegister.email.clear();
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
