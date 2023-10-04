import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../Constant/themes.dart';
import '../../state_Management/riverPod.dart';
import '../HomePage/homePgae.dart';

class AddNote extends StatelessWidget {
  const AddNote({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ref, child) {
      final theme = ref.watch(themeProvider);
      return SafeArea(
        child: Scaffold(
          backgroundColor:
              theme ? Backgroundcolor.darkhmode : Backgroundcolor.ligthmode,
          appBar: AppBar(
            backgroundColor: themeColor,
            leading: IconButton(
                color: AppTextStyle.appbarTextcolor,
                iconSize: 23.sp,
                onPressed: () {
                  Navigator.push<void>(
                    context,
                    MaterialPageRoute<void>(
                      builder: (BuildContext context) => HomePage(),
                    ),
                  );
                },
                icon: Icon(Icons.arrow_back_rounded)),
            title: Text('New Notes',
                style: AppTextStyle.textStyle().copyWith(fontSize: 18.sp)),
            actions: [
              GestureDetector(
                  onTap: () {},
                  child: Padding(
                      padding: EdgeInsets.all(15.sp),
                      child: Text("Save",
                          style: AppTextStyle.textStyle()
                              .copyWith(fontSize: 18.sp))))
            ],
          ),
          body: Container(
            height: double.infinity,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.sp, vertical: 20.sp),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    
                  ],
                ),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              focusElevation: 30,
              onPressed: () {},
              backgroundColor: themeColor,
              child: Icon(
                Icons.add,
                color: AppTextStyle.appbarTextcolor,
                size: 25.sp,
              )),
        ),
      );
    });
  }
}
