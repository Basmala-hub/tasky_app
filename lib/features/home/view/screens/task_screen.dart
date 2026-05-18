import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/assets_icon/icon_model.dart';
import 'package:tasky/features/home/data/task_model.dart';
import 'package:tasky/features/home/view/screens/detials_screen.dart';
import 'package:tasky/features/home/view/widget/bottom_sheet.dart';
import 'package:tasky/features/home/view_model/home_cubit.dart';
import 'package:tasky/features/home/view_model/home_state.dart';

// ignore: must_be_immutable
class TaskScreen extends StatefulWidget {
  TaskScreen({super.key, required this.tasks});
  List<TaskModel> tasks;
  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  TextEditingController search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final activeTasks = widget.tasks.where((t) => !t.isDone).toList();
    final completedTasks = widget.tasks.where((t) => t.isDone).toList();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(IconModel.leading, width: 90),
                TextField(
                  controller: search,
                  decoration: InputDecoration(
                    hintText: "Search for your task...",
                    border: OutlineInputBorder(),
                    prefixIcon: IconButton(
                      onPressed: () {
                        context.read<HomeCubit>().searchTasks(search.text);
                      },
                      icon: Icon(Icons.search),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                BlocBuilder<HomeCubit, HomeState>(
                  builder: (context, state) {
                    if (state is HomeLoadingState) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (state is HomeSuccessState) {
                      final tasks = state.tasks;
                      return ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              title: Text(tasks[index].description),
                              subtitle: Text(tasks[index].formattedDate),
                            ),
                          );
                        },
                      );
                    }
                    return const SizedBox();
                  },
                ),
                SizedBox(
                  width: 100,
                  height: 31,
                  child: DropdownButtonFormField<String>(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hint: Text("Today"),
                      hintStyle: TextStyle(
                        fontSize: 12,
                        color: Color(0xff24252C),
                      ),
                    ),
                    items: completedTasks.map((value) {
                      return DropdownMenuItem(
                        value: value.formattedDate,
                        child: Text(value.formattedDate),
                      );
                    }).toList(),
                    onChanged: (value) {},
                  ),
                ),

                //! ACTIVE TASKS
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: activeTasks.length,
                  itemBuilder: (context, index) {
                    final task = activeTasks[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(
                              DetailsScreen.routename,
                              arguments: activeTasks[index],
                            )
                            .then((result) {
                              if (result == true) {
                                context.read<HomeCubit>().loadTasks();
                              }
                            });
                      },
                      child: Card(
                        child: ListTile(
                          leading: Checkbox(
                            value: activeTasks[index].isDone,
                            onChanged: (value) async {
                              await context.read<HomeCubit>().completeTask(
                                task,
                              );
                            },
                          ),
                          title: Text(task.description),
                          subtitle: Text(task.formattedDate),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(IconModel.flag),
                              SizedBox(width: 5),
                              Text("${task.priority}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    border: Border.all(color: Color(0xff6E6A7C)),
                  ),
                  child: Text("Completed"),
                ),
                SizedBox(height: 10),
                //! COMPLETED TASKS
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(
                              DetailsScreen.routename,
                              arguments: completedTasks[index],
                            )
                            .then((result) {
                              if (result == true) {
                                context.read<HomeCubit>().loadTasks();
                              }
                            });
                      },
                      child: Card(
                        child: ListTile(
                          leading: Checkbox(value: true, onChanged: (value) {}),
                          title: Text(completedTasks[index].description),
                          subtitle: Text(completedTasks[index].formattedDate),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Image.asset(IconModel.flag),
                              SizedBox(width: 5),
                              Text("${completedTasks[index].priority}"),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheetAddTaskWidget(),
          ).then((value) {
            context.read<HomeCubit>().loadTasks();
          });
        },
        backgroundColor: Color(0xff5F33E1),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
