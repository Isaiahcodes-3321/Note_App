import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../Constant/themes.dart';
import '../../state_Management/riverPod.dart';

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
                  ),
                ],
              ),
            ),
          )),
          ListTile(
            title: Text('Trash'),
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
                Text('Theme'),
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
            title: Text('Developers'),
          ),
          Divider(
            color:
                theme ? Backgroundcolor.ligthmode : Backgroundcolor.darkhmode,
          ),
          ListTile(
            title: Text('rate us'),
          ),
          Divider(
            color:
                theme ? Backgroundcolor.ligthmode : Backgroundcolor.darkhmode,
          ),
          Container(
            height: MediaQuery.sizeOf(context).height * 0.25,
            child: Align(
              alignment: Alignment.bottomCenter,
              child: TextButton(
                onPressed: () {},
                child: Text('LOG OUT'),
              ),
            ),
          )
        ],
      );
    });
  }
}
