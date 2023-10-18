import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'Constant/themes.dart';
import 'Screens/Logins/login_SignUp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'ThemeStore/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupHive();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(ProviderScope(child: const Note_App()));
}

Future<void> setupHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(ThemecheckAdapter());
  // Opening the hive storage for theme storage
  themestorage = await Hive.openBox('themeBox');
}

class Note_App extends StatelessWidget {
  const Note_App({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return const MaterialApp(
            title: 'Material App',
            debugShowCheckedModeBanner: false,
            home: SafeArea(child: Login_SignUp_Page()));
      },
    );
  }
}
