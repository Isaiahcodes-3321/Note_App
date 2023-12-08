import 'package:flutter/material.dart';
import '../../Add_Note/export_note_input.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:noteapp/Controllers/HomeNotesPage/logics.dart';

class DevPage extends StatefulWidget {
  const DevPage({super.key});

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  @override
  void initState() {
    super.initState();
    HomePageLogics.checkTokenExpires();
  }

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
      body: SizedBox(
        // width: MediaQuery.of(context).size.width * 100.0,
        // height: MediaQuery.of(context).size.height * 100.0,
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 2.0,
            width: MediaQuery.of(context).size.width * 1.0,
            child: Column(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    // color: Colors.green,
                    child: Padding(
                      padding: EdgeInsets.all(25.sp),
                      child: Column(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              width: 53.0.sp,
                              height: 53.0.sp,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "lib/Views/Assects/isaiahImage.jpg")),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.60,
                            // color: Colors.blue,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Personal Infomation',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Name',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('Shell Isaiah',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Stack',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('Mobile Developer',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Email',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  FittedBox(
                                    child: Text('isaiahshell2019@gmail.com',
                                        // 'emmanuelhilary9@gmail.com',
                                        style: AppTextStyle.textStyle()
                                            .copyWith(
                                                color: GlobalControllers
                                                    .textThemeColor,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.normal)),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Git URL',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  FittedBox(
                                    child: Text(
                                        'https://github.com/Isaiahcodes-3321',
                                        style: AppTextStyle.textStyle()
                                            .copyWith(
                                                color: GlobalControllers
                                                    .textThemeColor,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.normal)),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Twitter',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('@Isaiah-Codes',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Number',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('+234 701 312 8342',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                // Emma Profile

                Expanded(
                  flex: 1,
                  child: Container(
                    width: double.infinity,
                    // color: Colors.yellow,
                    child: Padding(
                      padding: EdgeInsets.all(25.sp),
                      child: Column(
                        children: [
                          Center(
                            child: Container(
                              width: 53.0.sp,
                              height: 53.0.sp,
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: AssetImage(
                                        "lib/Views/Assects/emmaImage.jpg")),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 8.h,
                          ),
                          Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.60,
                            // color: Colors.blue,
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Personal Infomation',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 19.sp,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Name',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('Emmanue Ihilary',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Stack',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('Back_End Developer',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Email',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  FittedBox(
                                    child: Text('emmanuelhilary9@gmail.com',
                                        style: AppTextStyle.textStyle()
                                            .copyWith(
                                                color: GlobalControllers
                                                    .textThemeColor,
                                                fontSize: 17.sp,
                                                fontWeight: FontWeight.normal)),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Git URL',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                    onTap: () async {
                                      // final Uri urlGitHub = Uri.parse(
                                      //     'https://github.com/emmanuel1-byte');

                                      // if (!await launchUrl(urlGitHub)) {
                                      //   throw Exception(
                                      //       'Could not launch $urlGitHub');
                                      // }
                                    },
                                    child: FittedBox(
                                      child: Text(
                                          'https://github.com/emmanuel1-byte',
                                          style: AppTextStyle.textStyle()
                                              .copyWith(
                                                  color: GlobalControllers
                                                      .textThemeColor,
                                                  fontSize: 17.sp,
                                                  fontWeight:
                                                      FontWeight.normal)),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Twitter',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('twitter username ',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                  SizedBox(
                                    height: 2.h,
                                  ),
                                  Text('Number',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.bold)),
                                  Text('+234 813 259 2260',
                                      style: AppTextStyle.textStyle().copyWith(
                                          color:
                                              GlobalControllers.textThemeColor,
                                          fontSize: 17.sp,
                                          fontWeight: FontWeight.normal)),
                                ]),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
