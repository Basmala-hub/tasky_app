import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/assets_icon/icon_model.dart';
import 'package:tasky/features/home/data/task_model.dart';
import 'package:tasky/features/home/view/widget/show_alert_dailog_piriority_widget.dart';
import 'package:tasky/features/home/view/widget/show_sate_picker_widget.dart';
import 'package:tasky/features/home/view_model/home_cubit.dart';

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
  const BottomSheetAddTaskWidget({super.key});

  @override
  State<BottomSheetAddTaskWidget> createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTaskWidget> {
  var selectedTime = DateTime.now();
  int priority = 1;
  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 27),
      child: Column(
        children: [
          Text("Add Task"),
          TextField(
            controller: name,
            decoration: InputDecoration(
              hintText: "Enter task name",
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 12),
          TextField(
            controller: description,
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
                    onTap: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) {
                          return const ShowAlertDailogWidget();
                        },
                      );

                      if (result != null) {
                        setState(() {
                          priority = result;
                        });
                      }
                    },
                  ),
                ],
              ),
              InkWell(
                child: Image.asset(IconModel.send),
                onTap: () {
                  final task = TaskModel(
                    title: name.text,
                    description: description.text,
                    isDone: false,
                    createdAt: selectedTime,
                    priority: priority,
                  );
                  context.read<HomeCubit>().addTask(task);
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

