import 'package:flutter/material.dart';
import 'export_note_input.dart';

class AddNote extends StatefulWidget {
  AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  @override
  void initState() {
    controller = RecorderController();
    player_controller = PlayerController();
    super.initState();
  }

  final TextEditingController note_context = TextEditingController();
  final TextEditingController note_title_context = TextEditingController();

  bool isButtonVisible = false;

  void dispose() {
    controller = RecorderController();
    player_controller = PlayerController();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      var current_theme = ref.watch(theme_init);
      var text_Mode_Color =
          current_theme ? Backgroundcolor.lightmode : Backgroundcolor.darkhmode;

      return SafeArea(
        child: Scaffold(
            backgroundColor: current_theme
                ? Backgroundcolor.darkhmode
                : Backgroundcolor.lightmode,
            appBar: AppBar(
              backgroundColor: themeColor,
              leading: IconButton(
                  color: AppTextStyle.appbarTextcolor,
                  iconSize: 23.sp,
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => HomePage(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_back_rounded)),
              title: Text('New Notes',
                  style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp)),
              actions: [
                GestureDetector(
                    onTap: () async {
                      logics.showBanner(context);
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
                  logics.image != null || logics.recordedAudioFile.isNotEmpty
                      ? Padding(
                          padding:
                              EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              logics.image != null
                                  ? Expanded(
                                      flex: 4,
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                                          Image_full_screen(),
                                                    ),
                                                  );
                                                },
                                                child: Hero(
                                                  tag: 'imageTag',
                                                  child: Dismissible(
                                                    key: Key('your_unique_key'),
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
                                                    background: Container(
                                                      color: Colors.red,
                                                      alignment:
                                                          Alignment.center,
                                                      child: Icon(Icons.delete,
                                                          size: 30.sp,
                                                          color: Colors.white),
                                                    ),
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
                                  : Text(''),
                              logics.recordedAudioFile.isNotEmpty
                                  ? Expanded(
                                      flex: 6,
                                      child: Dismissible(
                                        key: Key('your_unique_key'),
                                        onDismissed: (direction) {
                                          if (direction ==
                                                  DismissDirection.endToStart ||
                                              direction ==
                                                  DismissDirection.startToEnd) {
                                            logics.recordedAudioFile = '';
                                          }
                                        },
                                        background: Container(
                                          color: Colors.red,
                                          alignment: Alignment.center,
                                          child: Icon(Icons.delete,
                                              size: 30.sp, color: Colors.white),
                                        ),
                                        child: Center(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              border: Border.all(
                                                color: Color.fromRGBO(
                                                    42, 42, 92, 1.0),
                                                width: 3.0,
                                              ),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(6),
                                              child: TextButton(
                                                style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty.all(
                                                    Color.fromRGBO(
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
                                                                fontSize:
                                                                    18.sp)),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    )
                                  : Text('')
                            ],
                          ),
                        )
                      : Text(""),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 20.sp),
                    child: TextField(
                      style: AppTextStyle.textStyle().copyWith(
                          color: const Color.fromARGB(255, 28, 28, 28),
                          fontSize: 20.sp),
                      controller: note_title_context,
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
                                Clipboard.setData(
                                    ClipboardData(text: note_context.text));
                              },
                              child: TextFormField(
                                controller: note_context,
                                maxLines: null,
                                decoration: InputDecoration(
                                  focusColor: Colors.white,
                                  hintText: "Notes",
                                  hintStyle: AppTextStyle.textStyle().copyWith(
                                    color:
                                        const Color.fromARGB(255, 28, 28, 28),
                                  ),
                                  focusedBorder: outlineInputBorder,
                                  enabledBorder: outlineInputBorder,
                                  fillColor: Color.fromARGB(255, 238, 238, 238),
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
                minHeight: 30.h,
              ),
              child: Stack(
                alignment: Alignment.bottomCenter,
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
                      color: AppTextStyle.appbarTextcolor,
                      size: 25.sp,
                    ),
                  ),
                  if (isButtonVisible)
                    Positioned(
                      top: 1,
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
                              color: AppTextStyle.appbarTextcolor,
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
                              color: AppTextStyle.appbarTextcolor,
                              size: 25.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            )),
      );
    });
  }
}


















