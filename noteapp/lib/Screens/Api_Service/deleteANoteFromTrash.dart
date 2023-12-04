import '../HomePage/export_home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Screens/Api_Service/export.dart';
// ignore_for_file: use_build_context_synchronously

class DeleteANoteFromTrash {
  ApiServiceState apiServiceState = ApiServiceState();
  Future<void> deleteANote(BuildContext context) async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;
    final noteId = GlobalControllers.id;

    try {
      final response = await http.delete(
        Uri.parse('${apiServiceState.deleteTrash}$noteId'),
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
          "Failed To Delete Please Try Again",
          themeColor,
          const Duration(seconds: 4),
        );

        print("Failed to Delete Note. Status code: ${response.statusCode}");
        print("Response data: ${response.body}");
      }
    } catch (e) {
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Failed To Delete Please Try Again",
        themeColor,
        const Duration(seconds: 4),
      );
      print("Error: $e");
    }
  }
}
