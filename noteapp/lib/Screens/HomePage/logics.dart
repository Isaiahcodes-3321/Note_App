import 'package:intl/intl.dart';
import 'package:noteapp/Screens/Api_Service/listOFNote.dart';


ReadUserNote readUserNote = ReadUserNote();
class FormatDate{

    // Function to format date string
 static String formatDate(String? dateString) {
    if (dateString != null && dateString.isNotEmpty) {
      final DateTime parsedDate = DateTime.parse(dateString);
      final formattedDate = DateFormat.yMMMd().format(parsedDate);
      return formattedDate;
    } else {
      return '';
    }
  }



  //  static Future<void> fetchNotes() async {
  //   final fetchedNotes = await readUserNote.getNote();
  //   GlobalControllers.notes = fetchedNotes.notes;
  //   // print("my notes ${fetchedNotes.notes?.first.title}");
  // }
}