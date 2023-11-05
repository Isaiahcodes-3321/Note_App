import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dialogs/flutter_dialogs.dart';
import 'package:hive/hive.dart';
import 'package:noteapp/Components/snackBar.dart';
import 'package:noteapp/Constant/global_controllers.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Constant/themes.dart';
import 'package:noteapp/Screens/Logins/load_home.dart';
import 'package:noteapp/Screens/Logins/login_SignUp.dart';
import 'package:noteapp/ThemeStore/theme.dart';

import '../../Components/logOutAnimation.dart';

class ApiServiceState {
  final String registrationEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/signup";
  final String loginEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/login";
  final String refreshToken =
      "https://note-api-amz2.onrender.com/api/v1/auth/refreshToken";
  final String logOutEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/logout";
  final String createNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/create-note";
  final String getNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/list-notes";
  final String updateNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/updatenotes/5";
  final String deleteNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/deletenotes/5";
  final String searchNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/search?searchQuery=My ";
  final String viewTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash";
  final String restoreTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/restore/:noteId";
  final String deleteTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/delete/:noteId";
  final String emptyTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/empty-trash";

// Funtion for registration
  bool checkRegistration = true;
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
        Uri.parse(registrationEndpoint),
        body: registerData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Registration completed successfully.");
        print("Response data: ${response.body}");
        Navigator.pop(context);

        // ignore: use_build_context_synchronously
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
        // ignore: use_build_context_synchronously
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
      print("Error: $e");
    }
  }

  // Funtion for login
  // isaiah001
  // big

  //
  //

  Future<void> loginUser(BuildContext context) async {
    print("Login process initiated.");

    ReusedSnackBar.showCustomSnackBar(
      context,
      "Loging in...",
      themeColor,
      const Duration(seconds: 10),
    );
      // clear the hive storage at all there is still data in it
      await GlobalControllers.tokenKey.clear();

    final loginData = {
      "username": GlobalControllersLogins.userName.text,
      "password": GlobalControllersLogins.password.text,
    };

    try {
      final response = await http.post(
        Uri.parse(loginEndpoint),
        body: loginData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Login successful.");
        // print("Response data: ${response.body}");

        // Extract the access token from the response
        final Map<String, dynamic> responseData = json.decode(response.body);

        String accessToken = responseData["accessToken"];
        String reFreshToken = responseData["refreshToken"];
        // Store the access token using Hive
        final putToken = TokenStorage(
          myToken: accessToken,
          myRefreshToken: reFreshToken,
        );
        await GlobalControllers.tokenKey.put('accessToken', putToken);

        // ignore: use_build_context_synchronously
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LoadHomePage(),
          ),
        );
        GlobalControllersLogins.userName.clear();
        GlobalControllersLogins.password.clear();
      } else if (response.statusCode == 404) {
        // ignore: use_build_context_synchronously
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Failed to Login: Incorrect username or password",
          themeColor,
          const Duration(seconds: 4),
        );
      } else {
        // ignore: use_build_context_synchronously
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Failed to Login: Unexpected Error. Please try again.",
          themeColor,
          const Duration(seconds: 4),
        );
        print("Error: Unexpected error occurred - ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

// User LogOut
  Future<void> userLogOut(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return (const LogOutAnimation());
      },
    );
    print("User LoginOut");

    GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    final Map<String, String> refreshToken = {
      "refreshToken": tokenStorage.myRefreshToken
    };

    try {
      final response = await http.post(
        Uri.parse(logOutEndpoint),
        headers: {
          'authorization': tokenStorage.myToken,
        },
        body: refreshToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User logsOut successfully.");
         await GlobalControllers.tokenKey.clear();

        // ignore: use_build_context_synchronously
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LoginSignUpPage(),
          ),
        );
      } else {
        // ignore: use_build_context_synchronously
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Opps Failed To LogOut Please Try Again",
          themeColor,
          const Duration(seconds: 4),
        );

        print("Failed to LogOut. Status code: ${response.statusCode}");
        print("Response data: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
