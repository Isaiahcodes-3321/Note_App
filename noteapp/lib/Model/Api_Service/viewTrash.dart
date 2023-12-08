import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noteapp/Model/Api_Service/export.dart';
import '../state_Management/ModelNote/rTrashNote.dart';

ApiServiceState apiServiceState = ApiServiceState();

class ViewTrash {
  bool checkRegistration = true;
  static Future<ModelReadTrash> trashNote() async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    final response = await http.get(
      Uri.parse(apiServiceState.viewTrash),
      headers: {
        'authorization': tokenStorage.myToken,
      },
    );
    final responseData = jsonDecode(response.body);
    return ModelReadTrash.fromJson(responseData);
  }
}
