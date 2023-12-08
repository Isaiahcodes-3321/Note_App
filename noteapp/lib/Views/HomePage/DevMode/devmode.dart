import 'package:flutter/material.dart';
import '../../Add_Note/export_note_input.dart';

class DevPage extends StatelessWidget {
  const DevPage({super.key});

  @override
  Widget build(BuildContext context) {
    final changeTheme =
        GlobalControllers.providerRef.watch(ThemeClass.themeProvider);
    GlobalControllers.getTheme = changeTheme;
    return Scaffold(
      backgroundColor: GlobalControllers.backGroundThemeColor,
      appBar: AppBar(
        backgroundColor: themeColor,
        leading: IconButton(
          color: AppTextStyle.appBarTextColor,
          iconSize: 23.sp,
          onPressed: () {
            Navigator.push<void>(
              context,
              MaterialPageRoute<void>(
                builder: (BuildContext context) => const HomePage(),
              ),
            );
          },
          icon: const Icon(Icons.arrow_back_rounded),
        ),
        title: Text(
          'Dev,s Page',
          style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp),
        ),
      ),
      body: const SizedBox(),
    );
  }
}
