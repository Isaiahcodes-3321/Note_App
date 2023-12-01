import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/ThemeStore/theme.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';

//my storage Make Hive accessible anywhere,
class GlobalControllers {
  static late Box<TokenStorage> tokenKey;
  static late Box themeStorage;
  static late RecorderController controller;
  static late PlayerController playerController;
  static late TextEditingController noteContext;
  static late TextEditingController searching;
  static late TextEditingController noteTittleContext;
  static var providerRef;
  static var getTheme;
  static late int id;
}

class UpdateControllers {
   static late int id;
   static late TextEditingController noteContext;
  static late TextEditingController noteTittleContext;
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

// class PreferenceService {
//   static late SharedPreferences sharedPref;

//   static Future<void> initialize() async {
//     sharedPref = await SharedPreferences.getInstance();
//   }
// }

class GlobalDismissibleContainer {
  static Container container(BuildContext context) {
    // double containerWidth = MediaQuery.of(context).size.width * 0.10;

    return Container(
      width: 30.sp,
      color: Colors.red,
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Icon(Icons.delete, size: 30, color: Colors.white),
          Icon(Icons.delete, size: 30, color: Colors.white),
        ],
      ),
    );
  }
}
