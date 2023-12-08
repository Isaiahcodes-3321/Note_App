import 'package:intl/intl.dart';
import '../../Model/Api_Service/export.dart';
import '../../Views/HomePage/export_home.dart';
import 'package:noteapp/Model/ThemeStore/theme.dart';
import '../../Model/Api_Service/refreshTokenService.dart';


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