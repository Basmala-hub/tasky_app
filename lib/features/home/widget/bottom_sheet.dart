import 'package:flutter/material.dart';
import 'package:tasky/core/utils/app_colors/color_model.dart';
import 'package:tasky/core/utils/app_font_size/font_size_model.dart';
import 'package:tasky/core/utils/assets_icon/icon_model.dart';
import 'package:tasky/features/home/widget/show_alert_dailog_piriority_widget.dart';
import 'package:tasky/features/home/widget/show_sate_picker_widget.dart';

void showModalBottomSheetContinair(
  BuildContext context,
  WidgetBuilder builder,
) {
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return BottomSheetAddTaskWidget();
    },
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
  );
}

class BottomSheetAddTaskWidget extends StatefulWidget {
  BottomSheetAddTaskWidget({super.key});

  @override
  State<BottomSheetAddTaskWidget> createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTaskWidget> {
  var selectedTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 27),
      child: Column(
        children: [
          Text("Add Task"),
          TextField(
            decoration: InputDecoration(
              hintText: "Enter task name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            decoration: InputDecoration(
              hintText: "Description",
              border: OutlineInputBorder(),
            ),
          ),
          Row(
            mainAxisAlignment: .spaceBetween,

            children: [
              Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  InkWell(
                    child: Image.asset(IconModel.timer),
                    onTap: () async {
                      selectedTime =
                          await selectTime(context) ?? DateTime.now();
                    },
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    child: Image.asset(IconModel.flag),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return ShowAlertDailogWidget();
                        },
                      );
                    },
                  ),
                ],
              ),
              InkWell(child: Image.asset(IconModel.send), onTap: () {}),
            ],
          ),
        ],
      ),
    );
  }
}
