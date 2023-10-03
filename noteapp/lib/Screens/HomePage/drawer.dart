import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        DrawerHeader(
            // decoration: BoxDecoration(color: ),
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
          ),)),
        ListTile(
            title: Text('Trash'),
            ),
        ListTile(
            title: Text('Theme'),
            ),
             ListTile(
            title: Text('Developers'),
            ),
             ListTile(
            title: Text('rate us'),
            ),
            Container(
              height: MediaQuery.sizeOf(context).height * 0.35,
              child: Align(alignment: Alignment.bottomCenter,
              child: TextButton(onPressed: (){},
              child: Text('LOG OUT'),
              ),),
            )
      ],
    );
  }
}
