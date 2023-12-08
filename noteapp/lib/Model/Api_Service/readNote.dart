import 'export.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../state_Management/ModelNote/readNote.dart';

ApiServiceState apiServiceState = ApiServiceState();

class ReadUserNote {
   static Future<ModelR> readNote() async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;
    final noteId = GlobalControllers.id; 
    final response = await http.get(
      Uri.parse('${apiServiceState.redUserNOTE}$noteId'), 
      headers: {
        'authorization': tokenStorage.myToken,
      },
    );

    final responseData = jsonDecode(response.body);
    print('User note is $responseData');
    return ModelR.fromJson(responseData);
  }
}

