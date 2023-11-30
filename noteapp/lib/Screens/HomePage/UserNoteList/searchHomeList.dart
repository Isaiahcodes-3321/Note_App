import 'home_page.dart';
import 'errorLoading.dart';
import '../export_home.dart';
import '../../Api_Service/searchingNote.dart';
import '../DrawerAndFloatingButton.dart/drawer.dart';

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

    return Consumer(builder: (context, ref, child) {
      return Scaffold(
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
        body: isSearching
            ? ref.watch(userNewNoteFromDB.searchNoteItems).when(
                data: (data) {
                 
                ListView.builder(
                  itemCount: data.notes?.length ?? 0,
                  itemBuilder: (BuildContext context, int index) {
                    final note = data.notes?[index];
                   
                    if (note != null) {
                      String formattedDate =
                          HomePageLogics.formatDate(note.date);

                      return Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Card(
                          child: ListTile(
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
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                );
                return null;
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
            : const Text('searching'),
        floatingActionButton: drawerAndFloatingButton.floatingButton(context),
        drawer: drawerAndFloatingButton.drawer(context),
      );
    });
  }
}
