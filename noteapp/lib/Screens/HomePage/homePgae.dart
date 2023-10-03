import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Constant/themes.dart';
import 'drawer.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final globalKey = GlobalKey();
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          hintStyle:
                              TextStyle(color: AppTextStyle.appbarTextcolor),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(color: AppTextStyle.appbarTextcolor),
                      ),
                    )
                  : Text('  Notes', style: AppTextStyle.textStyle()),
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
                  isSearching ? Icons.cancel : Icons.search,
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
        ],
      ),
      drawer: Drawer(
        // Take 70% of the user screen
        width: MediaQuery.sizeOf(context).width * 0.70,
        child: MyDrawer()
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: themeColor,
          child: Icon(
            Icons.add,
            color: AppTextStyle.appbarTextcolor,
            size: 25.sp,
          )),
    );
  }
}

// SliverList(
//   delegate: SliverChildBuilderDelegate(
//     (BuildContext context, int index) {
//       return ListTile(
//         title: Text('Item $index'),
//       );
//     },
//     childCount: 50, // Number of list items
//   ),
// ),
