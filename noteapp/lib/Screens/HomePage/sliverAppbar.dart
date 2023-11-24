import 'export_home.dart';
import 'package:flutter/material.dart';


class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return  SliverAppBar(
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
                            hintStyle:
                                TextStyle(color: AppTextStyle.appBarTextColor),
                            border: InputBorder.none,
                          ),
                          style: TextStyle(color: AppTextStyle.appBarTextColor),
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
            );
  }
}