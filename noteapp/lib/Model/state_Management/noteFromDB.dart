import 'ModelNote/sNote.dart';
import 'ModelNote/readNote.dart';
import 'ModelNote/rTrashNote.dart';
import '../Api_Service/readNote.dart';
import '../Api_Service/searchingNote.dart';
import '../../Views/HomePage/export_home.dart';
import 'package:noteapp/Model/Api_Service/viewTrash.dart';

class UserNewNoteFromDB {
// list of note
  final noteItems = FutureProvider<Model>((ref) {
    final fetchedNotes = ListUserNote.getNote();
    // print('ListNote state $fetchedNotes');
    return fetchedNotes;
  });

// read note
  final readNoteItems = FutureProvider<ModelR>((ref) {
    final fetchedNotes = ReadUserNote.readNote();
    print('ListNote state $fetchedNotes');
    return fetchedNotes;
  });

// searching for note
  static final isSearchinG = StateProvider<bool>((ref) => false);
  static final readNoteTitle = StateProvider<String>((ref) => '');

  final searchNoteItems = FutureProvider<ModelS>((ref) async {
    final searchFetchedNotes = await SearchingForNote.searchNote();
    // print('Search Note state ${searchFetchedNotes}');

    return searchFetchedNotes;
  });

  // list of note in Trash
  final trashItems = FutureProvider<ModelReadTrash>((ref) {
    final trashNotes = ViewTrash.trashNote();
    // trashNotes.then((modelReadTrash) {
    //   final titleOfFirstNote = modelReadTrash.notes?.first.title;
    //   print('Title of the first note: $titleOfFirstNote');
    // });
    return trashNotes;
  });
}
