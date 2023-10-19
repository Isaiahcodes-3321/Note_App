import 'package:flutter/material.dart';
import 'package:noteapp/Constant/global_controllers.dart';
import 'package:noteapp/Screens/Logins/export_login_register.dart';

class LoginSignUpPage extends StatefulWidget {
  const LoginSignUpPage({super.key});

  @override
  State<LoginSignUpPage> createState() => _LoginSignUpPageState();
}

class _LoginSignUpPageState extends State<LoginSignUpPage>
    with TickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void switchToTab(int tabIndex) {
    _tabController.animateTo(tabIndex);
  }

  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Change this to 2
      child: Scaffold(
        key: GlobalKey<ScaffoldState>(),
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(15.h),
          child: Container(
            height: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25.sp),
                bottomRight: Radius.circular(25.sp),
              ),
              color: themeColor,
            ),
            child: TabBar(
              labelColor: Colors.white,
              unselectedLabelColor: Color.fromARGB(255, 148, 147, 147),
              indicator: BoxDecoration(),
              tabs: [
                Tab(
                  child: FittedBox(child: Text("Sign Up", style: textFonts)),
                ),
                Tab(
                  child: FittedBox(child: Text("Login", style: textFonts)),
                ),
              ],
              isScrollable: false,
              padding: EdgeInsets.only(top: 7.h),
              physics: NeverScrollableScrollPhysics(),
            ),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                children: [
                  SignUpPage(),
                  LoginPage(),
                ],
              ),
            ),
            Container(
              height: 13.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25.sp),
                  topRight: Radius.circular(25.sp),
                ),
                color: themeColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
