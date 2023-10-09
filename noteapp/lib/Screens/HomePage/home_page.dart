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

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final theme = ref.watch(themeProvider);
        return SafeArea(
          child: Scaffold(
            backgroundColor:
                theme ? Backgroundcolor.darkhmode : Backgroundcolor.ligthmode,
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
                              style:
                                  TextStyle(color: AppTextStyle.appbarTextcolor),
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
              ],
            ),
            drawer: Drawer(
                // Take 70% of the user screen
                backgroundColor: theme
                    ? Color.fromARGB(255, 36, 36, 38)
                    : Backgroundcolor.ligthmode,
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
                )),
          ),
        );
      },
    );
  }
}















//    SliverList(
//   delegate: SliverChildBuilderDelegate(
//     (BuildContext context, int index) {
//       return Column(
//         children: [
//           Container(
//             color: Colors.yellow,
//             child: ListTile(
//               title: Text('Item $index'),
//             ),
//           ),
//           SizedBox(height: 5,)
//         ],
//       );
//     },
//     childCount: 50, // Number of list items
//   ),
// ),
