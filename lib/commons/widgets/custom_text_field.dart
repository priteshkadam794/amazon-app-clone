import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  const CustomTextField(
      {super.key, required this.hintText, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide(
        color: Colors.black54,
      ),
    );
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText, border: border, enabledBorder: border),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "Enter your $hintText";
        }
        return null;
      },
    );
  }
}
