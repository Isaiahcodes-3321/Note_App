import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/Components/snackBar.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';
import 'package:noteapp/Screens/Api_Service/api_class.dart';
import 'package:noteapp/Screens/Logins/load_home.dart';

ApiService apiService = ApiService();

class LoginAndRegistrationControllers {
  void inputsRequiredSnackbar(BuildContext context) {
    ReusedSnackBar.showCustomSnackBar(
      context,
      "All inputs are required",
      themeColor,
      Duration(seconds: 3),
    );
  }

// check for internet on registration
  Future<void> registerCheckInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      internetSnackBar(context);
    } else {
      await apiService.registration(context);
    }
  }

  // check for internet on login
  Future<void> loginCheckInternetConnection(BuildContext context) async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      internetSnackBar(context);
    } else {
      LoadHomePage();
      // await apiService.registration(context);
    }
  }

  void internetSnackBar(BuildContext context) {
    ReusedSnackBar.showCustomSnackBar(
      context,
      "Please check your internet connection",
      themeColor,
      Duration(seconds: 3),
    );
  }
}
