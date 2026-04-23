import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tasky/core/network/data/state_model.dart';
import 'package:tasky/core/network/firebase/firebase_app.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';
import 'package:tasky/core/widgets/bottom_content.dart';
import 'package:tasky/core/widgets/text_form_feild_widget.dart';
import 'package:tasky/features/auth/data/user_model.dart';
import 'package:tasky/features/auth/screens/login_screen.dart';
import 'package:tasky/features/auth/widget/material_button_widget.dart';
import 'package:tasky/features/home/screens/home_screen.dart';
import 'package:tasky/models/validator_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String routeName = "RegisterScreen";
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;
  @override
  void initState() {
    super.initState();

    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.secondaryColor,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: .start,
              children: [
                SizedBox(height: 97),
                Text(
                  "Register",
                  style: TextStyle(
                    color: AppColor.superTextColor,
                    fontSize: FontSize.superText,
                  ),
                ),
                SizedBox(height: 23),
                Text(
                  "Username",
                  style: TextStyle(
                    color: AppColor.subTextColor,
                    fontSize: FontSize.labelAndFontButton,
                  ),
                ),
                SizedBox(height: 5),
                TextFormFeildWidget(
                  controller: username,
                  hintText: "enter username...",
                  validator: (value) {
                    return ValidatorApp.validateName(value);
                  },
                ),
                SizedBox(height: 26),
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
                SizedBox(height: 11),
                Text(
                  "Password",
                  style: TextStyle(
                    color: AppColor.subTextColor,
                    fontSize: FontSize.labelAndFontButton,
                  ),
                ),
                SizedBox(height: 6),
                TextFormFeildWidget(
                  controller: password,
                  hintText: "Password...",
                  validator: (value) {
                    return ValidatorApp.validatePassword(value);
                  },
                  suffixIcon: Icons.visibility_off,
                ),
                SizedBox(height: 24),
                Text(
                  "Confirm Password",
                  style: TextStyle(
                    color: AppColor.subTextColor,
                    fontSize: FontSize.labelAndFontButton,
                  ),
                ),
                SizedBox(height: 5),
                TextFormFeildWidget(
                  controller: confirmPassword,
                  hintText: "Password...",
                  validator: (value) {
                    return ValidatorApp.validateConfirmPassword(
                      value,
                      password.text,
                    );
                  },
                  suffixIcon: Icons.visibility_off,
                ),
                SizedBox(height: 78),
                MateralButtonWidget(
                  padding: 125,
                  data: "Register",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      var result = await FireBase.register(
                        email: email.text,
                        password: password.text,
                      );
                      switch (result) {
                        case Success():
                          await FireBase.addUser(
                            UserdData(
                              id: FirebaseAuth.instance.currentUser!.uid,
                              name: username.text,
                              email: email.text,
                              password: password.text,
                            ),
                          );
                          Navigator.of(
                            context,
                          ).pushNamed(LoginScreen.routeName);
                          break;
                        case Erorr():
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(result.message)),
                          );
                          break;
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavgationContent(
        onTap: () {
          Navigator.pushNamed(context, HomeScreen.routeName);
        },
        fristText: "Already have an account?",
        secondText: "Login",
      ),
    );
  }
}
