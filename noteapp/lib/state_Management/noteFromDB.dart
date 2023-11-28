import 'ModelNote/sNote.dart';
import '../Screens/Api_Service/searchingNote.dart';
import 'package:noteapp/Screens/Api_Service/listOfNote.dart';
import 'package:noteapp/state_Management/ModelNote/note.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';




class UserNewNoteFromDB {

   final noteItems = FutureProvider<Model>( (ref){
    final fetchedNotes = ListUserNote.getNote();
 
    return fetchedNotes;
   });
   

  static final isSearchinG = StateProvider<bool>((ref) => false);

 final searchNoteItems = FutureProvider<Model2>( (ref){
    final searchFetchedNotes = SearchingForNote.search();
 
    return searchFetchedNotes;
   });
}