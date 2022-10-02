import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  String text;
  String? initialValue;
  Icon prefixIcon;
  bool obscureText;
  bool emailCheck;
  bool passwordLengthCheck;
  bool eye;
  bool doubleCheck;
  int minLines;
  int maxLines;
  void Function(String?)? onSaved;
  void Function(String?)? onChanged;
  String? Function(String?)? customValidators;

  CustomTextFormField({
    required this.text,
    required this.prefixIcon,
    this.onSaved,
    this.onChanged,
    this.customValidators,
    this.eye = false,
    this.obscureText = false,
    this.emailCheck = false,
    this.passwordLengthCheck = false,
    this.doubleCheck = false,
    this.minLines = 1,
    this.maxLines = 1,
    this.initialValue,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      onSaved: widget.onSaved,
      onChanged: widget.onChanged,
      initialValue: widget.initialValue,
      minLines: widget.minLines,
      maxLines: widget.maxLines,
      decoration: InputDecoration(
        label: Text(
          widget.text,
          style: const TextStyle(fontFamily: 'Roboto'),
        ),
        border: const OutlineInputBorder(),
        prefixIcon: IconTheme(
          data: const IconThemeData(color: Colors.grey),
          child: widget.prefixIcon,
        ),
        suffixIcon: widget.eye
            ? IconTheme(
                data: const IconThemeData(color: Colors.grey),
                child: IconButton(
                  icon: widget.obscureText
                      ? const Icon(Icons.visibility)
                      : const Icon(Icons.visibility_off),
                  onPressed: () => setState(() {
                    widget.obscureText = !widget.obscureText;
                  }),
                  splashRadius: 20,
                ),
              )
            : null,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return '${widget.text} required!';
        }
        if (widget.emailCheck && !value.contains('@')) {
          return 'Invalid ${widget.text}';
        }
        if (widget.passwordLengthCheck && value.length <= 6) {
          return 'Password must be longer than 6 characters';
        }
        if (widget.doubleCheck && double.tryParse(value) == null) {
          return '${widget.text.split(' ')[0]} must be a proper number value!';
        }
        return widget.customValidators?.call(value);
      },
    );
  }
}
