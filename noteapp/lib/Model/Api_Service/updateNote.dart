import 'dart:async';
import 'package:http/http.dart' as http;
import '../../Views/HomePage/export_home.dart';
import 'package:noteapp/Model/Api_Service/export.dart';

// ignore_for_file: avoid_print
// ignore_for_file: use_build_context_synchronously
class Update {
  ApiServiceState apiServiceState = ApiServiceState();

  Future<void> updating(BuildContext context) async {
        HomePageLogics.checkTokenExpires();
    showDialog(
      context: context,
      builder: (context) {
        return (const LogOutAnimation());
      },
    );
    final noteId = UpdateControllers.id;
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    final Map<String, String> updatingNote = {
      "title": UpdateControllers.noteTittleContext.text,
      "note": UpdateControllers.noteContext.text
    };

    try {
      final response = await http.patch(
        Uri.parse('${apiServiceState.updateNoteEndpoint}$noteId'),
        headers: {
          'authorization': tokenStorage.myToken,
        },
        body: updatingNote,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);

        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomePage(),
          ),
        );

        ReusedSnackBar.showCustomSnackBar(
          context,
          "Note Updated Successfully ",
          themeColor,
          const Duration(seconds: 4),
        );
      } else {
        Navigator.pop(context);
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Failed To Update Note Please Try Again",
          themeColor,
          const Duration(seconds: 4),
        );
        print("Error: Unexpected error occurred - ${response.statusCode}");
        print("\n Response data: ${response.body}");
      }
    } catch (e) {
      Navigator.pop(context);
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Failed To Update Note Please Try Again",
        themeColor,
        const Duration(seconds: 4),
      );

      print("Error: $e");
    }
  }
}
