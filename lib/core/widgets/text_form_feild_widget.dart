import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';

// ignore: must_be_immutable
class TextFormFeildWidget extends StatefulWidget {
  TextFormFeildWidget({
    super.key,
    required this.controller,
    required this.hintText,
    required this.validator,
    this.suffixIcon,
  });
  IconData? suffixIcon;

  TextEditingController? controller;

  String? hintText;

  String? Function(String?)? validator;

  bool obscureText = false;
  @override
  State<TextFormFeildWidget> createState() => _TextFormFeildState();
}

class _TextFormFeildState extends State<TextFormFeildWidget> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: widget.obscureText,
      controller: widget.controller,

      decoration: InputDecoration(
        suffixIcon: widget.suffixIcon != null
            ? IconButton(
                onPressed: () {
                  widget.obscureText = !widget.obscureText;
                  setState(() {});
                },
                icon: Icon(
                  widget.obscureText ? widget.suffixIcon : Icons.visibility,
                ),
              )
            : null,
        hintText: widget.hintText,
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
      validator: widget.validator,
    );
  }
}
