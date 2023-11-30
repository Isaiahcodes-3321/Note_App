import 'loadingNote.dart';
import 'errorLoading.dart';
import '../export_home.dart';
import '../../Add_Note/Note.dart/upDateNote.dart';
import '../DrawerAndFloatingButton.dart/drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
  DrawerAndFloatingButton drawerAndFloatingButton = DrawerAndFloatingButton();
  @override
  void initState() {
    super.initState();
    HomePageLogics.checkTokenExpires();
  }

  @override
  Widget build(BuildContext context) {
    GlobalControllers.providerRef = ref;

    return Scaffold(
      body: ref.watch(userNewNoteFromDB.noteItems).when(data: (data) {
        return CustomScrollView(
          slivers: [
            const MyAppBar(),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
                  final note = data.notes?[index];
                  String userNoteId = note!.noteId ?? '';
                  int userNoteIdINT = int.tryParse(userNoteId) ?? 0;

                  String formattedDate = HomePageLogics.formatDate(note.date);

                  return Padding(
                    padding: EdgeInsets.all(15.sp),
                    child: GestureDetector(
                      onTap: () {
                        GlobalControllers.id = userNoteIdINT;
                        print('User note Id its $userNoteIdINT');
                        ReadUserNote.readNote();
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => const UpdatePage(),
                          ),
                        );
                      },
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
                                  color: const Color.fromARGB(255, 8, 8, 43),
                                  fontSize: 17.sp)),
                          trailing: Text(formattedDate,
                              style: AppTextStyle.textStyle().copyWith(
                                  color: Colors.red, fontSize: 15.sp)),
                        ),
                      ),
                    ),
                  );
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
      }),
      floatingActionButton: drawerAndFloatingButton.floatingButton(context),
      drawer: drawerAndFloatingButton.drawer(context),
    );
  }
}
