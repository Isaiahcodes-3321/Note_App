
import 'package:flutter/material.dart';
import 'package:noteapp/Screens/HomePage/logics.dart';
import 'package:noteapp/state_Management/noteFromDB.dart';
import '../Api_Service/timer.dart';
import 'export_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

CountdownManager countdownManager = CountdownManager();
UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();

class _HomePageState extends State<HomePage> {
  bool isSearching = false;

  @override
  void initState() {
    super.initState();
    FormatDate.fetchNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        GlobalControllers.providerRef = ref;
        final noteItem = ref.watch(userNewNoteFromDB.noteItems).when(
            data: (data) {
              GlobalControllers.notes = data.notes;
              print("my notes ${data.notes?.first.title}");
            },
            error: (error, s) {},
            loading: () {});

        var currentTheme = GlobalControllers.providerRef.watch(themeInit);
        var textModeColor =
            currentTheme ? BackgroundColor.lightMode : BackgroundColor.darkMode;

        var listTileBackGround = currentTheme
            ? const Color.fromARGB(255, 54, 54, 56)
            : const Color.fromARGB(255, 143, 143, 179);

        return SafeArea(
          child: Scaffold(
              backgroundColor: currentTheme
                  ? BackgroundColor.darkMode
                  : BackgroundColor.lightMode,
                  
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    backgroundColor: themeColor,
                    flexibleSpace: FlexibleSpaceBar(
                      title: isSearching
                          ? SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.55,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                      color: AppTextStyle.appBarTextColor),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: AppTextStyle.appBarTextColor),
                              ),
                            )
                          : Text('Notes', style: AppTextStyle.textStyle()),
                    ),
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
                    actions: [
                      IconButton(
                        icon: Icon(
                          isSearching ? Icons.cancel_outlined : Icons.search,
                          color: AppTextStyle.appBarTextColor,
                          size: 23.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            isSearching = !isSearching;
                          });
                        },
                      ),
                    ],
                  ),
                  // display notes
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        final note = GlobalControllers.notes![index];
                        String formattedDate = FormatDate.formatDate(note.date);

                        return Padding(
                          padding: EdgeInsets.all(15.sp),
                          child: Card(
                            child: ListTile(
                              title: Text(note.title ?? '',
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.textStyle().copyWith(
                                    color: themeColor,
                                  )),
                              subtitle: Text(note.note ?? '',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: AppTextStyle.textStyle().copyWith(
                                      color: Color.fromARGB(255, 8, 8, 43),
                                      fontSize: 17.sp)),
                              trailing: Text(formattedDate,
                                  style: AppTextStyle.textStyle().copyWith(
                                      color: Colors.red, fontSize: 15.sp)),
                            ),
                          ),
                        );
                      },
                      childCount: GlobalControllers.notes!.length,
                    ),
                  )
                ],
              ),
              drawer: Drawer(
                  // Take 70% of the user screen
                  backgroundColor: currentTheme
                      ? const Color.fromARGB(255, 36, 36, 38)
                      : BackgroundColor.lightMode,
                  width: MediaQuery.sizeOf(context).width * 0.70,
                  child: const MyDrawer()),
              floatingActionButton: FloatingActionButton(
                  focusElevation: 30,
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const AddNote(),
                      ),
                    );
                  },
                  backgroundColor: themeColor,
                  child: Icon(
                    Icons.add,
                    color: AppTextStyle.appBarTextColor,
                    size: 25.sp,
                  ))),
        );
      },
    );
  }
}
