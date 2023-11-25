import '../export_home.dart';
import 'package:flutter/material.dart';
import '../../Api_Service/emptyTrash.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => TrashPageState();
}

class TrashPageState extends State<TrashPage> {
  bool onTap = true;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeInit);
      final titleTrashB = ref.watch(titleTrash);
      final noteTrashB = ref.watch(noteTrash);
      final dateDeletedB = ref.watch(dateDeleted);

      List<String> ltitleTrash = [];
      List<String> lnoteTrash = [];
      List<String> ldateDeleted = [];

      ltitleTrash.add(titleTrashB);
      lnoteTrash.add(noteTrashB);
      ldateDeleted.add(dateDeletedB);

      var textModeColor =
          theme ? BackgroundColor.lightMode : BackgroundColor.darkMode;

      return SafeArea(
        child: Scaffold(
          backgroundColor:
              theme ? BackgroundColor.darkMode : BackgroundColor.lightMode,
          appBar: AppBar(
            backgroundColor: themeColor,
            leading: IconButton(
              color: AppTextStyle.appBarTextColor,
              iconSize: 23.sp,
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(Icons.arrow_back_rounded),
            ),
            title: Text(
              'Recycle bin',
              style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp),
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  EmptyTrash.emptyNote();
                },
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
                                    ListTile(
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
                                        style: const TextStyle(
                                          overflow: TextOverflow.ellipsis,
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
                            return const SizedBox();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              onTap
                  ? const Text("")
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
