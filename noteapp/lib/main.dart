import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:noteapp/Constant/global_controllers.dart';
import 'package:noteapp/Screens/HomePage/home_page.dart';
import 'package:noteapp/Screens/Logins/login_SignUp.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ThemeStore/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(ProviderScope(child: NoteApp()));
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TokenStorageAdapter());
  // Opening the hive storage for theme storage
  GlobalControllers.themeStorage = await Hive.openBox('themeBox');
  GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
}

class NoteApp extends StatelessWidget {
  NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home: NoteAppInit(),
        );
      },
    );
  }
}

class NoteAppInit extends StatefulWidget {
  NoteAppInit({Key? key}) : super(key: key);

  @override
  State<NoteAppInit> createState() => _NoteAppInitState();
}

class _NoteAppInitState extends State<NoteAppInit> {
  late bool? checkUserLogin;

  @override
  void initState() {
    super.initState();
    initializePreferences();
  }

  Future<void> initializePreferences() async {
    await PreferenceService.initialize();
    setState(() {
      checkUserLogin = PreferenceService.sharedPref.getBool('repeat');
    });
  }

  @override
  Widget build(BuildContext context) {
    if (checkUserLogin == null) {
      return LoginSignUpPage();
       } else {
      PreferenceService.sharedPref.setBool('repeat', false);

      return checkUserLogin == true
          ? const HomePage()
          : const SafeArea(child: LoginSignUpPage());
    }
  }
}