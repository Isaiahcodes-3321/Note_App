import 'timer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Screens/Api_Service/export.dart';

class LogOutService {
  ApiServiceState apiServiceState = ApiServiceState();
  CountdownManager countdownManager = CountdownManager();

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
        Uri.parse(apiServiceState.logOutEndpoint),
        headers: {
          'authorization': tokenStorage.myToken,
        },
        body: refreshToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("User logsOut successfully.");
        // Save an boolean value to 'repeat' key.
        // PreferenceService.sharedPref.setBool('repeat', false);
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
        Navigator.pop(context);
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
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Opps Failed To LogOut Please Try Again",
        themeColor,
        const Duration(seconds: 4),
      );
      print("Error: $e");
    }
  }
}
