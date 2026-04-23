import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:tasky/features/auth/screens/login_screen.dart';
import 'package:tasky/features/auth/screens/register_screen.dart';
import 'package:tasky/features/auth/widget/show_dailog.dart';
import 'package:tasky/features/home/screens/home_screen.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
      routes: {
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
        HomeScreen.routeName: (context) => HomeScreen(),
      },
    );
  }
}

void loginInFirebase({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    showLoadingUi(context, text: "Loading...");
    await Future.delayed(Duration(milliseconds: 100));
    final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    showLoadingUi(context, text: "Login successfully");
    Navigator.pop(context);
    Navigator.of(context).pushNamed(HomeScreen.routeName);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'user-not-found') {
      showLoadingUi(context, text: "'No user found for that email.");
      Navigator.pop(context);
    } else if (e.code == 'wrong-password') {
      showLoadingUi(context, text: "Wrong password provided for that user.");
      Navigator.pop(context);
    }
  }
}

void registerUserInFirebase({
  required String email,
  required String password,
  required BuildContext context,
}) async {
  try {
    final credential = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  } catch (e) {
    print(e);
  }
}
