
import 'dart:convert';
import 'package:noteapp/Screens/Api_Service/export.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';


class RefreshTokenService {
  ApiServiceState apiServiceState = ApiServiceState();


 Future<void> reFreshToken() async {
   GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
    final tokenStorage = GlobalControllers.tokenKey.getAt(1) as TokenStorage;
  //  final accessToken = tokenStorage.myToken;

    final Map<String, String> getRefreshToken = {
      "refreshToken": tokenStorage.myRefreshToken
    };

    try {
      final response = await http.post(
        Uri.parse(apiServiceState.refreshToken),
        body: getRefreshToken,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
       
        final Map<String, dynamic> responseData = json.decode(response.body);

        String accessToken = responseData["accessToken"];
        String reFreshToken = responseData["refreshToken"];

        //  Store the access token 
        final putToken = TokenStorage(
          myToken: accessToken,
            myRefreshToken: reFreshToken,
        );
        await GlobalControllers.tokenKey.put('accessToken', putToken);

      } else {
        // ignore: use_build_context_synchronously
        reFreshToken();
        print(
            "Failed to get refresh Token. Status code: ${response.statusCode}");
        print("Response data: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

}