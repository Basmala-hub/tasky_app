import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';
import 'package:tasky/core/widgets/bottom_content.dart';
import 'package:tasky/core/widgets/text_form_feild_widget.dart';
import 'package:tasky/features/auth/view/screens/login_screen.dart';
import 'package:tasky/features/auth/view/widget/material_button_widget.dart';
import 'package:tasky/features/auth/view_model/auth_cubit.dart';
import 'package:tasky/features/auth/view_model/auth_state.dart';
import 'package:tasky/core/network/data/models/validator_model.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});
  static String routeName = "RegisterScreen";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController password;
  late TextEditingController confirmPassword;

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    username = TextEditingController();
    email = TextEditingController();
    password = TextEditingController();
    confirmPassword = TextEditingController();
  }

  @override
  void dispose() {
    username.dispose();
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listenWhen: (previous, current) =>
          current is AuthSuccessState || current is AuthErrorState,

      listener: (context, state) {
        if (state is AuthSuccessState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Register Success")));

          Navigator.pushReplacementNamed(context, LoginScreen.routeName);
        }

        if (state is AuthErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.errorMessage)));
        }
      },

      child: Scaffold(
        backgroundColor: AppColor.secondaryColor,
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 97),

                  Text(
                    "Register",
                    style: TextStyle(
                      color: AppColor.superTextColor,
                      fontSize: FontSize.superText,
                    ),
                  ),

                  const SizedBox(height: 23),

                  Text(
                    "Username",
                    style: TextStyle(
                      color: AppColor.subTextColor,
                      fontSize: FontSize.labelAndFontButton,
                    ),
                  ),

                  const SizedBox(height: 5),

                  TextFormFeildWidget(
                    controller: username,
                    hintText: "enter username...",
                    validator: ValidatorApp.validateName,
                  ),

                  const SizedBox(height: 26),

                  Text(
                    "Email",
                    style: TextStyle(
                      color: AppColor.subTextColor,
                      fontSize: FontSize.labelAndFontButton,
                    ),
                  ),

                  const SizedBox(height: 5),

                  TextFormFeildWidget(
                    controller: email,
                    hintText: "enter email...",
                    validator: ValidatorApp.validateEmail,
                  ),

                  const SizedBox(height: 11),

                  Text(
                    "Password",
                    style: TextStyle(
                      color: AppColor.subTextColor,
                      fontSize: FontSize.labelAndFontButton,
                    ),
                  ),

                  const SizedBox(height: 6),

                  TextFormFeildWidget(
                    controller: password,
                    hintText: "Password...",
                    validator: ValidatorApp.validatePassword,
                    suffixIcon: Icons.visibility_off,
                  ),

                  const SizedBox(height: 24),

                  Text(
                    "Confirm Password",
                    style: TextStyle(
                      color: AppColor.subTextColor,
                      fontSize: FontSize.labelAndFontButton,
                    ),
                  ),

                  const SizedBox(height: 5),

                  TextFormFeildWidget(
                    controller: confirmPassword,
                    hintText: "Password...",
                    validator: (value) => ValidatorApp.validateConfirmPassword(
                      value,
                      password.text,
                    ),
                    suffixIcon: Icons.visibility_off,
                  ),

                  const SizedBox(height: 78),

                  MateralButtonWidget(
                    padding: 125,
                    data: "Register",
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusScope.of(context).unfocus();

                        context.read<AuthCubit>().register(
                          email: email.text,
                          password: password.text,
                          name: username.text
                        );
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
            Navigator.pushReplacementNamed(context, LoginScreen.routeName);
          },
          fristText: "Already have an account?",
          secondText: "Login",
        ),
      ),
    );
  }
}
