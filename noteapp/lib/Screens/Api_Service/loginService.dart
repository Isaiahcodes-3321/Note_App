  import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:noteapp/Screens/Api_Service/export.dart';
import 'package:http/http.dart' as http;


class LoginService {
 
 ApiServiceState apiServiceState = ApiServiceState();

 // Funtion for login
 
  //ShelliS
  //ShelliS


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
        Uri.parse(apiServiceState.loginEndpoint),
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
           // Save an boolean value to 'repeat' key.
        PreferenceService.sharedPref.setBool('repeat', true);
      
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
        print("\n Response data: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}