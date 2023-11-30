import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Screens/Api_Service/export.dart';

class Update {
  ApiServiceState apiServiceState = ApiServiceState();

  Future<void> updating(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return (const LogOutAnimation());
      },
    );

    final noteId = GlobalControllers.id;
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
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomePage(),
          ),
        );

        // ignore: use_build_context_synchronously
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Note Updated Successfully ",
          themeColor,
          const Duration(seconds: 4),
        );
      } else {
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
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
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      // ignore: use_build_context_synchronously
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
