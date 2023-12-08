import 'home_page.dart';
import 'errorLoading.dart';
import '../export_home.dart';
import '../../Add_Note/Note.dart/upDateNote.dart';
import '../../../Model/Api_Service/readNote.dart';
import '../DrawerAndFloatingButton.dart/drawer.dart';
import '../../../Model/Api_Service/searchingNote.dart';
// ignore_for_file: use_build_context_synchronously

class SearchList extends StatefulWidget {
  const SearchList({super.key});

  @override
  State<SearchList> createState() => _SearchListState();
}

class _SearchListState extends State<SearchList> {
  DrawerAndFloatingButton drawerAndFloatingButton = DrawerAndFloatingButton();
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();

  bool checkIfSearching = false;

  @override
  void initState() {
    super.initState();
    HomePageLogics.checkTokenExpires();
    GlobalControllers.searching = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    GlobalControllers.searching = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final isSearching =
        GlobalControllers.providerRef.watch(UserNewNoteFromDB.isSearchinG);

    final changeTheme =
        GlobalControllers.providerRef.watch(ThemeClass.themeProvider);
    GlobalControllers.getTheme = changeTheme;

    return Consumer(builder: (context, ref, child) {
      return Scaffold(
        backgroundColor: GlobalControllers.backGroundThemeColor,
        appBar: AppBar(
          backgroundColor: themeColor,
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: Icon(
                  Icons.menu,
                  color: AppTextStyle.appBarTextColor,
                  size: 23.sp,
                ),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
          title: SizedBox(
            width: MediaQuery.sizeOf(context).width * 0.55,
            child: TextField(
              controller: GlobalControllers.searching,
              decoration: InputDecoration(
                hintText: 'Search...',
                hintStyle: TextStyle(color: AppTextStyle.appBarTextColor),
                border: InputBorder.none,
              ),
              style: TextStyle(color: AppTextStyle.appBarTextColor),
              onChanged: (value) {
                setState(() {
                  checkIfSearching = !checkIfSearching;
                  GlobalControllers.providerRef
                      .read(UserNewNoteFromDB.isSearchinG.notifier)
                      .state = checkIfSearching;
                });
                SearchingForNote.searchNote();
              },
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.cancel_outlined,
                color: AppTextStyle.appBarTextColor,
                size: 23.sp,
              ),
              onPressed: () {
                setState(() {
                  GlobalControllers.providerRef
                          .read(UserNewNoteFromDB.isSearchinG.notifier)
                          .state =
                      !GlobalControllers.providerRef
                          .read(UserNewNoteFromDB.isSearchinG.notifier)
                          .state;
                });
                Navigator.push<void>(
                  context,
                  MaterialPageRoute<void>(
                    builder: (BuildContext context) => const HomePage(),
                  ),
                );
              },
            ),
          ],
        ),
        body: SizedBox(
          child: isSearching
              ? ref.watch(userNewNoteFromDB.searchNoteItems).when(
                  data: (searchData) {
                  // Print to check if data is received
                  print('Number of notes: ${searchData.notes?.length}');
                  // print('Search Note ${searchData.notes?.first.title}');
                  if (searchData.notes != null &&
                      searchData.notes!.isNotEmpty) {
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
                                      const SearchList(),
                                ),
                              );
                            },
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemCount: searchData.notes?.length,
                              itemBuilder: (context, index) {
                                final note = searchData.notes?[index];
                                String userNoteId = note!.noteId ?? '';
                                int userNoteIdINT =
                                    int.tryParse(userNoteId) ?? 0;

                                String formattedDate =
                                    HomePageLogics.formatDate(note.date);

                                return Padding(
                                  padding: EdgeInsets.all(15.sp),
                                  child: GestureDetector(
                                    onTap: () {
                                      GlobalControllers.id = userNoteIdINT;
                                      print('User note Id its $userNoteIdINT');
                                      ReadUserNote.readNote();
                                      var getTittle = note.title;
                                      setState(() {
                                        GlobalControllers.providerRef
                                            .read(UserNewNoteFromDB
                                                .readNoteTitle.notifier)
                                            .state = getTittle;
                                      });

                                      Navigator.push<void>(
                                        context,
                                        MaterialPageRoute<void>(
                                          builder: (BuildContext context) =>
                                              const UpdatePage(),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      child: ListTile(
                                        title: Text(note.title ?? '',
                                            overflow: TextOverflow.ellipsis,
                                            style: AppTextStyle.textStyle()
                                                .copyWith(
                                              color: themeColor,
                                            )),
                                        subtitle: Text(
                                          note.note ?? '',
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                          style:
                                              AppTextStyle.textStyle().copyWith(
                                            color: const Color.fromARGB(
                                                255, 8, 8, 43),
                                            fontSize: 17.sp,
                                          ),
                                        ),
                                        trailing: Text(
                                          formattedDate,
                                          style:
                                              AppTextStyle.textStyle().copyWith(
                                            color: Colors.red,
                                            fontSize: 15.sp,
                                          ),
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
                    
                  } else {
                    return Center(
                      child: Text(
                        'No notes found',
                        style: TextStyle(
                            fontSize: 18,
                            color: GlobalControllers.textThemeColor),
                      ),
                    );
                  }
                }, error: (error, stacktrace) {
                  return const ErrorLoading();
                }, loading: () {
                  return Center(
                    child: SpinKitChasingDots(
                      color: themeColor,
                      size: 40.sp,
                    ),
                  );
                })
              : Container(
                  color: GlobalControllers.backGroundThemeColor,
                  child: Center(
                      child: Text(
                    'searching',
                    style: TextStyle(color: GlobalControllers.textThemeColor),
                  ))),
        ),
        floatingActionButton: drawerAndFloatingButton.floatingButton(context),
        drawer: drawerAndFloatingButton.drawer(context),
      );
    });
  }
}
