import 'export.dart';
import 'dart:convert';
import '../../ThemeStore/theme.dart';
import 'package:http/http.dart' as http;


ApiServiceState apiServiceState = ApiServiceState();

class ReadUserNote {
  
  Future<void> getNote() async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    final response = await http.get(
      Uri.parse(apiServiceState.redUserNOTE),
      headers: {
        'authorization': tokenStorage.myToken,
      },
    );

   
    final responseData = jsonDecode(response.body);
    print('User note its $responseData');
  }

}