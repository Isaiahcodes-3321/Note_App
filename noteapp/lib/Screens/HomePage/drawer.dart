import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'export._home.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeProvider);
      var text_Mode_Color =
          theme ? Backgroundcolor.ligthmode : Backgroundcolor.darkhmode;

      return ListView(
        children: <Widget>[
          DrawerHeader(
              // decoration: BoxDecoration(color: Color),
              child: Align(
            alignment: Alignment.bottomLeft,
            child: Text.rich(
              TextSpan(
                children: <TextSpan>[
                  TextSpan(
                    text: 'isaiahshell2019@gmail.com \n',
                  ),
                  TextSpan(
                      text: 'Isaiah Shell',
                      style: AppTextStyle.textStyle()
                          .copyWith(color: text_Mode_Color, fontSize: 17.sp)),
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
                    builder: (BuildContext context) => const Trash_Page(),
                  ),
                );
              },
              child: Text('Trash',
                  style: AppTextStyle.textStyle()
                      .copyWith(color: text_Mode_Color, fontSize: 18.sp)),
            ),
          ),
          Divider(
            color:
                theme ? Backgroundcolor.ligthmode : Backgroundcolor.darkhmode,
          ),
          ListTile(
            title: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Theme',
                    style: AppTextStyle.textStyle()
                        .copyWith(color: text_Mode_Color, fontSize: 18.sp)),
                Consumer(
                  builder: (context, ref, child) {
                    final theme = ref.watch(themeProvider);
                    return CupertinoSwitch(
                      activeColor: Colors.white,
                      thumbColor: Colors.green,
                      trackColor: Color.fromARGB(255, 35, 35, 36),
                      value: theme,
                      onChanged: (value) {
                        ref.read(themeProvider.notifier).toggleTheme();
                      },
                    );
                  },
                )
              ],
            ),
          ),
          Divider(
            color:
                theme ? Backgroundcolor.ligthmode : Backgroundcolor.darkhmode,
          ),
          ListTile(
            title: Text('Developers',
                style: AppTextStyle.textStyle()
                    .copyWith(color: text_Mode_Color, fontSize: 18.sp)),
          ),
          Divider(
            color:
                theme ? Backgroundcolor.ligthmode : Backgroundcolor.darkhmode,
          ),
          ListTile(
            title: Text('Rate Us',
                style: AppTextStyle.textStyle()
                    .copyWith(color: text_Mode_Color, fontSize: 18.sp)),
          ),
          Divider(
            color:
                theme ? Backgroundcolor.ligthmode : Backgroundcolor.darkhmode,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                child: TextButton(
                  onPressed: () {},
                  child: Padding(
                    padding: EdgeInsets.all(20.sp),
                    child: Text('LOG OUT'),
                  ),
                ),
              ),
            ),
          )
        ],
      );
    });
  }
}
