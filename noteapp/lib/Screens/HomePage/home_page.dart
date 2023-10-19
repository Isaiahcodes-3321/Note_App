import 'package:flutter/material.dart';
import 'package:noteapp/Constant/global_controllers.dart';
import 'export_home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
 

  bool isButtonVisible = false;

  final globalKey = GlobalKey();
  bool isSearching = false;
  var textModeColor;
  bool onlongPress = true;
  List<bool> itemLongPressedStates = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
         providerRef = ref;
        // String noteBodyValue = ref.read(noteBody.notifier).state;
        // String noteTittleValue = ref.read(noteTittle.notifier).state;

        var currentTheme = ref.watch(themeInit);
        var textModeColor = currentTheme
            ? Backgroundcolor.lightmode
            : Backgroundcolor.darkhmode;

        return SafeArea(
          child: Scaffold(
              backgroundColor: currentTheme
                  ? Backgroundcolor.darkhmode
                  : Backgroundcolor.lightmode,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    backgroundColor: themeColor,
                    flexibleSpace: FlexibleSpaceBar(
                      title: isSearching
                          ? Container(
                              width: MediaQuery.sizeOf(context).width * 0.55,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                      color: AppTextStyle.appbarTextcolor),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: AppTextStyle.appbarTextcolor),
                              ),
                            )
                          : Text('Notes', style: AppTextStyle.textStyle()),
                    ),
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: AppTextStyle.appbarTextcolor,
                            size: 23.sp,
                          ),
                          onPressed: () {
                            Scaffold.of(context).openDrawer();
                          },
                        );
                      },
                    ),
                    actions: [
                      IconButton(
                        icon: Icon(
                          isSearching ? Icons.cancel_outlined : Icons.search,
                          color: AppTextStyle.appbarTextcolor,
                          size: 23.sp,
                        ),
                        onPressed: () {
                          setState(() {
                            isSearching = !isSearching;
                          });
                        },
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: 
                    // noteTittleValue.isNotEmpty ?
                     Text("GlobalControllers.noteBodyValue")
                        // : Text("no note"),
                  ),
                ],
              ),
              drawer: Drawer(
                  // Take 70% of the user screen
                  backgroundColor: currentTheme
                      ? Color.fromARGB(255, 36, 36, 38)
                      : Backgroundcolor.lightmode,
                  width: MediaQuery.sizeOf(context).width * 0.70,
                  child: MyDrawer()),
              floatingActionButton: onlongPress
                  ? FloatingActionButton(
                      focusElevation: 30,
                      onPressed: () {
                        Navigator.push<void>(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => AddNote(),
                          ),
                        );
                      },
                      backgroundColor: themeColor,
                      child: Icon(
                        Icons.add,
                        color: AppTextStyle.appbarTextcolor,
                        size: 25.sp,
                      ))
                  : FloatingActionButton(
                      focusElevation: 30,
                      onPressed: () {},
                      backgroundColor: themeColor,
                      child: Icon(
                        Icons.delete_forever,
                        color: AppTextStyle.appbarTextcolor,
                        size: 25.sp,
                      ))),
        );
      },
    );
  }
}















//  SliverGrid(
//                     gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                       crossAxisCount: 2,
                      
//                     ),
//                     delegate: SliverChildBuilderDelegate(
//                       (BuildContext context, int index) {
//                         return GestureDetector(
//                           onTap: () {
//                             Navigator.push<void>(
//                               context,
//                               MaterialPageRoute<void>(
//                                 builder: (BuildContext context) => AddNote(),
//                               ),
//                             );
//                           },
//                           onLongPress: () {
//                             setState(() {
//                               onlongPress = !onlongPress;
//                               itemLongPressedStates[index] =
//                                   !itemLongPressedStates[index];
//                             });
//                           },
//                           child: Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 borderRadius: BorderRadius.circular(10),
//                                 color: itemLongPressedStates[index]
//                                     ? Colors.red
//                                     : Colors.green,
//                               ),
//                               width: MediaQuery.of(context).size.width * 0.40,
//                               height: MediaQuery.of(context).size.width * 0.30,
//                               child: Padding(
//                                 padding: EdgeInsets.symmetric(
//                                     horizontal: 3.w, vertical: 2.h),
//                                 child: Column(
//                                   children: [
//                                     // Title
//                                     Text(tittleAdded,
//                                         style:
//                                             AppTextStyle.textStyle().copyWith(
//                                           color: textModeColor,
//                                           fontSize: 20.sp,
//                                           overflow: TextOverflow.ellipsis,
//                                         )),
//                                     SizedBox(
//                                       height: 3.h,
//                                     ),
//                                     // Note body
//                                     Text(noteAdded,
//                                         maxLines: 3,
//                                         style:
//                                             AppTextStyle.textStyle().copyWith(
//                                           color: textModeColor,
//                                           fontSize: 18.sp,
//                                           overflow: TextOverflow.ellipsis,
//                                         )),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                           ),
//                         );
//                       },
//                       childCount: 3,
//                     ),
//                   )