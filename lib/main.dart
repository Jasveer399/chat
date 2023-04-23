import 'package:chat/screens/splash_page/splash_page.dart';
import 'package:chat/utilis/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _initializefirebase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
 const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
       themeMode: ThemeMode.system,
       theme: ATheme.lighttheme,  
       darkTheme: ATheme.darktheme,    
      home: Splash_Page(),
    );
  }
}
_initializefirebase() async {
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
);
}
