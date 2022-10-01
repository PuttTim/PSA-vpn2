import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/data.dart';
import 'package:portfix_mobile/ui/screens/auth/widgets/loading.dart';
import 'package:portfix_mobile/ui/screens/auth/widgets/wave.dart';
import 'package:portfix_mobile/ui/widgets/text_field.dart';
import 'package:portfix_mobile/ui/utils/snackbar.dart';

class ForgetPasswordScreen extends StatefulWidget {
  const ForgetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  bool _isLoading = false;
  String _email = "";
  final GlobalKey<FormState> _formState = GlobalKey();

  final AuthRepository _authRepository = AuthRepository.getInstance();

  void sendEmail() async {
    FocusScope.of(context).unfocus();
    if (_formState.currentState?.validate() == true) {
      _formState.currentState?.save();
      setState(() {
        _isLoading = true;
      });
      try {
        await _authRepository.sendPasswordResetLink(_email);
        _formState.currentState?.reset();
        setState(() {
          _isLoading = false;
        });
        SnackbarUtils(context: context).createSnackbar(
          "Sent password reset link to email. Please check your email for further details",
        );
        Navigator.of(context).pop();
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
                    Stack(
                      alignment: Alignment.topLeft,
                      children: [
                        const WaveHeader(title: "Forgot password?"),
                        AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0,
                        ),
                      ],
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: forgetPasswordForm(),
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

  Widget forgetPasswordForm() {
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
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () => sendEmail(),
              child: const Text("Submit"),
            ),
          ),
        ],
      ),
    );
  }
}
