import 'package:firebase_auth/firebase_auth.dart';

class AuthRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInAnonymously() {
    return _auth.signInAnonymously();
  }
}
