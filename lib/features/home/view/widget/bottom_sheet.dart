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

// ignore: must_be_immutable
class BottomSheetAddTaskWidget extends StatefulWidget {
  BottomSheetAddTaskWidget({super.key, this.task});
  TaskModel? task;

  @override
  State<BottomSheetAddTaskWidget> createState() => _BottomSheetAddTaskState();
}

class _BottomSheetAddTaskState extends State<BottomSheetAddTaskWidget> {
  var selectedTime = DateTime.now();
  int priority = 1;

  TextEditingController name = TextEditingController();
  TextEditingController description = TextEditingController();

  @override
  void initState() {
    super.initState();

    if (widget.task != null) {
      name.text = widget.task!.title;
      description.text = widget.task!.description;
      priority = widget.task!.priority;

      selectedTime = DateTime.fromMillisecondsSinceEpoch(
        widget.task!.createdAt,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(widget.task == null ? "Add Task" : "Edit Task"),

          const SizedBox(height: 12),

          TextField(
            controller: name,
            decoration: const InputDecoration(
              hintText: "Enter task name",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          TextField(
            controller: description,
            decoration: const InputDecoration(
              hintText: "Description",
              border: OutlineInputBorder(),
            ),
          ),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  InkWell(
                    child: Image.asset(IconModel.timer),
                    onTap: () async {
                      final picked = await selectTime(context);
                      if (picked != null) {
                        setState(() {
                          selectedTime = picked;
                        });
                      }
                    },
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    child: Image.asset(IconModel.flag),
                    onTap: () async {
                      final result = await showDialog(
                        context: context,
                        builder: (context) => const ShowAlertDailogWidget(),
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
                  if (name.text.isEmpty) return;
                  if (widget.task == null) {
                    final task = TaskModel(
                      title: name.text,
                      description: description.text,
                      isDone: false,
                      createdAt: selectedTime.millisecondsSinceEpoch,
                      priority: priority,
                    );

                    context.read<HomeCubit>().addTask(task);
                    Navigator.pop(context, true);
                  } else {
                    final updatedTask = TaskModel(
                      id: widget.task!.id,
                      title: name.text,
                      description: description.text,
                      isDone: widget.task!.isDone,
                      createdAt: selectedTime.millisecondsSinceEpoch,
                      priority: priority,
                    );

                    context.read<HomeCubit>().editTask(updatedTask);
                    Navigator.pop(context, true);
                  }

                  Navigator.pop(context, true);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
