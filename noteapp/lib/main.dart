import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/services.dart';
import 'Screens/Logins/login_SignUp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  runApp(ProviderScope(child: const Note_App()));
}

// flutter pub cache repair

class Note_App extends StatelessWidget {
  const Note_App({super.key});

  @override
  Widget build(BuildContext context) {
    return  ResponsiveSizer( 
  builder: (context, orientation, screenType) {
    return  const
     MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        home: SafeArea(child: Login_SignUp_Page())
      );
  },
);
  }
}
