import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:portfix_mobile/data/data.dart';
import 'package:portfix_mobile/data/logs/log_modal.dart';
import 'package:portfix_mobile/ui/screens/auth/widgets/loading.dart';
import 'package:portfix_mobile/ui/theme.dart';
import 'package:portfix_mobile/ui/utils/snackbar.dart';
import 'package:portfix_mobile/ui/widgets/wave.dart';
import 'package:portfix_mobile/ui/widgets/text_field.dart';

class LogsScreen extends StatefulWidget {
  final LogModel inCompleteLog;

  const LogsScreen({
    Key? key,
    required this.inCompleteLog,
  }) : super(key: key);

  @override
  State<LogsScreen> createState() => _LogsScreenState();
}

class _LogsScreenState extends State<LogsScreen> {
  final LogRepository _repository = LogRepository.getInstance();
  final GlobalKey<FormState> _formState = GlobalKey();
  bool _isLoading = false;
  String _comment = "";

  void saveForm() async {
    FocusScope.of(context).unfocus();
    if (_formState.currentState?.validate() == true) {
      _formState.currentState?.save();
      setState(() {
        _isLoading = true;
      });
      try {
        widget.inCompleteLog.comment = _comment;
        await _repository.createLog(widget.inCompleteLog);
        _formState.currentState?.reset();
        setState(() {
          _isLoading = false;
        });
        Navigator.pop(context);
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
    var isCancelled = widget.inCompleteLog.type == LogType.cancelled;
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Column(
                  children: [
                    WaveHeader(
                      title: isCancelled ? "Canceled task" : "Completed task",
                    ),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(
                        vertical: 20,
                        horizontal: 40,
                      ),
                      child: Form(
                        key: _formState,
                        child: Column(
                          children: [
                            CustomTextFormField(
                              text: isCancelled
                                  ? "Comments on cancellation"
                                  : "Comments",
                              prefixIcon: const Icon(Icons.comment),
                              minLines: 5,
                              maxLines: 5,
                              onSaved: (value) {
                                _comment = value!;
                              },
                            ),
                            const SizedBox(height: 15),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: isCancelled
                                      ? Colors.red
                                      : CustomTheme.primary,
                                ),
                                onPressed: () => saveForm(),
                                child: const Text("Submit"),
                              ),
                            ),
                          ],
                        ),
                      ),
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
}
