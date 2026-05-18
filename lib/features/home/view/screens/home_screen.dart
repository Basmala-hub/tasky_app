
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/features/home/view/screens/empty_screen.dart';
import 'package:tasky/features/home/view/screens/task_screen.dart';
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
