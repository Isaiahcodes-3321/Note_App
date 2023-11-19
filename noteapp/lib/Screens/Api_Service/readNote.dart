import 'dart:async';
import 'dart:convert';
import '../../state_Management/note.dart';
import '../HomePage/export_home.dart';
import 'export.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

ApiServiceState apiServiceState = ApiServiceState();

class ReadUserNote {

  Future<Model> getNote() async {
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;

    final response = await http.get(
      Uri.parse(apiServiceState.getNoteEndpoint),
      headers: {
        'authorization': tokenStorage.myToken,
      },
    );

   
    final responseData = jsonDecode(response.body);
    return Model.fromJson(responseData);
   
  }
}



  // Function to format date string
  // String formatDate(String dateString) {
  //   final DateTime parsedDate = DateTime.parse(dateString);
  //   final formattedDate = DateFormat.yMMMd().format(parsedDate);
  //   return formattedDate;
  // }