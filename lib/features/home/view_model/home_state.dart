import 'package:tasky/features/home/data/task_model.dart';

abstract class  HomeState {
}
class HomeInitialState extends HomeState {
}
class HomeLoadingState extends HomeState {
}
class HomeSuccessState extends HomeState {
  List<TaskModel>tasks;
  HomeSuccessState(this.tasks);
}