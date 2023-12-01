import '../export_home.dart';
import 'package:flutter/material.dart';
import '../../Api_Service/emptyTrash.dart';

class TrashPage extends StatefulWidget {
  const TrashPage({super.key});

  @override
  State<TrashPage> createState() => TrashPageState();
}

class TrashPageState extends State<TrashPage> {
  UserNewNoteFromDB userNewNoteFromDB = UserNewNoteFromDB();

  bool onTap = true;
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      return SafeArea(
        child: Scaffold(
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
              ref.watch(userNewNoteFromDB.trashItems).when(
                  data: (trashData) {
                      ListView.builder(
                        shrinkWrap: true,
                        reverse: true,
                  itemCount: trashData.notes?.length ?? 0,
                  itemBuilder: (context, index) {
                    final note = trashData.notes?[index];
                   if(index < trashData.notes!.length){
                      String formattedDate =
                          HomePageLogics.formatDate(note?.date);
                          print('Note title ${note?.title}');

                      return Padding(
                        padding: EdgeInsets.all(15.sp),
                        child: Card(
                          child: ListTile(
                            title: Text(note?.title ?? '',
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyle.textStyle().copyWith(
                                  color: themeColor,
                                )),
                            subtitle: Text(
                              note?.note ?? '',
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyle.textStyle().copyWith(
                                color: const Color.fromARGB(255, 8, 8, 43),
                                fontSize: 17.sp,
                              ),
                            ),
                            trailing: Text(
                              formattedDate,
                              style: AppTextStyle.textStyle().copyWith(
                                color: Colors.red,
                                fontSize: 15.sp,
                              ),
                            ),
                          ),
                        ),
                      );
                   }
                   return null;
                  },
                );
                 return const SizedBox();
                  },
                  error: (error, stacktrace) {
                    return const Expanded(
                        flex: 8,
                        child: Center(
                          child: Text("some error occurred "),
                        ));
                  },
                  loading: () {
                    return Expanded(
                      flex: 8,
                      child: Center(
                        child: SpinKitChasingDots(
                          color: themeColor,
                          size: 40.sp,
                        ),
                      ),
                    );
                  }),
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
