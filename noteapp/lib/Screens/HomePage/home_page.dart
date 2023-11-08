import 'dart:async';

import 'package:flutter/material.dart';
import '../Api_Service/refreshTokenService.dart';
import '../Api_Service/timer.dart';
import 'export_home.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CountdownManager countdownManager = CountdownManager();
  RefreshTokenService refreshTokenService = RefreshTokenService();

  bool isSearching = false;
  void initState() {
    super.initState();
    // CountdownManager.isCountdownActive;
    checkIfTokenExpires();
  }

  void checkIfTokenExpires() {
    Timer.periodic(const Duration(seconds: 1), (Timer timer) {
      final remainingTime = countdownManager.getRemainingTime();

      if (remainingTime <= const Duration(seconds: 5) ||
          remainingTime >= const Duration(minutes: 55)) {
        // If the remaining time is less than 5 seconds or at 55 minutes, perform the token refresh
        refreshTokenService.reFreshToken(context);
        countdownManager.cancelCountdown();
        countdownManager.startOneHourCountdown();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        GlobalControllers.providerRef = ref;

        // String noteBodyValue =
        //     GlobalControllers.providerRef.read(UserNewNotes.noteBody.notifier).state;
        // String noteTittleValue =
        //     GlobalControllers.providerRef.read(UserNewNotes.noteTittle.notifier).state;

        var currentTheme = GlobalControllers.providerRef.watch(themeInit);
        var textModeColor =
            currentTheme ? BackgroundColor.lightMode : BackgroundColor.darkMode;

        var listTileBackGround = currentTheme
            ? const Color.fromARGB(255, 54, 54, 56)
            : const Color.fromARGB(255, 143, 143, 179);

        return SafeArea(
          child: Scaffold(
              backgroundColor: currentTheme
                  ? BackgroundColor.darkMode
                  : BackgroundColor.lightMode,
              body: CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    snap: true,
                    backgroundColor: themeColor,
                    flexibleSpace: FlexibleSpaceBar(
                      title: isSearching
                          ? SizedBox(
                              width: MediaQuery.sizeOf(context).width * 0.55,
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search...',
                                  hintStyle: TextStyle(
                                      color: AppTextStyle.appBarTextColor),
                                  border: InputBorder.none,
                                ),
                                style: TextStyle(
                                    color: AppTextStyle.appBarTextColor),
                              ),
                            )
                          : Text('Notes', style: AppTextStyle.textStyle()),
                    ),
                    leading: Builder(
                      builder: (BuildContext context) {
                        return IconButton(
                          icon: Icon(
                            Icons.menu,
                            color: AppTextStyle.appBarTextColor,
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
                          color: AppTextStyle.appBarTextColor,
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
                  // SliverToBoxAdapter(
                  //   child: noteTittleValue.isNotEmpty
                  //       ? SizedBox(
                  //           width: MediaQuery.sizeOf(context).width * 100.0,
                  //           height: MediaQuery.sizeOf(context).width * 100.0,
                  //           child: Padding(
                  //               padding: const EdgeInsets.all(20),
                  //               child: SingleChildScrollView(
                  //                 child: Column(
                  //                   children: [
                  //                     Dismissible(
                  //                       key: const Key('your_unique_key'),
                  //                       onDismissed: (direction) {
                  //                         if (direction ==
                  //                                 DismissDirection.endToStart ||
                  //                             direction ==
                  //                                 DismissDirection.startToEnd) {
                  //                           GlobalControllers.providerRef
                  //                               .read(UserNewNotes.noteBody.notifier)
                  //                               .state = '';
                  //                           GlobalControllers.providerRef
                  //                               .read(UserNewNotes.noteTittle.notifier)
                  //                               .state = '';
                  //                         }
                  //                       },
                  //                       background: GlobalDismissibleContainer.container(context),
                  //                       child: Container(
                  //                         decoration: BoxDecoration(
                  //                           borderRadius:
                  //                               BorderRadius.circular(22),
                  //                           color: listTileBackGround,
                  //                         ),
                  //                         child: ListTile(
                  //                           title: Row(
                  //                             mainAxisAlignment:
                  //                                 MainAxisAlignment
                  //                                     .spaceBetween,
                  //                             children: [
                  //                               // Title
                  //                               Expanded( flex: 8,
                  //                                 child: Text(
                  //                                   noteTittleValue,
                  //                                    overflow: TextOverflow.ellipsis,
                  //                                   style:
                  //                                       AppTextStyle.textStyle()
                  //                                           .copyWith(
                  //                                     color: textModeColor,
                  //                                     fontSize: 20.sp,
                  //                                   ),
                  //                                 ),
                  //                               ),
                  //                               // Expanded( flex: 2,
                  //                               //   child: Align(alignment: Alignment.centerRight,
                  //                               //     child: Text("9 oct 2023",style: TextStyle(fontSize: 20))))
                  //                             ],
                  //                           ),
                  //                           // Note
                  //                           subtitle: Text(
                  //                             noteBodyValue,
                  //                             maxLines: 2,
                  //                             overflow: TextOverflow.ellipsis,
                  //                             style: AppTextStyle.textStyle()
                  //                                 .copyWith(
                  //                               color: textModeColor,
                  //                               fontSize: 15.sp,
                  //                             ),
                  //                           ),
                  //                         ),
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               )),
                  //         )
                  //       : const Text(""),
                  // ),
                ],
              ),
              drawer: Drawer(
                  // Take 70% of the user screen
                  backgroundColor: currentTheme
                      ? const Color.fromARGB(255, 36, 36, 38)
                      : BackgroundColor.lightMode,
                  width: MediaQuery.sizeOf(context).width * 0.70,
                  child: const MyDrawer()),
              floatingActionButton: FloatingActionButton(
                  focusElevation: 30,
                  onPressed: () {
                    Navigator.push<void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const AddNote(),
                      ),
                    );
                  },
                  backgroundColor: themeColor,
                  child: Icon(
                    Icons.add,
                    color: AppTextStyle.appBarTextColor,
                    size: 25.sp,
                  ))),
        );
      },
    );
  }
}
