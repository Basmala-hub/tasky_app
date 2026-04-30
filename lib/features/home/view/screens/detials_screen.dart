import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/assets_icon/icon_model.dart';
import 'package:tasky/features/auth/view/widget/material_button_widget.dart';
import 'package:tasky/features/home/data/task_model.dart';
import 'package:tasky/features/home/view/widget/bottom_sheet.dart';
import 'package:tasky/features/home/view_model/home_cubit.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  static const String routename = "DetailsScreen";

  @override
  Widget build(BuildContext context) {
  
    final task = ModalRoute.of(context)?.settings.arguments as TaskModel;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.cancel_presentation, color: Colors.red),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            
            Row(
              children: [
                Checkbox(
                  value: task.isDone,
                  onChanged: (value) async {
                    await context.read<HomeCubit>().completeTask(task);
                  },
                ),
                Text(
                  task.title,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            Text(task.description),
            const SizedBox(height: 20),

            _buildInfoRow(
              icon: IconModel.timer,
              label: "Task Time :",
              value: task.formattedDate,
            ),
            const SizedBox(height: 15),
            _buildInfoRow(
              icon: IconModel.flag,
              label: "Task Priority :",
              value: "${task.priority}",
            ),

            const Spacer(),

            InkWell(
              onTap: () {
                context.read<HomeCubit>().deleteTask(task.id ?? "");
                Navigator.pop(context);
              },
              child: Row(
                children: [
                  Image.asset(IconModel.remove, width: 24),
                  const SizedBox(width: 8),
                  const Text(
                    "Delete Task",
                    style: TextStyle(color: Colors.red),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: MateralButtonWidget(
                data: "Edit Task",
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => BottomSheetAddTaskWidget(task: task),
                  );
                },
                padding: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow({
    required String icon,
    required String label,
    required String value,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Image.asset(icon, width: 24),
            const SizedBox(width: 8),
            Text(label),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            color: const Color(0xffF0F0F0),
          ),
          child: Text(value),
        ),
      ],
    );
  }
}
