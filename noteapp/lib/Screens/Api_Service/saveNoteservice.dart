import 'dart:async';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Screens/Api_Service/export.dart';


// ignore_for_file: avoid_print
// import 'dart:io';
// import 'dart:convert';

// ignore_for_file: use_build_context_synchronously
class SaveNoteService {
  ApiServiceState apiServiceState = ApiServiceState();
//save note
  Future<void> saveUserNote(
    BuildContext context,
  ) async {
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
    // final audioFile = logics.recordedAudio;
  
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


  // String base64Audio = base64Encode(utf8.encode(audioFile));

  //    // converting Audio to file
  //     if (base64Audio.isNotEmpty) {
  //       List<int> audioBytes = base64.decode(base64Audio);
  //       File tempAudioFile = File('lib/Audio_file/recorded_audio');
  //       await tempAudioFile.writeAsBytes(audioBytes);

  //       request.files.add(
  //         await http.MultipartFile.fromPath('audio_note', tempAudioFile.path),
  //       );
  //     }

      var response = await http.Response.fromStream(await request.send());

      if (response.statusCode == 200 || response.statusCode == 201) {
        Navigator.pop(context);
        logics.image = null;
        Navigator.push<void>(
          context,
          MaterialPageRoute<void>(
            builder: (BuildContext context) => const HomePage(),
          ),
        );
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Note Saved Successfully ",
          themeColor,
          const Duration(seconds: 4),
        );
      } else {
        Navigator.pop(context);
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
      Navigator.pop(context);
      ReusedSnackBar.showCustomSnackBar(
        context,
        "Failed to Save note: Please try again.",
        themeColor,
        const Duration(seconds: 4),
      );
      // Handle exceptions
      print("Error: $e");
    }
  }
}
