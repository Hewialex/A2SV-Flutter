import 'package:flutter/material.dart';

class ReusableTextField extends StatelessWidget {
  final String hint;
  final TextEditingController textEditingController;
  final TextInputType textInputType;
  final String? Function(String?)? validator;

  const ReusableTextField({
    required this.hint,
    required this.textEditingController,
    required this.textInputType,
    this.validator,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      keyboardType: textInputType,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15.0, horizontal: 10.0),
      ),
    );
  }
}
