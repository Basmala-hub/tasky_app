import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/assets_icon/icon_model.dart';
import 'package:tasky/core/utils/assets_image/image_model.dart';
import 'package:tasky/features/auth/view/screens/login_screen.dart';
import 'package:tasky/features/home/data/task_model.dart';
import 'package:tasky/features/home/view/screens/detials_screen.dart';
import 'package:tasky/features/home/view/widget/bottom_sheet.dart';
import 'package:tasky/features/home/view_model/home_cubit.dart';
import 'package:tasky/features/home/view_model/home_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static String routeName = "HomeScreen";
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadTasks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        if (state is HomeSuccessState) {
          return state.tasks.isNotEmpty
              ? TaskScreen(tasks: state.tasks)
              : const EmptyHomeScreen();
        }
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      },
    );
  }
}

//!empty screen
class EmptyHomeScreen extends StatelessWidget {
  const EmptyHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(IconModel.logo, width: 90),
            const Spacer(),
            Image.asset(IconModel.logOut, height: 30, width: 30),
            SizedBox(width: 5),
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.pushReplacementNamed(context, LoginScreen.routeName);
              },
              child: Text(
                "Log out",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            SizedBox(height: 100),
            Image.asset(ImageClass.undrawPushNotifications),
            SizedBox(height: 5),
            Text(
              "What do you want to do today?",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w400,
                color: Color(0xff404147),
              ),
            ),
            Text(
              "Tap + to add your tasks",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w400,
                color: Color(0xff404147),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) => BottomSheetAddTaskWidget(),
          );
        },
        backgroundColor: Color(0xff5F33E1),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}

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

                //! ACTIVE TASKS
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: activeTasks.length,
                  itemBuilder: (context, index) {
                    final task = widget.tasks[index];
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
                  itemCount: completedTasks.length,
                  itemBuilder: (context, index) {
                    final task = completedTasks[index];
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushNamed(DetailsScreen.routename, arguments: task)
                            .then((result) {
                              if (result == true) {
                                context.read<HomeCubit>().loadTasks();
                              }
                            });
                      },
                      child: Card(
                        child: ListTile(
                          leading: Checkbox(value: true, onChanged: (value) {}),
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
          );
        },
        backgroundColor: Color(0xff5F33E1),
        child: Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }
}
