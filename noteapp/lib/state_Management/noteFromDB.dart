import 'package:noteapp/state_Management/note.dart';
import 'package:noteapp/Screens/Api_Service/readNote.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';



class UserNewNoteFromDB {

   final noteItems = FutureProvider<Model>( (ref){
      ReadUserNote readUserNote = ReadUserNote();
    final fetchedNotes = readUserNote.getNote();
 
    return fetchedNotes;
   });
   
}