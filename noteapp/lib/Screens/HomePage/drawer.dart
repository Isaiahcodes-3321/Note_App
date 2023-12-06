import 'export_home.dart';
import 'package:flutter/cupertino.dart';
import 'package:noteapp/Screens/Api_Service/export.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  LogOutService logOutService = LogOutService();
  @override
  void initState() {
    openHive();
    super.initState();
  }

  openHive() async {
    GlobalControllers.tokenKey = await Hive.openBox('userNameBox');
  }

  // @override
  // void initState() {
  //   super.initState();
  //   GlobalControllers.themeController.setBool('repeat', false);
  //   GlobalControllers.theme = GlobalControllers.themeController.getBool('repeat');
  // }

  @override
  Widget build(BuildContext context) {
    final userName =
        GlobalControllers.userNameAndEmail.getAt(0) as UserNameAndEmailStorage;

    // GlobalControllers.backGroundThemeColor =
    //     GlobalControllers.theme! ? BackgroundColor.themeColorDarkMode : BackgroundColor.lightMode;
    // GlobalControllers.textThemeColor =
    //     GlobalControllers.theme! ? BackgroundColor.lightMode : BackgroundColor.darkMode;
    return Consumer(builder: (context, ref, child) {
      return Container(
        // color: GlobalControllers.backGroundThemeColor,
        child: ListView(
          children: <Widget>[
            DrawerHeader(
                child: Align(
              alignment: Alignment.bottomLeft,
              child: Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Welcome ${userName.userName}',
                    ),
                    TextSpan(
                          text: '\n${userName.email}',
                        style: AppTextStyle.textStyle().copyWith(
                            color: BackgroundColor.darkMode, fontSize: 17.sp)),
                  ],
                ),
              ),
            )),
            ListTile(
              title: GestureDetector(
                onTap: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => const TrashPage(),
                    ),
                  );
                },
                child: Text('Trash',
                    style: AppTextStyle.textStyle().copyWith(
                        color: BackgroundColor.darkMode, fontSize: 18.sp)),
              ),
            ),
            Divider(
              color: BackgroundColor.darkMode,
            ),
            ListTile(
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Theme',
                      style: AppTextStyle.textStyle().copyWith(
                          color: BackgroundColor.darkMode, fontSize: 18.sp)),
                  CupertinoSwitch(
                    activeColor: Colors.white,
                    thumbColor: Colors.green,
                    trackColor: const Color.fromARGB(255, 35, 35, 36),
                    value: GlobalControllers.theme ?? false,
                    onChanged: (value) async {
                      setState(() {
                        GlobalControllers.theme = value;
                      });
                      GlobalControllers.themeController
                          .setBool('repeat', value);
                      print('Value for theme is $GlobalControllers.theme');
                    },
                  ),
                ],
              ),
            ),
            Divider(
              color: BackgroundColor.darkMode,
            ),
            ListTile(
              title: Text('Developers',
                  style: AppTextStyle.textStyle().copyWith(
                      color: BackgroundColor.darkMode, fontSize: 18.sp)),
            ),
            Divider(
              color: BackgroundColor.darkMode,
            ),
            ListTile(
              title: Text('Rate Us',
                  style: AppTextStyle.textStyle().copyWith(
                      color: BackgroundColor.darkMode, fontSize: 18.sp)),
            ),
            Divider(
              color: BackgroundColor.darkMode,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.25,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextButton(
                  onPressed: () {
                    logOutService.userLogOut(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: const Text('LOG OUT ',
                        style: TextStyle(color: Colors.red)),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    });
  }
}
