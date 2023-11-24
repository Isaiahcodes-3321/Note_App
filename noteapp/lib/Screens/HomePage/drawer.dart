import 'export_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  LogOutService logOutService = LogOutService();
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
     
      return ListView(
        children: <Widget>[
          DrawerHeader(
              // decoration: BoxDecoration(color: Color),
              child: Align(
            alignment: Alignment.bottomLeft,
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  const TextSpan(
                    text: 'isaiahshell2019@gmail.com \n',
                  ),
                  TextSpan(
                      text: 'Isaiah Shell',
                      style: AppTextStyle.textStyle()
                          .copyWith(color: BackgroundColor.darkMode, fontSize: 17.sp)),
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
                  style: AppTextStyle.textStyle()
                      .copyWith(color: BackgroundColor.darkMode, fontSize: 18.sp)),
            ),
          ),
          Divider(
            color:  BackgroundColor.darkMode,
          ),
          ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Theme',
                    style: AppTextStyle.textStyle()
                        .copyWith(color: BackgroundColor.darkMode, fontSize: 18.sp)),
                // GestureDetector(
                //     onTap: () {},
                //     child: Consumer(
                //       builder: (context, ref, child) {
                //         // Get the current theme state from your Riverpod provider
                //         final theme = ref.watch(themeInit);

                //         return CupertinoSwitch(
                //           activeColor: Colors.white,
                //           thumbColor: Colors.green,
                //           trackColor: const Color.fromARGB(255, 35, 35, 36),
                //           value: theme,
                //           onChanged: (value) async {
                //             // Toggle the theme state in your Riverpod provider
                //             ref.read(themeInit.notifier).state = value;

                //             // Update the theme value in Hive
                //             await GlobalControllers.themeStorage
                //                 .put('myKey', value);
                //             // themeInit = GlobalControllers.getTheme  as StateProvider<bool>;
                //           },
                //         );
                //       },
                //     )),
              ],
            ),
          ),
          Divider(
            color:BackgroundColor.darkMode,
          ),
          ListTile(
            title: Text('Developers',
                style: AppTextStyle.textStyle()
                    .copyWith(color: BackgroundColor.darkMode, fontSize: 18.sp)),
          ),
          Divider(
            color: BackgroundColor.darkMode,
          ),
          ListTile(
            title: Text('Rate Us',
                style: AppTextStyle.textStyle()
                    .copyWith(color: BackgroundColor.darkMode, fontSize: 18.sp)),
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
      );
    });
  }
}
