import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:noteapp/Constant/themes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginUnsuccesful extends StatelessWidget {
  const LoginUnsuccesful({super.key});

  @override
  Widget build(BuildContext context) {
    return BasicDialogAlert(
      title: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Login Failed!",
                style: AppTextStyle.textStyle().copyWith(
                  color: Colors.red,
                )),
            Icon(Icons.cancel_outlined, color: Colors.red, size: 30.sp)
          ],
        ),
      ),
      content: Text("Incorrect password or username.",
          style: AppTextStyle.textStyle().copyWith(
            color: Color.fromARGB(255, 171, 72, 65),
          ),
          textAlign: TextAlign.center),
      actions: <Widget>[
        BasicDialogAction(
          title: Text("OK",
              style: AppTextStyle.textStyle().copyWith(
                color: Colors.red,
              )),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
