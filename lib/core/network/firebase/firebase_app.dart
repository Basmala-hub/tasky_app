import 'package:firebase_auth/firebase_auth.dart';
import 'package:tasky/core/network/data/state_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:tasky/features/auth/data/user_model.dart';

 class FireBase {

 static CollectionReference<UserdData> get _getCollection {
  return FirebaseFirestore.instance
      .collection("users")
      .withConverter<UserdData>(
        fromFirestore: (snapshot, _) =>
            UserdData.fromJson(snapshot.data()!),
        toFirestore: (user, _) => user.toJson(),
      );
}

static Future<void> addUser(UserdData user) async {
  await _getCollection.doc(user.id).set(user);
}
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
