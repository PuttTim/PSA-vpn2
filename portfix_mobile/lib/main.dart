import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfix_mobile/firebase_options.dart';
import 'package:portfix_mobile/ui/screens/home_screen.dart';
import 'package:portfix_mobile/ui/theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PortFix',
      theme: lightTheme,
      darkTheme: darkTheme,
      home: const HomeScreen(),
    );
  }
}
