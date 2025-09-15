import 'package:flutter/material.dart';

class AuthField extends StatelessWidget {
  final String hintText;
  final TextEditingController textController;
  final bool isObscureText;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? submit;
  const AuthField({
    super.key,
    required this.hintText,
    required this.textController,
    required this.isObscureText,
    this.textInputAction,
    this.submit,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: false,
      textInputAction: textInputAction,
      decoration: InputDecoration(hintText: hintText),
      controller: textController,
      obscureText: isObscureText,
      onFieldSubmitted: submit,
      validator: (value) {
        if (value!.isEmpty) {
          return "$hintText is missing";
        }
        return null;
      },
    );
  }
}
