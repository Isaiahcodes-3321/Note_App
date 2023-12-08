import 'Model/ThemeStore/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:noteapp/Views/Logins/login_SignUp.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:noteapp/Views/Constant/global_controllers.dart';
import 'package:noteapp/Views/HomePage/UserNoteList/home_page.dart';


// error 503
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
  Hive.registerAdapter(UserNameAndEmailStorageAdapter());
  // Opening the hive storage for theme storage
  GlobalControllers.tokenKey = await Hive.openBox('tokenBox');
  GlobalControllers.themeController = await SharedPreferences.getInstance();
  GlobalControllers.userNameAndEmail = await Hive.openBox('userNameBox');
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
