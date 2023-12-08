import '../export_note_input.dart';
import '../../HomePage/export_home.dart';

class AddNote extends StatefulWidget {
  const AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  void initState() {
    GlobalControllers.controller = RecorderController();
    GlobalControllers.playerController = PlayerController();
    GlobalControllers.noteContext = TextEditingController();
    GlobalControllers.noteTittleContext = TextEditingController();
    HomePageLogics.checkTokenExpires();
    super.initState();
  }

  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();
  ImageFullScreen imageFullScreen = ImageFullScreen();

  bool isButtonVisible = false;

  @override
  void dispose() {
    GlobalControllers.controller = RecorderController();
    GlobalControllers.playerController = PlayerController();
    GlobalControllers.noteContext = TextEditingController();
    GlobalControllers.noteTittleContext = TextEditingController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
  
        final changeTheme =
        GlobalControllers.providerRef.watch(ThemeClass.themeProvider);
    GlobalControllers.getTheme = changeTheme;
    return Consumer(builder: (context, ref, child) {
      return SafeArea(
        child: Scaffold(
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
                icon: const Icon(Icons.arrow_back_rounded)),
            title: Text('New Notes',
                style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp)),
            actions: [
              GestureDetector(
                  onTap: () async {
                    logics.savedState(context);
                  },
                  child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Text("Save",
                          style: AppTextStyle.textStyle()
                              .copyWith(fontSize: 18.sp))))
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Column(
              children: [
                logics.image != null || logics.recordedAudio.isNotEmpty
                    ? Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            logics.image != null
                                ? Expanded(
                                    flex: 4,
                                    child: SizedBox(
                                      width: MediaQuery.of(context).size.width *
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
                                                              .newNoteFullImage(
                                                                  context)),
                                                );
                                              },
                                              child: Hero(
                                                tag: 'imageTag',
                                                child: Dismissible(
                                                  key: const Key(
                                                      'your_unique_key'),
                                                  onDismissed: (direction) {
                                                    if (direction ==
                                                            DismissDirection
                                                                .endToStart ||
                                                        direction ==
                                                            DismissDirection
                                                                .startToEnd) {
                                                      logics.image = null;
                                                    }
                                                  },
                                                  background:
                                                      GlobalDismissibleContainer
                                                          .container(context),
                                                  child: logics.image != null
                                                      ? Image.file(
                                                          File(logics
                                                              .image!.path),
                                                          width: 100,
                                                          height: 100,
                                                        )
                                                      : Container(),
                                                ),
                                              ))),
                                    ))
                                : const Text(''),
                            logics.recordedAudio.isNotEmpty
                                ? Expanded(
                                    flex: 6,
                                    child: Dismissible(
                                      key: const Key('your_unique_key'),
                                      onDismissed: (direction) {
                                        if (direction ==
                                                DismissDirection.endToStart ||
                                            direction ==
                                                DismissDirection.startToEnd) {
                                          logics.recordedAudio = '';
                                        }
                                      },
                                      background:
                                          GlobalDismissibleContainer.container(
                                              context),
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
                                            padding: const EdgeInsets.all(5),
                                            child: TextButton(
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    MaterialStateProperty.all(
                                                  const Color.fromRGBO(
                                                      42, 42, 92, 1.0),
                                                ),
                                              ),
                                              onPressed: () async {
                                                logics.playAudio(context);
                                              },
                                              child: Text("Play Audio",
                                                  style:
                                                      AppTextStyle.textStyle()
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
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
                  child: TextField(
                    style: AppTextStyle.textStyle().copyWith(
                        color: const Color.fromARGB(255, 28, 28, 28),
                        fontSize: 20.sp),
                    controller: GlobalControllers.noteTittleContext,
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
                    padding: EdgeInsets.only(left: 5.w, right: 5.w, top: 1.h),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Clipboard.setData(ClipboardData(
                                  text: GlobalControllers.noteContext.text));
                            },
                            child: TextFormField(
                              controller: GlobalControllers.noteContext,
                              maxLines: null,
                              decoration: InputDecoration(
                                focusColor: Colors.white,
                                hintText: "Notes",
                                hintStyle: AppTextStyle.textStyle().copyWith(
                                  color: const Color.fromARGB(255, 28, 28, 28),
                                ),
                                focusedBorder: outlineInputBorder,
                                enabledBorder: outlineInputBorder,
                                fillColor:
                                    const Color.fromARGB(255, 238, 238, 238),
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
          ),
          floatingActionButton: Container(
            // color: Colors.black,
            constraints: BoxConstraints(
              minHeight: MediaQuery.sizeOf(context).height * 0.35,
            ),
            child: Stack(
              alignment: Alignment.bottomCenter,
              fit: StackFit.loose,
              children: [
                FloatingActionButton(
                  focusElevation: 30,
                  onPressed: () {
                    setState(() {
                      isButtonVisible = !isButtonVisible;
                    });
                  },
                  backgroundColor: themeColor,
                  child: Icon(
                    isButtonVisible ? Icons.close : Icons.add,
                    color: AppTextStyle.appBarTextColor,
                    size: 25.sp,
                  ),
                ),
                if (isButtonVisible)
                  Positioned(
                    top: 0.h,
                    child: Column(
                      children: [
                        // image button
                        FloatingActionButton(
                          onPressed: () {
                            logics.showImagePickerOptions(context);
                          },
                          backgroundColor: themeColor,
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: AppTextStyle.appBarTextColor,
                            size: 25.sp,
                          ),
                        ),
                        SizedBox(height: 3.h),
                        // audio button
                        FloatingActionButton(
                          onPressed: () {
                            logics.showAudioOptions(context);
                          },
                          backgroundColor: themeColor,
                          child: Icon(
                            Icons.audiotrack_outlined,
                            color: AppTextStyle.appBarTextColor,
                            size: 25.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ),
      );
    });
  }
}
