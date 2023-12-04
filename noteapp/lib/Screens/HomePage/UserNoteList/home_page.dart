import 'loadingNote.dart';
import 'errorLoading.dart';
import '../export_home.dart';
import '../../Api_Service/delete.dart';
import '../../Api_Service/readNote.dart';
import '../../Add_Note/Note.dart/upDateNote.dart';
import '../DrawerAndFloatingButton.dart/drawer.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  Delete delete = Delete();
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
  DrawerAndFloatingButton drawerAndFloatingButton = DrawerAndFloatingButton();
  @override
  void initState() {
    super.initState();
    // GlobalControllers.id = 0;
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

                  return Dismissible(
                    key: const Key('your_unique_key'),
                    onDismissed: (direction) {
                      if (direction == DismissDirection.endToStart ||
                          direction == DismissDirection.startToEnd) {
                        String userNoteId = note.noteId ?? '';
                        int userNoteIdINT = int.tryParse(userNoteId) ?? 0;
                        GlobalControllers.id = userNoteIdINT;
                        delete.deleteNote(context);
                      }
                    },
                    background: GlobalDismissibleContainer.container(context),
                    child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: GestureDetector(
                        onTap: () {
                          GlobalControllers.id = userNoteIdINT;
                          print('User note Id its $userNoteIdINT');
                          ReadUserNote.readNote();
                         
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
