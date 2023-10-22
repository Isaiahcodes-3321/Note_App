import 'package:flutter/material.dart';
import '../export_home.dart';

class Trash_Page extends StatefulWidget {
  const Trash_Page({super.key});

  @override
  State<Trash_Page> createState() => _Trash_PageState();
}

class _Trash_PageState extends State<Trash_Page> {
  bool onTap = true;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeInit);
      final title_Trash = ref.watch(titleTrash);
      final note_Trash = ref.watch(noteTrash);
      final date_Deleted = ref.watch(dateDeleted);

      List<String> ltitleTrash = [];
      List<String> lnoteTrash = [];
      List<String> ldateDeleted = [];

      ltitleTrash.add(title_Trash);
      lnoteTrash.add(note_Trash);
      ldateDeleted.add(date_Deleted);

      var textModeColor =
          theme ? Backgroundcolor.lightmode : Backgroundcolor.darkmode;

      return SafeArea(
        child: Scaffold(
          backgroundColor:
              theme ? Backgroundcolor.darkmode : Backgroundcolor.lightmode,
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
                        itemCount: ltitleTrash.length,
                        itemBuilder: (context, index) {
                          if (index < ltitleTrash.length &&
                              index < lnoteTrash.length &&
                              index < ldateDeleted.length) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  onTap = !onTap;
                                });
                              },
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 5.w, vertical: 2.h),
                                child: Column(
                                  children: [
                                    Container(
                                      child: ListTile(
                                        leading: onTap
                                            ? Icon(Icons.person, size: 25.sp)
                                            : Icon(Icons.gpp_good_outlined,
                                                size: 25.sp),

                                        title: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            // tittle
                                            Text(ltitleTrash[index],
                                                style: AppTextStyle.textStyle()
                                                    .copyWith(
                                                  color: textModeColor,
                                                  fontSize: 18.sp,
                                                )),
                                            // Date
                                            FittedBox(
                                              child: Align(
                                                alignment: Alignment.bottomLeft,
                                                child: Text(
                                                    ldateDeleted[index],
                                                    style:
                                                        AppTextStyle.textStyle()
                                                            .copyWith(
                                                      color: textModeColor,
                                                      fontSize: 16.sp,
                                                    )),
                                              ),
                                            ),
                                          ],
                                        ),
                                        // Note
                                        subtitle: Text(
                                          lnoteTrash[index],
                                          maxLines: 2,
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      color: textModeColor,
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
              onTap
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
