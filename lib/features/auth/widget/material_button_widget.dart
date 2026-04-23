import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';

class MateralButtonWidget extends StatelessWidget {
  MateralButtonWidget({super.key, required this.onPressed, required this.data,required this.padding});
  void Function()? onPressed;
  double padding;
  String data;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColor.parimerayColor,
      padding: EdgeInsets.symmetric(vertical: 12, horizontal: padding),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onPressed: onPressed,
      child: Text(
        data,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: FontSize.labelAndFontButton,
          color: AppColor.colorTextInButton,
        ),
      ),
    );
  }
}
