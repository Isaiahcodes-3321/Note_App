import 'package:flutter/material.dart';
import '../export._home.dart';

class Trash_Page extends StatefulWidget {
  const Trash_Page({super.key});

  @override
  State<Trash_Page> createState() => _Trash_PageState();
}

class _Trash_PageState extends State<Trash_Page> {
  bool onlong_press = true;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(theme_init);
      final title_Trash = ref.watch(title_trash);
      final note_Trash = ref.watch(note_trash);
      final date_Deleted = ref.watch(date_deleted);

      List<String> l_title_Trash = [];
      List<String> l_note_Trash = [];
      List<String> l_date_Deleted = [];

      l_title_Trash.add(title_Trash);
      l_note_Trash.add(note_Trash);
      l_date_Deleted.add(date_Deleted);

      var text_Mode_Color =
          theme ? Backgroundcolor.lightmode : Backgroundcolor.darkhmode;

      return SafeArea(
        child: Scaffold(
          backgroundColor:
              theme ? Backgroundcolor.darkhmode : Backgroundcolor.lightmode,
          appBar: AppBar(
            backgroundColor: themeColor,
            leading: IconButton(
              color: AppTextStyle.appbarTextcolor,
              iconSize: 23.sp,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back_rounded),
            ),
            title: Text(
              'Recycle bin',
              style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp),
            ),
            actions: [
              GestureDetector(
                onTap: () {},
                child: Padding(
                  padding: EdgeInsets.all(15.sp),
                  child: Text(
                    "Empty",
                    style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp),
                  ),
                ),
              )
            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                        itemCount: l_title_Trash.length,
                        itemBuilder: (context, index) {
                          if (index < l_title_Trash.length &&
                              index < l_note_Trash.length &&
                              index < l_date_Deleted.length) {
                            return GestureDetector(
                              onLongPress: () {
                                setState(() {
                                  onlong_press = !onlong_press;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 2.h),
                                child: Column(
                                  children: [
                                    Container(
                                      child: ListTile(
                                        leading: onlong_press
                                            ? Icon(Icons.person, size: 25.sp)
                                            : Icon(Icons.gpp_good_outlined,
                                                size: 25.sp),

                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // tittle
                                            Text(l_title_Trash[index],
                                                style: AppTextStyle.textStyle()
                                                    .copyWith(
                                                  color: text_Mode_Color,
                                                  fontSize: 18.sp,
                                                )),
                                            // Date
                                            FittedBox(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                    l_date_Deleted[index],
                                                    style:
                                                        AppTextStyle.textStyle()
                                                            .copyWith(
                                                      color: text_Mode_Color,
                                                      fontSize: 16.sp,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Note
                                        subtitle: Text(
                                          l_note_Trash[index],
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: text_Mode_Color,
                                    )
                                  ],
                                ),
                              ),
                            );
                          } else {
                            return SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              onlong_press
                  ? Text("")
                  : Container(
                      color: themeColor,
                      width: double.infinity,
                      height: MediaQuery.sizeOf(context).height * 0.10,
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: () {},
                                child: Expanded(
                                    child: Icon(
                                  Icons.replay_outlined,
                                  color: Colors.white,
                                  size: 25.sp,
                                ))),
                            GestureDetector(
                                onTap: () {},
                                child: Expanded(
                                    child: Icon(
                                  Icons.delete_forever,
                                  color: Colors.white,
                                  size: 25.sp,
                                )))
                          ]),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
