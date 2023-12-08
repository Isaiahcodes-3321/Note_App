import 'export.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:noteapp/Views/HomePage/export_home.dart';

// ignore_for_file: avoid_print
// ignore_for_file: use_build_context_synchronously



ApiServiceState apiServiceState = ApiServiceState();

class EmptyTrash {
  static Future<void> emptyNote(BuildContext context) async {
        HomePageLogics.checkTokenExpires();
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    final response = await http.delete(
      Uri.parse(apiServiceState.emptyTrash),
      headers: {
        'authorization': tokenStorage.myToken,
      },
    );

    Navigator.push<void>(
      context,
      MaterialPageRoute<void>(
        builder: (BuildContext context) => const TrashPage(),
      ),
    );
    final responseData = jsonDecode(response.body);
    print('Note state $responseData');
  }
}
