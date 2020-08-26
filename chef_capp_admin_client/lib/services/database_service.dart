import 'package:firebase_core/firebase_core.dart';


// how to ensure FlutterFire is always initialized? (await Firebase.initializeApp();)
// how to architect this directory?
// read all ingredients into models

class DatabaseService {
  Future<void> init() async {
    await Firebase.initializeApp();
  }
}