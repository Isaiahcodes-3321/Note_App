import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Screens/Api_Service/export.dart';

// ignore_for_file: use_build_context_synchronously

class RegisteredService {
  ApiServiceState apiServiceState = ApiServiceState();
  Future<void> registration(BuildContext context) async {
    print("Registration its going on now");

    showDialog(
      context: context,
      builder: (context) {
        return (const LogOutAnimation());
      },
    );

    final Map<String, String> registerData = {
      "username": GlobalControllersRegister.userName.text,
      "email": GlobalControllersRegister.email.text,
      "password": GlobalControllersRegister.password.text
    };

    try {
      final response = await http.post(
        Uri.parse(apiServiceState.registrationEndpoint),
        body: registerData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Registration completed successfully.");
        print("Response data: ${response.body}");
        Navigator.pop(context);
        // Store user name and email on hive
        final putToken = UserNameAndEmailStorage(
          userName: GlobalControllersRegister.userName.text,
          email: GlobalControllersRegister.email.text,
        );
        await GlobalControllers.userNameAndEmail.put('userNameBox', putToken);

        ReusedSnackBar.showCustomSnackBar(
          context,
          "Registration completed successfully",
          themeColor,
          const Duration(seconds: 4),
        );

        GlobalControllersRegister.userName.clear();
        GlobalControllersRegister.email.clear();
        GlobalControllersRegister.password.clear();
      } else {
        Navigator.pop(context);
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Opps Failed To Register Please Try Again",
          themeColor,
          const Duration(seconds: 4),
        );

        print("Failed to Register. Status code: ${response.statusCode}");
        print("Response data: ${response.body}");
      }
    } catch (e) {
      Navigator.pop(context);
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Opps Failed To Register Please Try Again",
        themeColor,
        const Duration(seconds: 4),
      );

      print("Error: $e");
    }
  }
}
