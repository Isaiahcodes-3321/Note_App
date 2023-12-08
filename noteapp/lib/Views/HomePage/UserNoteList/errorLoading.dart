import '../export_home.dart';

class ErrorLoading extends StatelessWidget {
  const ErrorLoading({super.key});

  @override
  Widget build(BuildContext context) {
    final changeTheme =
        GlobalControllers.providerRef.watch(ThemeClass.themeProvider);
    GlobalControllers.getTheme = changeTheme;
    return Container(
      color: GlobalControllers.backGroundThemeColor,
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          const Expanded(
            flex: 2,
            child: CustomScrollView(
              slivers: [MyAppBar()],
            ),
          ),
          Expanded(
              flex: 8,
              child: Center(
                child: Text("some error occurred ",
                    style: TextStyle(color: GlobalControllers.textThemeColor)),
              ))
        ],
      ),
    );
  }
}
