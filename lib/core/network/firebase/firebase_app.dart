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
          fromFirestore: (snapshot, _) => UserdData.fromJson(snapshot.data()!),
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

  //!add task function
  static Future<void> addTask(TaskModel task) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final taskCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks");
      await taskCollection.add(task.toJson());
    }
  }

  //!get tasks function
 static Future<List<TaskModel>> getTasks() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final taskCollection = FirebaseFirestore.instance
        .collection("users")
        .doc(user.uid)
        .collection("tasks");

    final tasks = await taskCollection.orderBy("priority").get();

    return tasks.docs.map((doc) {
      return TaskModel.fromJson(doc.data(), doc.id);
    }).toList();
  }

  //!search tasks function
static  Future<List<TaskModel>> searchTasks(String query) async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    try {
      final taskCollection = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks");

      final tasks = await taskCollection
          .orderBy("title")
          .startAt([query])
          .endAt(['$query\uf8ff'])
          .get();

      return tasks.docs.map((doc) {
        return TaskModel.fromJson(doc.data(), doc.id);
      }).toList();
    } catch (e) {
      throw Exception("Error searching tasks: $e");
    }
  }

  //!edit task function
static  Future<void> editTask(TaskModel task) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }
    try {
      final taskModify = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .doc(task.id);
      await taskModify.update(task.toJson());
    } catch (e) {
      throw Exception("Error editing task$e");
    }
  }

  //!complete task function
 static Future<TaskModel> completeTasks(TaskModel task) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }
    try {
      final taskModify = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .doc(task.id);
      await taskModify.update({"isDone": !task.isDone});
      final updatedTask = await taskModify.get();
      return TaskModel.fromJson(updatedTask.data()!, updatedTask.id);
    } catch (e) {
      throw Exception("Error completing task");
    }
  }

  //!delete task function
static  Future<void> deleteTask(String id) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      throw Exception("User not logged in");
    }

    try {
      final deletedTask = FirebaseFirestore.instance
          .collection("users")
          .doc(user.uid)
          .collection("tasks")
          .doc(id);
          await deletedTask.delete();
    } catch (e) {
      throw Exception("Error delete task$e");
    }
  }

  //!filter tasks function

}
