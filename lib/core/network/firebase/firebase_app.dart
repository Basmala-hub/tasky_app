import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/core/network/data/state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasky/features/auth/data/user_model.dart';
import 'package:tasky/features/home/data/task_model.dart';

 class FireBase {
//! create collection reference with converter
 static CollectionReference<UserdData> get _getCollection {
  return FirebaseFirestore.instance
      .collection("users")
      .withConverter<UserdData>(
        fromFirestore: (snapshot, _) =>
            UserdData.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
}
//?add user function
static Future<void> addUser(UserdData user) async {
  await _getCollection.doc(user.id).set(user);
}
//! get user function
static Future<UserdData?> getUser(String id) async {
  final doc = await _getCollection.doc(id).get();
  return doc.data();
}
// static Future<void> addTask(TaskModel task)async{
// await  _getCollection.doc(UserData.).set( task.tojson(task));
// }

//!register function
  static Future<StateModel> register({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      return Success(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return Erorr("he password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        return Erorr("The account already exists for that email.");
      }
      return Erorr(e.toString());
    } catch (e) {
      return Erorr(e.toString());
    }
  }
//!login function
  static Future<StateModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Success(credential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        return Erorr("No user found for that email.");
      } else if (e.code == 'wrong-password') {
        return Erorr("Wrong password provided for that user.");
      }
      return Erorr(e.toString());
    }
  }
}
