import 'export.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../state_Management/ModelNote/sNote.dart';

ApiServiceState apiServiceState = ApiServiceState();

class SearchingForNote{
  static Future<ModelS> searchNote() async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;
   final String searchQuery = GlobalControllers.searching.text; 

    final Uri url =
        Uri.parse(apiServiceState.searchNoteEndpoint).replace(queryParameters: {
      'searchQuery': searchQuery,
    });

    final response = await http.get(
      headers: {
        'authorization': tokenStorage.myToken,
      },
      url,
    );

    final responseData = jsonDecode(response.body);
    print('Search Note state $responseData');
    return ModelS.fromJson(responseData);
  }
}
