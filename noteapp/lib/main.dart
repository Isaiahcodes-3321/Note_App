import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
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
  runApp(const ProviderScope(child: NoteApp()));
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(TokenStorageAdapter());
  // Opening the hive storage for theme storage
  GlobalControllers.themeStorage = await Hive.openBox('themeBox');
  GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
}

class NoteApp extends StatelessWidget {
  const NoteApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home: NoteAppInit(),
        );
      },
    );
  }
}

class NoteAppInit extends StatefulWidget {
  const NoteAppInit({Key? key}) : super(key: key);

  @override
  State<NoteAppInit> createState() => _NoteAppInitState();
}

class _NoteAppInitState extends State<NoteAppInit> {
  late var token = '';

  @override
  void initState() {
    super.initState();
    checkLoginUser();
  }

  void checkLoginUser() async {
    GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
    final tokenStorage = GlobalControllers.tokenKey.getAt(0) as TokenStorage;
    token = tokenStorage.myToken;

    // Call the build method after fetching the token
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (token.isEmpty) {
      // If the token is empty, navigate to LoginSignUpPage
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const LoginSignUpPage()),
        );
      });
      return Container(); 
       } else {
      bool hasExpired = JwtDecoder.isExpired(token);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (_) => hasExpired
                ? const SafeArea(child: LoginSignUpPage())
                : const HomePage(),
          ),
        );
      });
      return Container();
       }
  }
}




