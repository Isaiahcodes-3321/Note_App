import '../export_home.dart';


class Loading extends StatelessWidget {
  const Loading({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
                    child: SpinKitChasingDots(
                      color: themeColor,
                      size: 40.sp,
                    ),
                  ),
                ),
              ],
            ));
  }
}