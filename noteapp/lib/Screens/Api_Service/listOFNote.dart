import 'dart:async';
import 'export.dart';
import 'dart:convert';
import '../HomePage/export_home.dart';
import 'package:http/http.dart' as http;

ApiServiceState apiServiceState = ApiServiceState();

class ListUserNote{

  static Future<Model> getNote() async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;
    
    final response = await http.get(
      Uri.parse(apiServiceState.getListNoteEndpoint),
      headers: {
        'authorization': tokenStorage.myToken,
      },
    );

   
    final responseData = jsonDecode(response.body);
     print('ListNote state $responseData');
    return Model.fromJson(responseData);
   
  }
}
