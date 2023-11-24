import 'export_home.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();

  @override
  Widget build(BuildContext context) {
    //  var currentTheme = GlobalControllers.providerRef.watch(themeInit);
    GlobalControllers.providerRef = ref;
    return Scaffold(
      body: ref.watch(userNewNoteFromDB.noteItems).when(data: (data) {
        return CustomScrollView(
          slivers: [
            const MyAppBar(),
            // display notes
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final note = data.notes![index];
                  String formattedDate = FormatDate.formatDate(note.date);

                  return Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: GestureDetector(
                      onTap: () {},
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
                    ),
                  );
                },
                childCount: data.notes!.length,
              ),
            )
          ],
        );
      }, error: (erorr, stacktrace) {
        return const SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                Expanded(
                  flex: 2,
                  child: CustomScrollView(
                    slivers: [MyAppBar()],
                  ),
                ),
                Expanded(
                    flex: 8,
                    child: Center(
                      child: Text("some error occurred "),
                    ))
              ],
            ));
      }, loading: () {
        return SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Column(
              children: [
                const Expanded(
                  flex: 2,
                  child: CustomScrollView(
                    slivers: [MyAppBar()],
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: Center(
                    child: SpinKitChasingDots(
                      color: themeColor,
                      size: 40.sp,
                    ),
                  ),
                ),
              ],
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
