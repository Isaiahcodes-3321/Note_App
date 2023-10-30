import 'package:flutter/material.dart';
import 'export_home.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  bool isSearching = false;
  var textModeColor;
  // bool onlongPress = true;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        GlobalControllers.providerRef = ref;

        String noteBodyValue =
            GlobalControllers.providerRef.read(noteBody.notifier).state;
        String noteTittleValue =
            GlobalControllers.providerRef.read(noteTittle.notifier).state;

        var currentTheme = GlobalControllers.providerRef.watch(themeInit);
        var textModeColor =
            currentTheme ? Backgroundcolor.lightmode : Backgroundcolor.darkmode;

        var listTilebackground = currentTheme
            ? Color.fromARGB(255, 54, 54, 56)
            : Color.fromARGB(255, 143, 143, 179);

        return SafeArea(
          child: Scaffold(
              backgroundColor: currentTheme
                  ? Backgroundcolor.darkmode
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
                    child: noteTittleValue.isNotEmpty
                        ? Container(
                            width: MediaQuery.sizeOf(context).width * 100.0,
                            height: MediaQuery.sizeOf(context).width * 100.0,
                            child: Padding(
                                padding: EdgeInsets.all(20),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Dismissible(
                                        key: Key('your_unique_key'),
                                        onDismissed: (direction) {
                                          if (direction ==
                                                  DismissDirection.endToStart ||
                                              direction ==
                                                  DismissDirection.startToEnd) {
                                            GlobalControllers.providerRef
                                                .read(noteBody.notifier)
                                                .state = '';
                                            GlobalControllers.providerRef
                                                .read(noteTittle.notifier)
                                                .state = '';
                                          }
                                        },
                                        background: GlobalDismissibleContainer.container(context),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(22),
                                            color: listTilebackground,
                                          ),
                                          child: ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                // Title
                                                Expanded( flex: 8,
                                                  child: Text(
                                                    noteTittleValue,
                                                     overflow: TextOverflow.ellipsis,
                                                    style:
                                                        AppTextStyle.textStyle()
                                                            .copyWith(
                                                      color: textModeColor,
                                                      fontSize: 20.sp,
                                                    ),
                                                  ),
                                                ),
                                                // Expanded( flex: 2,
                                                //   child: Align(alignment: Alignment.centerRight,
                                                //     child: Text("9 oct 2023",style: TextStyle(fontSize: 20))))
                                              ],
                                            ),
                                            // Note
                                            subtitle: Text(
                                              noteBodyValue,
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                              style: AppTextStyle.textStyle()
                                                  .copyWith(
                                                color: textModeColor,
                                                fontSize: 15.sp,
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                          )
                        : Text(""),
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
              floatingActionButton: FloatingActionButton(
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
                  ))),
        );
      },
    );
  }
}
