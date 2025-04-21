import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final IconData icon;
  final String hintText;

  const CustomTextFormField({
    super.key,
    required this.icon,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.green,
      decoration: InputDecoration(
        prefixIcon: Icon(
          icon,
          color: Colors.green,
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          fontSize: 14,
          color: Colors.black,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Color(0xFF1397D5),
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          borderSide: BorderSide(
            color: Colors.green,
            width: 1.5,
          ),
        ),
        filled: true,
        fillColor: Colors.green.withOpacity(0),
      ),
    );
  }
}
