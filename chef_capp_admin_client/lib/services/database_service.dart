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
    if (_fireState == FireState.Uninitialized) {
      _fireState = FireState.Initializing;
      await Firebase.initializeApp();
      await _authService.init();
      _fireState = FireState.Initialized;
      return true;
    } else {
      return false;
    }
  }

  Future<void> test() async {
    print("testing");
    await init();
    print("inited");
    await getIngredients();
    print("got ingredients");
  }

  Future<List<ZeroIngredientModel>> getIngredients() async {
    if (_fireState != FireState.Initialized) {
      // throw something?
      // try to initialize?
      return [];
    }

    QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('ingredients').get();

    List<ZeroIngredientModel> out = [];
    for (DocumentSnapshot ds in qSnapshot.docs) {
      if (ds.id != "metadata") {
        out.add(ZeroIngredientModel.fromDB(ds.data()));
      }
    }

    for (ZeroIngredientModel zi in out) {
      print(zi);
    }

    return out;
  }
}

enum FireState {
  Uninitialized,
  Initializing,
  Initialized,
}