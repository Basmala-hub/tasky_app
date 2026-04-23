import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';
class BottomNavgationContent extends StatelessWidget {
  BottomNavgationContent({super.key, this.fristText, this.secondText,required this.onTap});
String? fristText;
String? secondText;
void Function()? onTap;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,
        height: 33,
        alignment: Alignment.center,
        child: InkWell(
          onTap: onTap,
          child: RichText(
            text: TextSpan(
              text: fristText,
              style: TextStyle(
                fontSize: FontSize.bottomNavagationBarFont,
                color: AppColor.subTextColor,
              ),
              children: [
                TextSpan(
                  text: secondText,
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
