import 'package:noteapp/Views/HomePage/export_home.dart';
import 'package:noteapp/Controllers/TokenLogoutControls/tryLogOut.dart';

class TryLogUserOut extends StatefulWidget {
  const TryLogUserOut({super.key});

  @override
  State<TryLogUserOut> createState() => _TryLogUserOutState();
}

class _TryLogUserOutState extends State<TryLogUserOut> {
  LongOpenLogOutUser longOpenLogOutUser = LongOpenLogOutUser();
  @override
  void initState() {
    longOpenLogOutUser.loginCheckInternetConnection(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: Icon(
          Icons.menu,
          color: AppTextStyle.appBarTextColor,
          size: 23.sp,
        ),
        title: Text(
          'Notes',
          style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp),
        ),
        actions: [
          Icon(
            Icons.search,
            color: AppTextStyle.appBarTextColor,
            size: 23.sp,
          ),
        ],
      ),
      body: Center(
        child: SpinKitChasingDots(
          color: themeColor,
          size: 40.sp,
        ),
      ),
    );
  }
}
