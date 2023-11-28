import '../export_home.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import '../../Api_Service/export.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../Api_Service/refreshTokenService.dart';
import 'package:noteapp/Screens/Api_Service/listOfNote.dart';

ListUserNote readUserNote = ListUserNote();

class HomePageLogics {
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

  static checkTokenExpires() async {
    RefreshTokenService refreshTokenService = RefreshTokenService();

    GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;
    bool hasExpired = JwtDecoder.isExpired(tokenStorage.myToken);
    if (hasExpired == true) {
      refreshTokenService.reFreshToken();
    }
  }

  //  static Future<void> fetchNotes() async {
  //   final fetchedNotes = await readUserNote.getNote();
  //   GlobalControllers.notes = fetchedNotes.notes;
  //   // print("my notes ${fetchedNotes.notes?.first.title}");
  // }
}
