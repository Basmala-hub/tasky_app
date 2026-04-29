import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/utils/assets_icon/icon_model.dart';
import 'package:tasky/core/utils/assets_image/image_model.dart';
import 'package:tasky/features/auth/view/screens/login_screen.dart';
import 'package:tasky/features/home/data/task_model.dart';
import 'package:tasky/features/home/view/widget/bottom_sheet.dart';
import 'package:tasky/features/home/view_model/home_cubit.dart';
import 'package:tasky/features/home/view_model/home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const String routeName = "HomeScreen";

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is HomeSuccessState) {
          return TaskScreen(tasks: state.tasks);
        }
        return const EmptyHomeScreen();
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
              onTap: () async {
                await FirebaseAuth.instance.signOut();
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
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
          child: Column(
            children: [
              Image.asset(IconModel.leading, width: 90),
              TextField(
                controller: search,
                decoration: InputDecoration(
                  hintText: "Search for your task...",
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                ),
              ),
              ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      leading: Checkbox(value: false, onChanged: (value) {}),
                      title: Text(widget.tasks[index].description),
                      subtitle: Text("${widget.tasks[index].createdAt}"),
                      trailing: Container(
                        child: Row(
                          children: [
                            Image.asset(IconModel.flag),
                            Text("${widget.tasks[index].priority}"),
                          ],
                        ),
                      ),
                    ),
                  );
                },
                itemCount: widget.tasks.length,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
