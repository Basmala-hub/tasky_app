import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';
import 'package:tasky/core/widgets/text_form_feild_widget.dart';
import 'package:tasky/features/auth/widget/material_button_widget.dart';
import 'package:tasky/models/validator_model.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static String routeName = "LoginScreen";
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController? email;
  TextEditingController? password;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: .start,
            children: [
              Text(
                "Login",
                style: TextStyle(
                  color: AppColor.superTextColor,
                  fontSize: FontSize.superText,
                ),
              ),
              Text(
                "Email",
                style: TextStyle(
                  color: AppColor.subTextColor,
                  fontSize: FontSize.labelAndFontButton,
                ),
              ),
              TextFormFeild(
                controller: email,
                hintText: "enter username...",
                validator: (value) {
                  return ValidatorApp.validateEmail(value);
                },
              ),
              Text(
                "Password",
                style: TextStyle(
                  color: AppColor.subTextColor,
                  fontSize: FontSize.labelAndFontButton,
                ),
              ),

              TextFormFeild(
                controller: password,
                hintText: "Password...",
                validator: (value) {
                  return ValidatorApp.validatePassword(value);
                },
                suffixIcon: Icons.visibility,
              ),
              MateralButtonWidget(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsetsGeometry.all(16),
        child: Center(
          child: RichText(
            text: TextSpan(
              text: "Don’t have an account?",
              style: TextStyle(
                fontSize: FontSize.bottomNavagationBarFont,
                color: AppColor.subTextColor,
              ),
              children: [
                TextSpan(
                  text: "Register",
                  style: TextStyle(
                    fontSize: FontSize.bottomNavagationBarFont,
                    color: AppColor.parimerayColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
