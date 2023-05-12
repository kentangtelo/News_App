import 'package:flutter/material.dart';

class TextfieldWidget extends StatefulWidget {
  final TextEditingController textController;
  final String hintText;
  final bool obscureText;

  // ignore: prefer_const_constructors_in_immutables
  TextfieldWidget({
    super.key,
    required this.textController,
    required this.hintText,
    this.obscureText = false,
  });

  @override
  State<TextfieldWidget> createState() => _TextfieldWidgetState();
}

class _TextfieldWidgetState extends State<TextfieldWidget> {
  bool isObscure = true;
  bool isNotObscure = false;
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.textController,
      obscureText: widget.obscureText == true ? isObscure : isNotObscure,
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontWeight: FontWeight.w400,
          fontSize: 18,
          fontFamily: 'Poppins',
        ),
        suffixIcon: widget.obscureText == true
            ? IconButton(
                color: Colors.black,
                icon: Icon(isObscure ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    isObscure = !isObscure;
                  });
                },
              )
            : null,
      ),
    );
  }
}
