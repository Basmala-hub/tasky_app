abstract class FirebaseAuth {



  
  Future<String> signInWithEmailAndPassword(
      String email, String password);
  Future<String> signUpWithEmailAndPassword(
      String email, String password);
  Future<void> signOut();
  Future<String?> getCurrentUserId();
}