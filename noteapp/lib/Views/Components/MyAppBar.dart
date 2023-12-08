import '../HomePage/export_home.dart';
import '../HomePage/UserNoteList/searchHomeList.dart';

class MyAppBar extends StatefulWidget {
  const MyAppBar({super.key});

  @override
  State<MyAppBar> createState() => _MyAppBarState();
}

class _MyAppBarState extends State<MyAppBar> {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      floating: true,
      snap: true,
      backgroundColor: themeColor,
      flexibleSpace: FlexibleSpaceBar(
        title: Text('Notes', style: AppTextStyle.textStyle()),
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
            Icons.search,
            color: AppTextStyle.appBarTextColor,
            size: 23.sp,
          ),
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const SearchList(),
              ),
            );
          },
        ),
      ],
    );
  }
}
