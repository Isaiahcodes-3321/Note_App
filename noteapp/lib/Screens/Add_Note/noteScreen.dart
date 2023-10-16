import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'controller.dart';
import 'export_note_input.dart';
import 'package:image_picker/image_picker.dart';

class AddNote extends StatefulWidget {
  AddNote({super.key});

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  final TextEditingController note_context = TextEditingController();
  bool isButtonVisible = false;

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
                        builder: (BuildContext context) => Note_Input(),
                      ),
                    );
                  },
                  icon: Icon(Icons.arrow_back_rounded)),
              title: Text('New Notes',
                  style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp)),
              actions: [
                GestureDetector(
                    onTap: () async {
                      connectionCheck.showBanner(context);
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
                  Expanded(
                    flex: 2,
                    child: Container(
                        width: double.infinity,
                        color: Colors.green,
                        // height: 15.h,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  // Image
                                ],
                              ),
                            ),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  //  Audio
                                ],
                              ),
                            ),
                          ],
                        )),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: 20.sp, vertical: 20.sp),
                    child: TextField(
                      style: AppTextStyle.textStyle().copyWith(
                          color: const Color.fromARGB(255, 28, 28, 28),
                          fontSize: 20.sp),
                      controller: TextEditingController(),
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
                          FloatingActionButton(
                            onPressed: () {},
                            backgroundColor: themeColor,
                            child: Icon(
                              Icons.camera_alt_outlined,
                              color: AppTextStyle.appbarTextcolor,
                              size: 25.sp,
                            ),
                          ),
                          SizedBox(height: 3.h),
                          FloatingActionButton(
                            onPressed: () {},
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
