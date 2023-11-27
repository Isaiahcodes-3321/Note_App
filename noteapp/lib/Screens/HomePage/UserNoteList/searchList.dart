import '../export_home.dart';
import 'package:flutter/material.dart';

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
   UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
   
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









//  ref.watch(userNewNoteFromDB.searchNoteItems).when(
//                     data: (searchData){
//                       return SliverList(
//                     delegate: SliverChildBuilderDelegate(
//                       (BuildContext context, int index) {
//                         final note = searchData.notes![index];
//                         String formattedDate = FormatDate.formatDate(note.date);
                    
//                         return Padding(
//                           padding: EdgeInsets.all(15.sp),
//                           child: GestureDetector(
//                             onTap: () {
//                             },
//                             child: Card(
//                               child: ListTile(
//                                 title: Text(note.title ?? '',
//                                     overflow: TextOverflow.ellipsis,
//                                     style: AppTextStyle.textStyle().copyWith(
//                                       color: themeColor,
//                                     )),
//                                 subtitle: Text(note.note ?? '',
//                                     maxLines: 2,
//                                     overflow: TextOverflow.ellipsis,
//                                     style: AppTextStyle.textStyle().copyWith(
//                                         color: Color.fromARGB(255, 8, 8, 43),
//                                         fontSize: 17.sp)),
//                                 trailing: Text(formattedDate,
//                                     style: AppTextStyle.textStyle().copyWith(
//                                         color: Colors.red, fontSize: 15.sp)),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       childCount: data.notes!.length,
//                     ),
//                   );
//                     },
//                     error: (erorr, stacktrace) {
//                       return const ErrorLoading();
//                     },
//                     loading: () {
//                       return const Loading();
//                     })