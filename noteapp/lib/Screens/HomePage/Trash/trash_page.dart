import '../export_home.dart';
import '../../Api_Service/emptyTrash.dart';
import '../../Api_Service/restoreNote.dart';
import '../../Api_Service/deleteANoteFromTrash.dart';
import 'package:noteapp/Screens/Add_Note/export_note_input.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => TrashPageState();
}

class TrashPageState extends State<TrashPage> {
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
  RestoreNoteFromTrash restoreNoteFromTrash = RestoreNoteFromTrash();
  DeleteANoteFromTrash deleteANoteFromTrash = DeleteANoteFromTrash();

  bool onTap = true;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: themeColor,
            leading: IconButton(
              color: AppTextStyle.appBarTextColor,
              iconSize: 23.sp,
              onPressed: () {
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                );
              },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: Text(
              'Recycle bin',
              style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  EmptyTrash.emptyNote();
                },
                child: Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Text(
                    "Empty",
                    style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp),
                  ),
                ),
              )
            ],
          ),
          body: Container(
            // color: GlobalControllers.backGroundThemeColor,
            child: Column(
              children: [
                ref.watch(userNewNoteFromDB.trashItems).when(data: (trashData) {
                  // Print to check if data is received
                  // print('Number of notes: ${trashData.notes?.length}');
                  // print('Note ${trashData.notes?.first.title}');

                  if (trashData.notes != null && trashData.notes!.isNotEmpty) {
                    return ListView.builder(
                      shrinkWrap: true,
                      // reverse: true,
                      itemCount: trashData.notes?.length,
                      itemBuilder: (context, index) {
                        final note = trashData.notes?[index];
                        String userNoteId = note!.noteId ?? '';
                        int userNoteIdINT = int.tryParse(userNoteId) ?? 0;

                        // print('Note .,.,., ${data.notes!.first}');

                        String formattedDate =
                            HomePageLogics.formatDate(note.date);

                        return Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Card(
                            child: GestureDetector(
                              onTap: () {
                                GlobalControllers.id = userNoteIdINT;
                                setState(() {
                                  onTap = !onTap;
                                });
                              },
                              child: ListTile(
                                leading: onTap
                                    ? const SizedBox()
                                    : Align(
                                        alignment: Alignment.topLeft,
                                        child: Padding(
                                          padding: EdgeInsets.only(top: 2.h),
                                          child: Icon(
                                            Icons.gpp_good_outlined,
                                            color: Colors.red,
                                            size: 20.sp,
                                          ),
                                        ),
                                      ),
                                title: Text(note.title ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: AppTextStyle.textStyle().copyWith(
                                      color: themeColor,
                                    )),
                                subtitle: Text(
                                  note.note ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.textStyle().copyWith(
                                    color: const Color.fromARGB(255, 8, 8, 43),
                                    fontSize: 17.sp,
                                  ),
                                ),
                                trailing: Text(
                                  formattedDate,
                                  style: AppTextStyle.textStyle().copyWith(
                                    color: Colors.red,
                                    fontSize: 15.sp,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return Container(
                    // color: GlobalControllers.backGroundThemeColor,
                  );
                }, error: (error, stacktrace) {
                  return const Expanded(
                      flex: 8,
                      child: Center(
                        child: Text("some error occurred "),
                      ));
                }, loading: () {
                  return Expanded(
                    flex: 8,
                    child: Center(
                      child: SpinKitChasingDots(
                        color: themeColor,
                        size: 40.sp,
                      ),
                    ),
                  );
                }),
              ],
            ),
          ),
          bottomNavigationBar: onTap
              ? Container(
                  height: 1,
                  // color: GlobalControllers.backGroundThemeColor,
                )
              : Container(
                  color: themeColor,
                  width: double.infinity,
                  height: MediaQuery.sizeOf(context).height * 0.10,
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        GestureDetector(
                            onTap: () {
                              restoreNoteFromTrash.restoreNote(context);
                            },
                            child: Expanded(
                                child: Icon(
                              Icons.replay_outlined,
                              color: Colors.white,
                              size: 25.sp,
                            ))),
                        Container(
                          width: 1,
                          height: 100,
                          color: Colors.grey,
                        ),
                        GestureDetector(
                            onTap: () {
                              deleteANoteFromTrash.deleteANote(context);
                            },
                            child: Expanded(
                                child: Icon(
                              Icons.delete_forever,
                              color: Colors.white,
                              size: 25.sp,
                            )))
                      ]),
                ),
        ),
      );
    });
  }
}
