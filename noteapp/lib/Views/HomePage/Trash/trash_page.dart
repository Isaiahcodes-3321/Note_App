import '../export_home.dart';
import '../../../Model/Api_Service/emptyTrash.dart';
import '../../../Model/Api_Service/restoreNote.dart';
import '../../../Model/Api_Service/deleteANoteFromTrash.dart';
import 'package:noteapp/Views/Add_Note/export_note_input.dart';
// ignore_for_file: use_build_context_synchronously

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => TrashPageState();
}

class TrashPageState extends State<TrashPage> {
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
  RestoreNoteFromTrash restoreNoteFromTrash = RestoreNoteFromTrash();
  DeleteANoteFromTrash deleteANoteFromTrash = DeleteANoteFromTrash();

  int? tappedIndex;
  bool isTapped = true;
  bool iconsShownInList = false;
  @override
  void initState() {
    super.initState();
    HomePageLogics.checkTokenExpires();
  }

  @override
  Widget build(BuildContext context) {
    final changeTheme =
        GlobalControllers.providerRef.watch(ThemeClass.themeProvider);
    GlobalControllers.getTheme = changeTheme;

    return SafeArea(
      child: Consumer(builder: (context, ref, child) {
        return Scaffold(
            backgroundColor: GlobalControllers.backGroundThemeColor,
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
                    EmptyTrash.emptyNote(context);
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
            body: SizedBox(
              height: MediaQuery.sizeOf(context).height * 100.0,
              width: MediaQuery.sizeOf(context).width * 100.0,
              child: ref.watch(userNewNoteFromDB.trashItems).when(
                  data: (trashData) {
                if (trashData.notes != null && trashData.notes!.isNotEmpty) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      children: [
                        RefreshIndicator(
                          onRefresh: () async {
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) =>
                                    const TrashPage(),
                              ),
                            );
                          },
                          child: ListView.builder(
                            shrinkWrap: true,
                             physics: const NeverScrollableScrollPhysics(),
                            itemCount: trashData.notes?.length,
                            itemBuilder: (context, index) {
                              final note = trashData.notes?[index];
                              String userNoteId = note!.noteId ?? '';
                              int userNoteIdINT = int.tryParse(userNoteId) ?? 0;
                  
                              String formattedDate =
                                  HomePageLogics.formatDate(note.date);
                              String noteTitle = note.title ?? '';
                              String noteBody = note.note ?? '';
                  
                              isTapped = index == tappedIndex;
                  
                              return Padding(
                                padding: EdgeInsets.all(15.sp),
                                child: Card(
                                  child: GestureDetector(
                                    onTap: () {
                                      GlobalControllers.id = userNoteIdINT;
                                      setState(() {
                                        isTapped = !isTapped;
                                        tappedIndex = index;
                                        if (isTapped) {
                                          iconsShownInList = !iconsShownInList;
                                        }
                                      });
                                    },
                                    child: SizedBox(
                                      child: Row(
                                        children: [
                                          isTapped
                                              ? Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0, top: 2.h),
                                                  child: Icon(
                                                    Icons.gpp_good_outlined,
                                                    color: Colors.red,
                                                    size: 20.sp,
                                                  ),
                                                )
                                              : const SizedBox(width: 20.0),
                                          SizedBox(
                                            // color: Colors.green,
                                            width: MediaQuery.sizeOf(context)
                                                    .width *
                                                0.80,
                                            child: ListTile(
                                              title: Text(noteTitle,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  style:
                                                      AppTextStyle.textStyle()
                                                          .copyWith(
                                                    color: themeColor,
                                                  )),
                                              subtitle: Text(
                                                noteBody,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                                style: AppTextStyle.textStyle()
                                                    .copyWith(
                                                  color: const Color.fromARGB(
                                                      255, 8, 8, 43),
                                                  fontSize: 17.sp,
                                                ),
                                              ),
                                              trailing: Text(
                                                formattedDate,
                                                style: AppTextStyle.textStyle()
                                                    .copyWith(
                                                  color: Colors.red,
                                                  fontSize: 15.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                  
                      ],
                    ),
                  );
                }
                return Container(
                    color: GlobalControllers.backGroundThemeColor,
                    child: Center(
                        child: Icon(
                      Icons.delete_outline,
                      size: 40.sp,
                      color: GlobalControllers.textThemeColor,
                    )));
              }, error: (error, stacktrace) {
                return Center(
                  child: Text(
                    "some error occurred ",
                    style: TextStyle(color: GlobalControllers.textThemeColor),
                  ),
                );
              }, loading: () {
                return Center(
                  child: SpinKitChasingDots(
                    color: themeColor,
                    size: 40.sp,
                  ),
                );
              }),
            ),
            bottomNavigationBar: iconsShownInList
                // onTap
                ? Container(
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
                              child: Icon(
                                Icons.replay_outlined,
                                color: Colors.white,
                                size: 25.sp,
                              )),
                          Container(
                            width: 1,
                            height: 100,
                            color: Colors.grey,
                          ),
                          GestureDetector(
                              onTap: () {
                                deleteANoteFromTrash.deleteANote(context);
                              },
                              child: Icon(
                                Icons.delete_forever,
                                color: Colors.white,
                                size: 25.sp,
                              ))
                        ]),
                  )
                : const SizedBox(
                    height: 1,
                  ));
      }),
    );
  }
}


















                        // Text('data'),
                        // SizedBox(height: 20,),
                        // Text('data'),
                        // SizedBox(height: 20,),
                        // Text('data'),
                        // SizedBox(height: 20,),
                        // Text('data'),
                        // SizedBox(height: 20,),
                        // Text('data'),
                        // SizedBox(height: 20,),
                        // Text('data'),
                        // SizedBox(height: 20,),
                        // Text('data'),
                        // SizedBox(height: 20,),
                  
                        // Text('data'),
                        // SizedBox(height: 20,),
                        // Text('data'),
                        // SizedBox(height: 20,),