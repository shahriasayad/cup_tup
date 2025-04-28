import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const PasswordTextFormField({
    super.key,
    required this.hintText,
    required this.controller,
  });

  @override
  _PasswordTextFormFieldState createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  bool _obscureText = true;

  void _toggleVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscureText,
        decoration: InputDecoration(
          hintText: widget.hintText,
          hintStyle: TextStyle(color: Colors.black, fontSize: 14),
          prefixIcon: Icon(
            Icons.password,
            color: Colors.green,
          ),
          suffixIcon: IconButton(
            onPressed: _toggleVisibility,
            icon: Icon(
              _obscureText ? Icons.visibility_off : Icons.visibility,
              color: Colors.green,
            ),
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
          contentPadding: EdgeInsets.symmetric(
              horizontal: 16.0, vertical: 20.0), // Adjust padding
        ),
      ),
    );
  }
}
