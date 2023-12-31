import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType textInputType;
  final FormFieldValidator validator;
  final FormFieldSetter onSaved;

  MyTextField({
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.textInputType,
    required this.validator,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
        top: 9,
      ),
      child: TextFormField(
        onChanged: (value) {
          if (textInputType == TextInputType.emailAddress) {
            controller.text = value.toLowerCase();
          }
        },
        cursorColor: Colors.orange,
        keyboardType: textInputType,
        textAlign: TextAlign.center,
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        onSaved: onSaved,
        decoration: InputDecoration(
          label: Text(
            hintText,
            style: const TextStyle(fontSize: 20),
          ),
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.indigo,
              width: 2,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(5),
            ),
          ),
          fillColor: Colors.white,
          filled: true,
          hintText: hintText,
          hintStyle: const TextStyle(
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
