import '../Api_Service/export.dart';
import 'export_login_register.dart';
import 'package:flutter/material.dart';
import '../../Components/forgetUserNameAni.dart';

LoginAndRegistrationControllers loginControllers =
    LoginAndRegistrationControllers();

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool loginHidePassword = true;

  @override
  void initState() {
    GlobalControllersLogins.userName = TextEditingController();
    GlobalControllersLogins.password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    GlobalControllersLogins.userName = TextEditingController();
    GlobalControllersLogins.password = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    style:
                        textFonts.copyWith(fontSize: 23.sp, color: themeColor),
                  ),
                  SizedBox(height: 3.h),
                  Column(
                    children: [
                      SizedBox(height: 3.h),
                      ReUsedTextField(
                        obscureText: false,
                        controller: GlobalControllersLogins.userName,
                        keyboardType: TextInputType.text,
                        hintText: "User Name",
                        prefixIcon: const Icon(Icons.mail_outline_rounded,
                            color: Colors.black),
                        onChanged: (value) {},
                      ),
                      SizedBox(height: 3.h),
                      ReUsedTextField(
                        controller: GlobalControllersLogins.password,
                        obscureText: loginHidePassword,
                        keyboardType: TextInputType.text,
                        hintText: "Password",
                        prefixIcon: const Icon(Icons.lock_outlined,
                            color: Colors.black),
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
                          onPressed: () {
                            // Navigator.push<void>(
                            //   context,
                            //   MaterialPageRoute<void>(
                            //     builder: (BuildContext context) =>
                            //         const HomePage(),
                            //   ),
                            // );
                            if (GlobalControllersLogins.password.text.isEmpty ||
                                GlobalControllersLogins.userName.text.isEmpty) {
                              loginControllers
                                  .inputsRequiredSnackbar(context);
                            } else {
                              loginControllers
                                  .loginCheckInternetConnection(context);
                            }
                          },
                          child: Padding(
                            padding: EdgeInsets.all(10.sp),
                            child: Text("Login",
                                style: textFonts.copyWith(color: Colors.white)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 3.h,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return (const LogOutAnimation());
                        },
                      );

                      Future.delayed(const Duration(seconds: 5), () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const ForgetUserName();
                          },
                        );
                      });
                    },
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: Text('Forget Username?',
                          style: textFonts.copyWith(
                              color: themeColor,
                              fontSize: 17.sp,
                              decoration: TextDecoration.underline,
                              decorationThickness: 6.sp,
                              decorationColor: themeColor)),
                    ),
                  )
                ],
              ),
            )),
      ),
    );
  }
}
