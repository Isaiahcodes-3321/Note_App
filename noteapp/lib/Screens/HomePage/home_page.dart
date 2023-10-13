import 'package:flutter/material.dart';
import 'export._home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final globalKey = GlobalKey();
  bool isSearching = false;
  var text_Mode_Color;
  bool onlong_press = true;
  List<bool> itemLongPressedStates = [false, false, false];

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final theme = ref.watch(themeProvider);
        final title_added = ref.watch(title_Note);
        final note_added = ref.watch(note_Note);
        text_Mode_Color =
            theme ? Backgroundcolor.lightmode : Backgroundcolor.darkhmode;

        return SafeArea(
          child: Scaffold(
              backgroundColor:
                  theme ? Backgroundcolor.darkhmode : Backgroundcolor.lightmode,
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
                  SliverGrid(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (BuildContext context, int index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push<void>(
                              context,
                              MaterialPageRoute<void>(
                                builder: (BuildContext context) => AddNote(),
                              ),
                            );
                          },
                          onLongPress: () {
                            setState(() {
                              onlong_press = !onlong_press;
                               itemLongPressedStates[index] = !itemLongPressedStates[index];
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                 color: itemLongPressedStates[index] ? Colors.red : Colors.green,
                              ),
                              width: MediaQuery.of(context).size.width * 0.40,
                              height: MediaQuery.of(context).size.width * 0.30,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 1.w, vertical: 2.h),
                                child: Column(
                                  children: [
                                    // Title
                                    Text(title_added,
                                        style:
                                            AppTextStyle.textStyle().copyWith(
                                          color: text_Mode_Color,
                                          fontSize: 20.sp,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                    SizedBox(
                                      height: 3.h,
                                    ),
                                    Text(note_added,
                                        maxLines: 3,
                                        style:
                                            AppTextStyle.textStyle().copyWith(
                                          color: text_Mode_Color,
                                          fontSize: 18.sp,
                                          overflow: TextOverflow.ellipsis,
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      childCount: 3,
                    ),
                  )
                ],
              ),
              drawer: Drawer(
                  // Take 70% of the user screen
                  backgroundColor: theme
                      ? Color.fromARGB(255, 36, 36, 38)
                      : Backgroundcolor.lightmode,
                  width: MediaQuery.sizeOf(context).width * 0.70,
                  child: MyDrawer()),
              floatingActionButton: onlong_press
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
