import 'package:flutter/material.dart';
import 'controller.dart';
import 'export_note_input.dart';

class AddNote extends StatefulWidget {
  AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController note_Text = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeProvider);
      return SafeArea(
        child: Scaffold(
          backgroundColor:
              theme ? Backgroundcolor.darkhmode : Backgroundcolor.lightmode,
          appBar: AppBar(
            backgroundColor: themeColor,
            leading: IconButton(
                color: AppTextStyle.appbarTextcolor,
                iconSize: 23.sp,
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back_rounded)),
            title: Text('New Notes',
                style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp)),
            actions: [
              GestureDetector(
                  onTap: () async {
                    connectionCheck. showBanner(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Text("Save",
                          style: AppTextStyle.textStyle()
                              .copyWith(fontSize: 18.sp))))
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                  child: TextField(
                    style: AppTextStyle.textStyle().copyWith(
                        color: const Color.fromARGB(255, 28, 28, 28),
                        fontSize: 20.sp),
                    controller: TextEditingController(),
                    decoration: InputDecoration(
                      focusColor: Colors.white,
                      hintText: "Note title",
                      hintStyle: AppTextStyle.textStyle().copyWith(
                        color: const Color.fromARGB(255, 28, 28, 28),
                      ),
                      focusedBorder: outlineInputBorder,
                      enabledBorder: outlineInputBorder,
                      fillColor: Colors.grey,
                      filled: true,
                    ),
                  ),
                ),

                //  Note_Input(),
              ],
            ),
          ),
          floatingActionButton: FloatingActionButton(
              focusElevation: 30,
              onPressed: () {},
              backgroundColor: themeColor,
              child: Icon(
                Icons.add,
                color: AppTextStyle.appbarTextcolor,
                size: 25.sp,
              )),
        ),
      );
    });
  }
}

//  GestureDetector(
//                            onLongPress: () {
//             Clipboard.setData(ClipboardData(text: note_Text.text));
//             FlutterClipboard.copy(note_Text.text).then((value) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     SnackBar(
//                       content: Text('Text copied to clipboard'),
//                     ),
//                   );
//             });
//           },
//                           child: TextFormField(
//                             style: AppTextStyle.textStyle().copyWith(
//                                 color: const Color.fromARGB(255, 28, 28, 28),
//                                 fontSize: 20.sp),
//                             // maxLength: 10,
//                             maxLines: null,
//                             textInputAction: TextInputAction.newline,
//                             controller: note_Text,
//                             decoration: InputDecoration(
//                               focusColor: Colors.white,
//                               hintText: "Note ",
//                               hintStyle: AppTextStyle.textStyle().copyWith(
//                                 color: const Color.fromARGB(255, 28, 28, 28),
//                               ),
//                               focusedBorder: outlineInputBorder,
//                               enabledBorder: outlineInputBorder,
//                               fillColor: const Color.fromARGB(255, 229, 228, 228),
//                               filled: true,
//                             ),
//                           ),
//                         ),
