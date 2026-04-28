import 'package:tasky/features/auth/data/user_model.dart';

abstract class AuthState {}
class AuthInitialState extends AuthState {}
class AuthLoadingState extends AuthState {}
class AuthSuccessState extends AuthState {}
class AuthErrorState extends AuthState {
  final String errorMessage;
  AuthErrorState(this.errorMessage);
}

abstract class UserState{}
class UserInitialState extends UserState{}
class UserLoadingState extends UserState{}
class UserSuccessState extends UserState{
    final UserdData user;
  UserSuccessState(this.user);
}
class UserErrorState extends UserState{
  final String errorMessage;
  UserErrorState(this.errorMessage);
}