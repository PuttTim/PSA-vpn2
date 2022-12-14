import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/data.dart';
import 'package:portfix_mobile/ui/screens/auth/widgets/loading.dart';
import 'package:portfix_mobile/ui/widgets/wave.dart';
import 'package:portfix_mobile/ui/screens/screens.dart';
import 'package:portfix_mobile/ui/widgets/text_field.dart';
import 'package:portfix_mobile/ui/utils/snackbar.dart';

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
        SnackbarUtils(context: context).createSnackbar(
          (e as FirebaseAuthException).message.toString(),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    const WaveHeader(title: "Login to use the app"),
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
                LoadingWidget(isLoading: _isLoading),
              ],
            ),
          ),
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
              onPressed: () => Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const ForgetPasswordScreen(),
                ),
              ),
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
