import 'export.dart';
import 'dart:convert';
import '../../ThemeStore/theme.dart';
import 'package:http/http.dart' as http;

ApiServiceState apiServiceState = ApiServiceState();

class EmptyTrash {
  static Future<void> emptyNote() async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    final response = await http.delete(
      Uri.parse(apiServiceState.emptyTrash),
      headers: {
        'authorization': tokenStorage.myToken,
      },
    );

    final responseData = jsonDecode(response.body);
    print('Note state $responseData');
  }
}
