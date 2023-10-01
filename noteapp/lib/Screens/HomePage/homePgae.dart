import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import '../../Constant/themes.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final globalKey = GlobalKey();
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
              title: Text('Scroll Up/Down Example',
                  style: TextStyle(color: Colors.black)),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return ListTile(
                  title: Text('Item $index'),
                );
              },
              childCount: 50, // Number of list items
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: themeColor,
          child: Icon(
            Icons.add,
            color: Colors.white,
            size: 25.sp,
          )),
    );
  }
}
