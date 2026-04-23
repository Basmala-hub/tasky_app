import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';
import 'package:tasky/core/widgets/bottom_content.dart';
import 'package:tasky/core/widgets/text_form_feild_widget.dart';
import 'package:tasky/features/auth/screens/register_screen.dart';
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
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 122),
                Text(
                  "Login",
                  style: TextStyle(
                    color: AppColor.superTextColor,
                    fontSize: FontSize.superText,
                  ),
                ),
                SizedBox(height: 53),
                Text(
                  "Email",
                  style: TextStyle(
                    color: AppColor.subTextColor,
                    fontSize: FontSize.labelAndFontButton,
                  ),
                ),
                SizedBox(height: 5),
                TextFormFeildWidget(
                  controller: email,
                  hintText: "enter email...",
                  validator: (value) {
                    return ValidatorApp.validateEmail(value);
                  },
                ),
                SizedBox(height: 26),
                Text(
                  "Password",
                  style: TextStyle(
                    color: AppColor.subTextColor,
                    fontSize: FontSize.labelAndFontButton,
                  ),
                ),
                SizedBox(height: 5),
                TextFormFeildWidget(
                  controller: password,
                  hintText: "Password...",
                  validator: (value) {
                    return ValidatorApp.validatePassword(value);
                  },
                  suffixIcon: Icons.visibility_off,
                ),
                SizedBox(height: 71),
                MateralButtonWidget(
                  padding: 144,
                  data: "Login",
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {}
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavgationContent(
        fristText: "Don’t have an account?",
        secondText: "Register",
        onTap: () {
          Navigator.pushNamed(context, RegisterScreen.routeName);
        },
      ),
    );
  }
}
