import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';

//my storage Make Hive accessible anywhere,
class GlobalControllers {
  static late Box themeStorage;
  static late RecorderController controller;
  static late PlayerController playerController;
  static late TextEditingController noteContext;
  static late TextEditingController noteTittleContext;
  static var providerRef;
  static var getTheme;
}

class GlobalControllersLogins {
  static late TextEditingController userName;
  static late TextEditingController password;
}

class GlobalControllersRegister {
  static late TextEditingController userName;
  static late TextEditingController email;
  static late TextEditingController password;
  static late bool registerCheck;
}

class GlobalDismissibleContainer {
  static Container container(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width * 0.10;

    return Container(
      width: 30.sp,
      color: Colors.red,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Icon(Icons.delete, size: 30, color: Colors.white),
          Icon(Icons.delete, size: 30, color: Colors.white),
          Icon(Icons.delete, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
