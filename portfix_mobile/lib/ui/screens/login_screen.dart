import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/auth/auth_repository.dart';
import 'package:portfix_mobile/ui/screens/home_screen.dart';
import 'package:portfix_mobile/ui/theme.dart';
import 'package:portfix_mobile/ui/widgets/text_field.dart';
import 'package:portfix_mobile/ui/utils/snackbar.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoading = false;
  String _email = "";
  String _password = "";
  final GlobalKey<FormState> _formState = GlobalKey();

  final AuthRepository _authRepository = AuthRepository.getInstance();

  void login() async {
    FocusScope.of(context).unfocus();
    if (_formState.currentState?.validate() == true) {
      _formState.currentState?.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await _authRepository.login(
          _email,
          _password,
        );
        _formState.currentState?.reset();
        setState(() {
          _isLoading = false;
        });
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) {
              return const HomeScreen();
            },
          ),
        );
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        if (e is FirebaseException) {
          SnackbarUtils(context: context).createSnackbar(
            (e).message.toString(),
          );
        }
        SnackbarUtils(context: context).createSnackbar(
          e.toString(),
        );
        _authRepository.logOut();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: Stack(
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.rotate(
                      angle: pi,
                      child: WaveWidget(
                        config: CustomConfig(
                          durations: [1000],
                          heightPercentages: [0],
                          gradientBegin: Alignment.centerLeft,
                          gradientEnd: Alignment.centerRight,
                          gradients: [
                            [
                              CustomTheme.primary.withGreen(130),
                              CustomTheme.primary
                            ]
                          ],
                        ),
                        size: Size(
                          double.infinity,
                          MediaQuery.of(context).size.height * 0.5,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                      ),
                      child: Text(
                        "Login to use the app",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    )
                  ],
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 40,
                  ),
                  child: loginForm(),
                ),
              ],
            ),
            Visibility(
              visible: _isLoading,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: CustomTheme.primary.shade500,
                alignment: Alignment.center,
                child: const CircularProgressIndicator(),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: _formState,
      child: Column(
        children: [
          CustomTextFormField(
            text: "Email",
            prefixIcon: const Icon(Icons.email),
            emailCheck: true,
            onSaved: (value) {
              _email = value!;
            },
          ),
          const SizedBox(height: 15),
          CustomTextFormField(
            text: "Password",
            prefixIcon: const Icon(Icons.lock),
            obscureText: true,
            passwordLengthCheck: true,
            eye: true,
            onSaved: (value) {
              _password = value!;
            },
          ),
          Container(
            alignment: Alignment.centerRight,
            child: TextButton(
              child: const Text("Forgot password?"),
              onPressed: () {},
              style: TextButton.styleFrom(
                padding: const EdgeInsets.all(0),
                splashFactory: NoSplash.splashFactory,
                alignment: Alignment.topRight,
              ),
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => login(),
              child: const Text("Login"),
            ),
          ),
        ],
      ),
    );
  }
}
