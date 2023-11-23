import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Screens/Api_Service/export.dart';

class SaveNoteService {
  ApiServiceState apiServiceState = ApiServiceState();
//save note
  Future<void> saveUserNote(BuildContext context, ) async {
    showDialog(
      context: context,
      builder: (context) {
        return (const LogOutAnimation());
      },
    );

   
    String noteBodyValue = GlobalControllers.providerRef
        .read(UserNewNotes.noteBody.notifier)
        .state;
    String noteTittleValue = GlobalControllers.providerRef
        .read(UserNewNotes.noteTittle.notifier)
        .state;

     GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;


   print('saving note to storage');
final imageFile = logics.image;
String imagePath = imageFile?.path ?? '';

try {
  var request = http.MultipartRequest(
    'POST',
    Uri.parse(apiServiceState.createNoteEndpoint),
  );

  // Add headers
  request.headers['authorization'] = tokenStorage.myToken;

  // Add form-data fields
  request.fields['title'] = noteTittleValue;
  request.fields['note'] = noteBodyValue;

  // Add image file
  if (imageFile != null) {
    request.files.add(
      await http.MultipartFile.fromPath('image', imageFile.path),
    );
  }

  var response = await http.Response.fromStream(await request.send());

  if (response.statusCode == 200 || response.statusCode == 201) {
    // Handle success
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
    // Handle 404 error
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
    // Handle other errors
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
    print("\n Response data: ${response.body}");
  }
} catch (e) {
  // Handle exceptions
  print("Error: $e");
}

  }
}
