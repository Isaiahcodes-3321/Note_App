import '../export_home.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  @override
  Widget build(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          // final note = data.notes![index];
          // String formattedDate = FormatDate.formatDate(note.date);
          // String noteID = note.noteId ?? '';
          // int parsedNoteID = int.tryParse(noteID) ?? 0;

          return Padding(
            padding: EdgeInsets.all(15.sp),
            child: GestureDetector(
              onTap: () {
                // if(parsedNoteID == parsedNoteID){
                //   readUserNote.readNote();
                // }
              },
              child: const Card(child: Text(' Searching Loading')),
            ),
          );
        },
        childCount: 3,
      ),
    );
  }
}
