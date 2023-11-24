import 'export_home.dart';
import '../Api_Service/timer.dart';
import '../Api_Service/readNote.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:noteapp/Screens/HomePage/logics.dart';
import 'package:noteapp/state_Management/noteFromDB.dart';


class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}


class _HomePageState extends ConsumerState<HomePage> {
  ReadUserNote readUserNote = ReadUserNote();
  CountdownManager countdownManager = CountdownManager();
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();

  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    //  var currentTheme = GlobalControllers.providerRef.watch(themeInit);
    GlobalControllers.providerRef = ref;
    return Scaffold(
      body: ref.watch(userNewNoteFromDB.noteItems).when(data: (data) {
        return CustomScrollView(
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
                            hintStyle:
                                TextStyle(color: AppTextStyle.appBarTextColor),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: AppTextStyle.appBarTextColor),
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
            //worked on
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final note = data.notes![index];
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
                            style: AppTextStyle.textStyle()
                                .copyWith(color: Colors.red, fontSize: 15.sp)),
                      ),
                    ),
                  );
                },
                childCount: data.notes!.length,
              ),
            )
          ],
        );
      }, error: (erorr, stacktrace) {
        return const Center(
          child: Text("some error occurred "),
        );
      }, loading: () {
        return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Center(
              child: SpinKitChasingDots(
                color: themeColor,
                size: 40.sp,
              ),
            ));
      }),
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
          )),
      drawer: Drawer(
          // Take 70% of the user screen
          backgroundColor:
              // currentTheme
              //     ? const Color.fromARGB(255, 36, 36, 38)
              //     :
              BackgroundColor.lightMode,
          width: MediaQuery.sizeOf(context).width * 0.70,
          child: const MyDrawer()),
    );
  }
}
