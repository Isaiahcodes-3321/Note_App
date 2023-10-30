import 'package:flutter/material.dart';
import 'package:noteapp/Components/snackBar.dart';
import 'package:noteapp/Constant/global_controllers.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:noteapp/Constant/themes.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ApiService {
  final String registrationEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/signup";
  final String loginEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/login";
  final String refreshToken =
      "https://note-api-amz2.onrender.com/api/v1/auth/refreshToken";
  final String logOutEndpoint =
      "https://note-api-amz2.onrender.com/api/v1/auth/logout";
  final String createNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/create-note";
  final String getNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/list-notes";
  final String updateNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/updatenotes/5";
  final String deleteNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/deletenotes/5";
  final String searchNoteEndpoint =
      "https://note-api-amz2.onrender.com/users/notes/search?searchQuery=My ";
  final String viewTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash";
  final String restoreTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/restore/:noteId";
  final String deleteTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/delete/:noteId";
  final String emptyTrash =
      "https://note-api-amz2.onrender.com/users/notes/trash/empty-trash";

  Future<void> registration(BuildContext context) async {
    print("Registration its going on now");
    ReusedSnackBar.showCustomSnackBar(
      context,
      "Registration Its Going On...",
      themeColor,
      Duration(seconds: 15),
    );

    final Map<String, String> data = {
      "username": GlobalControllersRegister.userName.text,
      "email": GlobalControllersRegister.email.text,
      "password": GlobalControllersRegister.password.text
    };

    try {
      final response = await http.post(
        Uri.parse(registrationEndpoint),
        body: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Registration completed successfully.");
        print("Response data: ${response.body}");
        GlobalControllersRegister.userName.clear();
        GlobalControllersRegister.email.clear();
        GlobalControllersRegister.password.clear();
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Registration completed successfully",
          themeColor,
          Duration(seconds: 4),
        );
      } else {
        ReusedSnackBar.showCustomSnackBar(
          context,
          "Opps Failed To Register Please Try Again",
          themeColor,
          Duration(seconds: 4),
        );

        print("Failed to Register. Status code: ${response.statusCode}");
        print("Response data: ${response.body}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }

  //   Future<void> createNote(BuildContext context) async {
  //      print("Sending note now to backend");

  //   final Map<String, String> data = {
  //     'title': GlobalControllers.noteTittleContext.text,
  //     'note': GlobalControllers.noteContext.text,
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse(createNoteEndpoint),
  //       body: data,
  //     );

  //     if (response.statusCode == 200) {
  //       print("Note created successfully.");
  //       print("Response data: ${response.body}");
  //     } else {
  //       print("Failed to create note. Status code: ${response.statusCode}");
  //       print("Response data: ${response.body}");
  //     }
  //   } catch (e) {
  //     print("Error: $e");
  //   }
  // }
}
