import 'loadingNote.dart';
import 'errorLoading.dart';
import '../export_home.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
  ReadUserNote readUserNote = ReadUserNote();

  @override
  Widget build(BuildContext context) {
     @override
  void initState() {
    super.initState();
    HomePageLogics.checkTokenExpires();
  }

    GlobalControllers.providerRef = ref;
    final isSearching =
        GlobalControllers.providerRef.watch(UserNewNoteFromDB.isSearchinG);

    return Scaffold(
      body: ref.watch(userNewNoteFromDB.noteItems).when(data: (data) {
        return ref.watch(userNewNoteFromDB.searchNoteItems).when(
            data: (searchData) {
          return CustomScrollView(
            slivers: [
              const MyAppBar(),
              isSearching  
                  ? SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
                          final note = searchData.notes?[index];
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
                                  subtitle: Text(note.note ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.textStyle().copyWith(
                                          color: const Color.fromARGB(
                                              255, 8, 8, 43),
                                          fontSize: 17.sp)),
                                  trailing: Text(formattedDate,
                                      style: AppTextStyle.textStyle().copyWith(
                                          color: Colors.red, fontSize: 15.sp)),
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                        childCount: data.notes?.length ?? 0,
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (BuildContext context, int index) {
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
                                  subtitle: Text(note.note ?? '',
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: AppTextStyle.textStyle().copyWith(
                                          color: const Color.fromARGB(
                                              255, 8, 8, 43),
                                          fontSize: 17.sp)),
                                  trailing: Text(formattedDate,
                                      style: AppTextStyle.textStyle().copyWith(
                                          color: Colors.red, fontSize: 15.sp)),
                                ),
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                        childCount: data.notes?.length ?? 0,
                      ),
                    )
            ],
          );
        }, error: (error, stacktrace) {
          return const ErrorLoading();
        }, loading: () {
          return const Loading();
        });
      }, error: (error, stacktrace) {
        return const ErrorLoading();
      }, loading: () {
        return const Loading();
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
