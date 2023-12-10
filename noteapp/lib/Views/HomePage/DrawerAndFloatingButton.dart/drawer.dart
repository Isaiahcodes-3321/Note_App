import '../export_home.dart';

class DrawerAndFloatingButton {
  Widget drawer(BuildContext context) {
    return Drawer(
      // Take 70% of the user screen
      backgroundColor:
          // currentTheme
          //     ? const Color.fromARGB(255, 36, 36, 38)
          //     :
          BackgroundColor.lightMode,
      width: MediaQuery.sizeOf(context).width * 0.70,
      child: const MyDrawer(),
    );
  }

  Widget floatingButton(BuildContext context) {
    return FloatingActionButton(
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
        ));
  }
}
