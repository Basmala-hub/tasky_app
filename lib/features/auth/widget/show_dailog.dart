import 'package:flutter/material.dart';

import '../../../core/utils/app_colors/color_model.dart';



void showLoadingUi(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColor.secondaryColor,
        content: SizedBox(
          height: 40,
          width: 40,
          child: Center(
            child: Row(
              spacing: 30,
              mainAxisAlignment: .center,
              children: [
                CircularProgressIndicator(color: AppColor.parimerayColor),
                Text(
                  "Loading...",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: .w400,
                    color: AppColor.superTextColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
