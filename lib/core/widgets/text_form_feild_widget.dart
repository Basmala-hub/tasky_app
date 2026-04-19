import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';

class TextFormFeild extends StatefulWidget {
  TextFormFeild({
    super.key,
    required controller,
    required hintText,
    required validator,
    this.suffixIcon,
  });
  IconData? suffixIcon;

  @override
  State<TextFormFeild> createState() => _TextFormFeildState();
}

class _TextFormFeildState extends State<TextFormFeild> {
  TextEditingController? controller;

  String? hintText;

  String? Function(String?)? validator;

  bool obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: obscureText,
      controller: controller,

      decoration: InputDecoration(
        suffixIcon: IconButton(
          onPressed: () {
            !obscureText;
            setState(() {});
          },
          icon: Icon(obscureText ? widget.suffixIcon : Icons.visibility_off),
        ),
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColor.hintTextColorAndBorderTextFormFeild,
          fontSize: FontSize.hintFont,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(
            color: AppColor.hintTextColorAndBorderTextFormFeild,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColor.parimerayColor),
        ),
        contentPadding: EdgeInsets.all(15),
      ),
      validator: validator,
    );
  }
}
