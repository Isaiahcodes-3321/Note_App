import '../export_note_input.dart';
import '../../HomePage/export_home.dart';

class UpdatePage extends StatefulWidget {
  const UpdatePage({super.key});

  @override
  State<UpdatePage> createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  @override
  void initState() {
    UpdateControllers.noteTittleContext = TextEditingController();
    UpdateControllers.noteContext = TextEditingController();
    HomePageLogics.checkTokenExpires();
    super.initState();
  }

  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
  ImageFullScreen imageFullScreen = ImageFullScreen();

  @override
  void dispose() {
    UpdateControllers.noteTittleContext = TextEditingController();
    UpdateControllers.noteContext = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

      GlobalControllers.backGroundThemeColor = GlobalControllers.getTheme
        ? BackgroundColor.themeColorDarkMode
        : BackgroundColor.lightMode;
    GlobalControllers.textThemeColor = GlobalControllers.getTheme
        ? BackgroundColor.lightMode
        : BackgroundColor.darkMode;
    return Consumer(builder: (context, ref, child) {
      GlobalControllers.providerRef = ref;
      return SafeArea(
        child: Scaffold(
          backgroundColor: GlobalControllers.backGroundThemeColor,
          // backgroundColor: BackgroundColor.lightMode,
          appBar: AppBar(
            backgroundColor: themeColor,
            leading: IconButton(
                color: AppTextStyle.appBarTextColor,
                iconSize: 23.sp,
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
                icon: const Icon(Icons.arrow_back_rounded)),
            title: Text('New Notes',
                style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp)),
            actions: [
              GestureDetector(
                  onTap: () async {
                    logics.updateNote(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Text("Save",
                          style: AppTextStyle.textStyle()
                              .copyWith(fontSize: 18.sp))))
            ],
          ),
          body: Consumer(builder: (context, ref, child) {
            return ref.watch(userNewNoteFromDB.readNoteItems).when(
                data: (data) {
              final note = data.notes;
              var getTittle = note?.first.title;
              var getNote = note?.first.note;
              String? getId = note!.first.noteId;
              UpdateControllers.image = note.first.image;

              int? pushId = int.tryParse(getId!);
              UpdateControllers.id = pushId!;
              print('note id when updating $pushId');

              UpdateControllers.noteTittleContext.text = getTittle ?? '';
              UpdateControllers.noteContext.text = getNote ?? '';

              return SizedBox(
                height: double.infinity,
                width: double.infinity,
                child: Column(
                  children: [
                    UpdateControllers.image != null ||
                            logics.recordedAudio.isNotEmpty
                        ? Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                UpdateControllers.image != null
                                    ? Expanded(
                                        flex: 4,
                                        child: SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.30,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: InkWell(
                                                onTap: () {
                                                  Navigator.push<void>(
                                                    context,
                                                    MaterialPageRoute<void>(
                                                      builder: (BuildContext
                                                              context) =>
                                                          imageFullScreen
                                                              .updateNoteFullImage(
                                                                  context),
                                                    ),
                                                  );
                                                },
                                                child: Stack(
                                                  children: [
                                                    Hero(
                                                      tag: 'imageTagUpdate',
                                                      child: UpdateControllers
                                                              .image.isNotEmpty
                                                          ? Image.network(
                                                              UpdateControllers
                                                                  .image,
                                                              width: 100,
                                                              height: 100,
                                                              loadingBuilder:
                                                                  (BuildContext
                                                                          context,
                                                                      Widget
                                                                          child,
                                                                      ImageChunkEvent?
                                                                          loadingProgress) {
                                                                if (loadingProgress ==
                                                                    null) {
                                                                  return child;
                                                                } else {
                                                                  return Center(
                                                                    child:
                                                                        SpinKitChasingDots(
                                                                      color:
                                                                          themeColor,
                                                                      size:
                                                                          25.sp,
                                                                    ),
                                                                  );
                                                                }
                                                              },
                                                            )
                                                          : Container(),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ))
                                    : const Text(''),
                                logics.recordedAudio.isNotEmpty
                                    ? Expanded(
                                        flex: 6,
                                        child: Dismissible(
                                          key: const Key('your_unique_key'),
                                          onDismissed: (direction) {
                                            if (direction ==
                                                    DismissDirection
                                                        .endToStart ||
                                                direction ==
                                                    DismissDirection
                                                        .startToEnd) {
                                              logics.recordedAudio = '';
                                            }
                                          },
                                          background: GlobalDismissibleContainer
                                              .container(context),
                                          child: Center(
                                            child: Container(
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(35),
                                                border: Border.all(
                                                  color: const Color.fromRGBO(
                                                      42, 42, 92, 1.0),
                                                  width: 3.0,
                                                ),
                                              ),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(5),
                                                child: TextButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStateProperty
                                                            .all(
                                                      const Color.fromRGBO(
                                                          42, 42, 92, 1.0),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    logics.playAudio(context);
                                                  },
                                                  child: Text("Play Audio",
                                                      style: AppTextStyle
                                                              .textStyle()
                                                          .copyWith(
                                                              fontSize: 18.sp)),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      )
                                    : const Text('')
                              ],
                            ),
                          )
                        : const Text(""),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: 20.sp, vertical: 20.sp),
                      child: TextField(
                        style: AppTextStyle.textStyle().copyWith(
                            color: const Color.fromARGB(255, 28, 28, 28),
                            fontSize: 20.sp),
                        controller: UpdateControllers.noteTittleContext,
                        decoration: InputDecoration(
                          focusColor: Colors.white,
                          hintText: "Note title",
                          hintStyle: AppTextStyle.textStyle().copyWith(
                            color: const Color.fromARGB(255, 28, 28, 28),
                          ),
                          focusedBorder: outlineInputBorder,
                          enabledBorder: outlineInputBorder,
                          fillColor: const Color.fromARGB(255, 200, 200, 200),
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 7,
                      child: Padding(
                        padding:
                            EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Clipboard.setData(ClipboardData(
                                      text:
                                          GlobalControllers.noteContext.text));
                                },
                                child: TextFormField(
                                  controller: UpdateControllers.noteContext,
                                  maxLines: null,
                                  decoration: InputDecoration(
                                    focusColor: Colors.white,
                                    hintText: "Notes",
                                    hintStyle:
                                        AppTextStyle.textStyle().copyWith(
                                      color:
                                          const Color.fromARGB(255, 28, 28, 28),
                                    ),
                                    focusedBorder: outlineInputBorder,
                                    enabledBorder: outlineInputBorder,
                                    fillColor: const Color.fromARGB(
                                        255, 238, 238, 238),
                                    filled: true,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }, error: (error, stacktrace) {
              return const Center(
                child: Text("some error occurred "),
              );
            }, loading: () {
              return Center(
                child: SpinKitChasingDots(
                  color: themeColor,
                  size: 40.sp,
                ),
              );
            });
          }),
        ),
      );
    });
  }
}
