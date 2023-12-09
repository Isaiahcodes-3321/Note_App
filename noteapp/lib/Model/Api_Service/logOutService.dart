import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Model/Api_Service/export.dart';
import 'package:noteapp/Views/TokenLogout/tryLogingOutUser.dart';

// ignore_for_file: avoid_print
// ignore_for_file: use_build_context_synchronously
class LogOutService {
  ApiServiceState apiServiceState = ApiServiceState();

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
        await GlobalControllers.tokenKey.clear();
        logics.image = null;
        logics.recordedAudio = '';

        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LoginSignUpPage(),
          ),
        );
      } else {
        Navigator.pop(context);
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
      Navigator.pop(context);
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Opps Failed To LogOut Please Try Again",
        themeColor,
        const Duration(seconds: 4),
      );
      print("Error: $e");
    }
  }

// when app its open and token have expires logUser out
  Future<void> userLogOutIfTokenExpires(BuildContext context) async {
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
        await GlobalControllers.tokenKey.clear();
        logics.image = null;
        logics.recordedAudio = '';

        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (context) => const LoginSignUpPage(),
          ),
        );
      } else {
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(builder: (context) => const TryLogUserOut()),
        );
      }
    } catch (e) {
      Navigator.push<void>(
        context,
        MaterialPageRoute<void>(builder: (context) => const TryLogUserOut()),
      );
    }
  }
}
