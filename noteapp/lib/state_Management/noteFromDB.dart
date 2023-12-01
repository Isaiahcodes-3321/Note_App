import 'ModelNote/sNote.dart';
import 'ModelNote/readNote.dart';
import '../Screens/HomePage/export_home.dart';
import '../Screens/Api_Service/searchingNote.dart';
import 'package:noteapp/Screens/Api_Service/listOfNote.dart';
import 'package:noteapp/state_Management/ModelNote/note.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';

class UserNewNoteFromDB {
// list of note
  final noteItems = FutureProvider<Model>((ref) {
    final fetchedNotes = ListUserNote.getNote();
    print('ListNote state ${fetchedNotes}');
    return fetchedNotes;
  });

// read note
  final readNoteItems = FutureProvider<ModelR>((ref) {
    final fetchedNotes = ReadUserNote.readNote();
    print('ListNote state ${fetchedNotes}');
    return fetchedNotes;
  });

// searching for not
  static final isSearchinG = StateProvider<bool>((ref) => false);

  final searchNoteItems = FutureProvider<ModelS>((ref) async {
    final searchFetchedNotes = await SearchingForNote.searchNote();
    // print('Search Note state ${searchFetchedNotes}');

    return searchFetchedNotes;
  });
}
