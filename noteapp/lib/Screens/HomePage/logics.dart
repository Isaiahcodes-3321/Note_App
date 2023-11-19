
import 'package:intl/intl.dart';

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
}