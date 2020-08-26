import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  auth.FirebaseAuth _auth;
  auth.User _user;

  Future<bool> init() async {
    await Firebase.initializeApp();
    if (_auth == null) {
      _auth = auth.FirebaseAuth.instance;
    }
    if (_user == null) {
      try {
        _user = (await _auth.signInAnonymously()).user;
      } catch (e) {
        print(e);
      }
    }
    return (_user != null);
  }

  Future<void> getTestRecipePreview() async {
    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('recipes').doc('f680874b-cb0b-4b25-ba74-a8ed39824202').get();
    //String imgURL = await getImageURL('img/recipes/f680874b-cb0b-4b25-ba74-a8ed3982420.jpg');

    if (!snapshot.exists) {
      throw ("Document does not exist");
    } else {
      print(snapshot.data);
      snapshot.data().forEach((k,v) {
        print(v);
      });
    }

    //return RecipePreview.fromDB(snapshot.data, imgURL);
  }

  Future<void> test() async {
    print("testing...");

    bool signedIn = await init();

    if (signedIn) {
      print("signed in");
    } else {
      print("couldn't sign in");
      return;
    }

    await getTestRecipePreview();
  }
}