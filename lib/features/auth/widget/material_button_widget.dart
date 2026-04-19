import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';

class MateralButtonWidget extends StatelessWidget {
  const MateralButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColor.parimerayColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: 144),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: () {},
      child: Text(
        "Login",
        style: TextStyle(
          fontSize: FontSize.labelAndFontButton,
          color: AppColor.colorTextInButton,
        ),
      ),
    );
  }
}
