import 'package:flutter/material.dart';
import '../../Views/Logins/export_login_register.dart';


class LoginAndRegistrationControllers {
  LoginService loginService = LoginService();
RegisteredService  registeredService  = RegisteredService();


  void inputsRequiredSnackbar(BuildContext context) {
    ReusedSnackBar.showCustomSnackBar(
      context,
      "All inputs are required",
      themeColor,
      const Duration(seconds: 3),
      
    );
  }

// check for internet on registration
  Future<void> registerCheckInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      internetSnackBar(context);
    } else {
      // ignore: use_build_context_synchronously
      await registeredService.registration(context);
    }
  }

  // check for internet on login
  Future<void> loginCheckInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // ignore: use_build_context_synchronously
      internetSnackBar(context);
    } else {
      // ignore: use_build_context_synchronously
      await loginService.loginUser(context);
    }
  }

  void internetSnackBar(BuildContext context) {
    ReusedSnackBar.showCustomSnackBar(
      context,
      "Please check your internet connection",
      themeColor,
      const Duration(seconds: 3),
      
    );
  }
}