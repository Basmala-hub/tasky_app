import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/network/data/state_model.dart';
import 'package:tasky/core/network/firebase/firebase_app.dart';
import 'package:tasky/features/auth/data/user_model.dart';
import 'package:tasky/features/auth/view_model/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitialState());
  //!register function
  Future<void> register({
    required String email,
    required String password,
  }) async {
    emit(AuthLoadingState());
    try {
      final result = await FireBase.register(email: email, password: password);
      switch (result) {
        case Success():
          emit(AuthSuccessState());
          break;
        case Erorr():
          emit(AuthErrorState(result.message));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }

  //!login function
  Future<void> login({required String email, required String password}) async {
    emit(AuthLoadingState());
    try {
      final result = await FireBase.login(email: email, password: password);
      switch (result) {
        case Success():
          emit(AuthSuccessState());
          break;
        case Erorr():
          emit(AuthErrorState(result.message));
      }
    } catch (e) {
      emit(AuthErrorState(e.toString()));
    }
  }
}
//!user cubit

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitialState());
  //!add user function
  Future<void> addUser(UserdData user) async {
    emit(UserLoadingState());
    try {
      await FireBase.addUser(user);
      emit(UserSuccessState(user));
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
//!get user function
  Future<void> getUser(String id) async {
    emit(UserLoadingState());
    try {
      final user = await FireBase.getUser(id);
      if (user != null) {
        emit(UserSuccessState(user));
      } else {
        emit(UserErrorState("User not found"));
      }
    } catch (e) {
      emit(UserErrorState(e.toString()));
    }
  }
}
