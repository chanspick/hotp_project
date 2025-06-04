import 'package:firebase_core/firebase_core.dart';

class FirebaseService {
  Future<FirebaseApp> initialize(FirebaseOptions options) {
    return Firebase.initializeApp(options: options);
  }
}
