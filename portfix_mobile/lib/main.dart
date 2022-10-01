import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/auth/auth_repository.dart';
import 'package:portfix_mobile/firebase_options.dart';
import 'package:portfix_mobile/ui/screens/home_screen.dart';
import 'package:portfix_mobile/ui/screens/auth/login_screen.dart';
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
    AuthRepository _repository = AuthRepository.getInstance();
    var isLoggedIn = _repository.getCurrentUser() != null;

    return MaterialApp(
      title: 'PortFix',
      theme: CustomTheme.lightTheme,
      darkTheme: CustomTheme.darkTheme,
      debugShowCheckedModeBanner: false,
      // home: isLoggedIn ? const HomeScreen() : const LoginScreen(),
      home: HomeScreen(),
    );
  }
}
