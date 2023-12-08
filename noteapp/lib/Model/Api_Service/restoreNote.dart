import 'package:http/http.dart' as http;
import '../../Views/HomePage/export_home.dart';
import 'package:noteapp/Model/Api_Service/export.dart';


// ignore_for_file: avoid_print
// ignore_for_file: use_build_context_synchronously

class RestoreNoteFromTrash {
  ApiServiceState apiServiceState = ApiServiceState();
  Future<void> restoreNote(BuildContext context) async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;
    final noteId = GlobalControllers.id;

    try {
      final response = await http.get(
        Uri.parse('${apiServiceState.restoreTrash}$noteId'),
        headers: {
          'authorization': tokenStorage.myToken,
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Response data: ${response.body}");
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const TrashPage(),
          ),
        );
      } else {
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Failed To Restore note Please Try Again",
          themeColor,
          const Duration(seconds: 4),
        );

        print("Failed to Restore note. Status code: ${response.statusCode}");
        print("Response data: ${response.body}");
      }
    } catch (e) {
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Failed To Restore note Please Try Again",
        themeColor,
        const Duration(seconds: 4),
      );
      print("Error: $e");
    }
  }
}
