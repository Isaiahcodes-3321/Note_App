import 'package:flutter/material.dart';
import 'package:noteapp/Screens/Api_Service/export.dart';
import 'package:http/http.dart' as http;



class SaveNoteService {
 
  ApiServiceState apiServiceState = ApiServiceState();
//save note
  Future<void> saveUserNote(BuildContext context) async {
    showDialog(
      context: context,
      builder: (context) {
        return (const LogOutAnimation());
      },
    );

    GlobalControllers.providerRef;

    String noteBodyValue = GlobalControllers.providerRef
        .read(UserNewNotes.noteBody.notifier)
        .state;
    String noteTittleValue = GlobalControllers.providerRef
        .read(UserNewNotes.noteTittle.notifier)
        .state;

    GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    print('not updating to storage');
    final imageFile = logics.image;
    String imagePath = imageFile!.path;
    try {
      final response = await http.post(
        Uri.parse(apiServiceState.createNoteEndpoint),
        headers: {
          'authorization': tokenStorage.myToken,
        },
        body: {
          'title': noteTittleValue,
          'note': noteBodyValue,
          'audio': logics.recordedAudio,
          'image': imagePath
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Note Saved Successfully ",
          themeColor,
          const Duration(seconds: 4),
        );
      } else if (response.statusCode == 404) {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Failed to Save: Please try again.",
          themeColor,
          const Duration(seconds: 4),
        );
      } else {
        // ignore: use_build_context_synchronously
        Navigator.pop(context);
        // ignore: use_build_context_synchronously
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Failed to Save note: Please try again.",
          themeColor,
          const Duration(seconds: 4),
        );
        print("Error: Unexpected error occurred - ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}