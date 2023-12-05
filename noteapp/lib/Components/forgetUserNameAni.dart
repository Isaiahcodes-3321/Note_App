import 'package:flutter/material.dart';
import '../Screens/Logins/login_SignUp.dart';
import 'package:noteapp/Screens/Logins/export_login_register.dart';


class ForgetUserName extends StatefulWidget {
  const ForgetUserName({super.key});

  @override
  State<ForgetUserName> createState() => _ShowUserNameState();
}

class _ShowUserNameState extends State<ForgetUserName> {
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
                color: Colors.white,
              ),
              height: 40.h,
              width: double.infinity,
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Dear User',
                    style:
                        textFonts.copyWith(fontSize: 23.sp, color: themeColor),
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  Text(
                    'Your user Name its ',
                    style:
                        textFonts.copyWith(fontSize: 18.sp, color: themeColor),
                  ),
                  Text(
                    ' bla anhdik',
                    style:
                        textFonts.copyWith(fontSize: 18.sp, color: themeColor),
                  ),
                  SizedBox(
                    height: 9.h,
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Padding(
                      padding: EdgeInsets.only(right: 5.w),
                      child: OutlinedButton(
                          onPressed: () {
                            // Navigator.pop(context);
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const LoginSignUpPage(),
                              ),
                            );
                          },
                          child: Text(
                            'Okey',
                            style: textFonts.copyWith(
                                fontSize: 18.sp, color: themeColor),
                          )),
                    ),
                  )
                ],
              )),
        ));
  }
}
