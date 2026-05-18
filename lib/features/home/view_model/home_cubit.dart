import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/network/firebase/firebase_app.dart';
import 'package:tasky/features/home/data/task_model.dart';
import 'package:tasky/features/home/view_model/home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());
  List<TaskModel> tasks = [];
  List<TaskModel> completedTasks = [];
   bool isSearching = false;
    List<TaskModel> searchResults = [];
  //!load tasks
  Future<void> loadTasks() async {
    try {
      final result = await FireBase.getTasks();

      tasks = result;
      emit(HomeSuccessState(tasks));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  //! add task
  Future<void> addTask(TaskModel task) async {
    emit(HomeLoadingState());
    try {
      await FireBase.addTask(task);
      await loadTasks();
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  //! search task
 
  Future<void> searchTasks(String query) async {
    if (query.isEmpty) {
      isSearching = false;
      emit(HomeSuccessState(tasks));
      return;
    }

    emit(HomeLoadingState());
    try {
      final result = await FireBase.searchTasks(query);
      searchResults = result;
      isSearching = true;
      emit(HomeSuccessState(searchResults));
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  //!edit task
  Future<void> editTask(TaskModel task) async {
    emit(HomeLoadingState());
    try {
      await FireBase.editTask(task);
      await loadTasks();
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  //!complete task
  Future<void> completeTask(TaskModel task) async {
    emit(HomeLoadingState());

    try {
      await FireBase.completeTasks(task);
      await loadTasks();
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }

  //!delete task
  Future<void> deleteTask(String id) async {
    emit(HomeLoadingState());
    try {
      await FireBase.deleteTask(id);
      await loadTasks();
    } catch (e) {
      emit(HomeErrorState(e.toString()));
    }
  }
  //!fliteration by data
  filterByDate({required String date}){

  }
  //!clear search
  void clearSearch() {
  isSearching = false;
  emit(HomeSuccessState(tasks));
}
}
