import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chef_capp_admin_client/index.dart';

// how to ensure FlutterFire is always initialized? (await Firebase.initializeApp();)
// how to architect this directory?
// read all ingredients into models

class DatabaseService {
  FireState _fireState; // 0: not initialized, 1: attempting to initialize, 2: initialized
  final AuthService _authService = AuthService();

  DatabaseService() {
    _fireState = FireState.Uninitialized;
  }

  Future<bool> init() async {
    if (_fireState == FireState.Initialized) {
      return true;
    } else if (_fireState == FireState.Uninitialized) {
      _fireState = FireState.Initializing;
      await Firebase.initializeApp();
      await _authService.init();
      _fireState = FireState.Initialized;
      return true;
    } else {
      while (_fireState != FireState.Initialized) {
        await Future.delayed(Duration(milliseconds: 1));
      }
      return true;
    }
  }

  Future<void> test() async {
    print("testing");
    await init();
    print("inited");
    await getIngredients();
    print("got ingredients");
  }

  Future<List<DBIngredientModel>> getIngredients() async {
    await init();

    QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('ingredients').get();

    List<DBIngredientModel> out = [];
    for (DocumentSnapshot ds in qSnapshot.docs) {
      if (ds.id != "metadata") {
        out.add(DBIngredientModel.fromDB(ds.data()));
      }
    }

    return out;
  }

  Future<List<String>> getIngredientCategories() async {
    await init();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('ingredients').doc('metadata').get();

    return snapshot.data()['categories'];
  }

  Future<List<String>> getIngredientSpecificUnits() async {
    await init();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('ingredients').doc('metadata').get();

    return snapshot.data()['specific-units'];
  }

  Future<List<RecipeModel>> getRecipes() async {
    await init();

    QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('recipes').get();

    List<RecipeModel> out = [];
    for (DocumentSnapshot ds in qSnapshot.docs) {
      if (ds.id != "metadata") {
        out.add(RecipeModel.fromDB(ds.data()));
      }
    }

    return out;
  }
}

enum FireState {
  Uninitialized,
  Initializing,
  Initialized,
}