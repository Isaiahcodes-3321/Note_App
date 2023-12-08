import 'timer.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Model/Api_Service/export.dart';
import 'package:responsive_sizer/responsive_sizer.dart';


// ignore_for_file: avoid_print
// ignore_for_file: use_build_context_synchronously
class LoginService {
  ApiServiceState apiServiceState = ApiServiceState();
  CountdownManager countdownManager = CountdownManager();

  Future<void> loginUser(BuildContext context) async {
    print("Login process initiated.");
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        backgroundColor: Colors.white,
        content: Padding(
          padding: EdgeInsets.all(5.sp),
          child: Container(
            decoration: BoxDecoration(
              color: themeColor,
              borderRadius: BorderRadius.circular(10.sp),
            ),
            child: Padding(
              padding: EdgeInsets.all(10.sp),
              child: Text(
                "Logging in...",
                textAlign: TextAlign.center,
                style: textFonts.copyWith(fontSize: 17.sp, color: Colors.white),
              ),
            ),
          ),
        ),
        actions: const [Text('')],
      ),
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

        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();

        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LoadHomePage(),
          ),
        );
        GlobalControllersLogins.userName.clear();
        GlobalControllersLogins.password.clear();
      } else {
        ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Failed to Login: Incorrect username or password",
          themeColor,
          const Duration(seconds: 4),
        );
        print("Error: Unexpected error occurred - ${response.statusCode}");
        print("\n Response data: ${response.body}");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Error: Unexpected error occurred please try again",
        themeColor,
        const Duration(seconds: 4),
      );
      print("Error: $e");
    }
  }
}
