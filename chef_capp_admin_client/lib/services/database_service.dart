import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:chef_capp_admin_client/index.dart';

// how to ensure FlutterFire is always initialized? (await Firebase.initializeApp();)
// how to architect this directory?
// read all ingredients into models

class DatabaseService {
  FireState _fireState;
  final AuthService _authService = AuthService();
  final Cache cache;

  DatabaseService() : cache = Cache() {
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
    if (cache.ingredients.isSet) {
      return cache.ingredients.data;
    }

    await init();

    QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('ingredient').get();

    List<DBIngredientModel> out = [];
    for (DocumentSnapshot ds in qSnapshot.docs) {
      out.add(DBIngredientModel.fromDB(ds.data()));
    }

    cache.ingredients.data = out;
    return cache.ingredients.data;
  }

  Future<List<IngredientCategoryModel>> getIngredientCategories() async {
    if (cache.ingredientCategories.isSet) {
      return cache.ingredientCategories.data;
    }

    await init();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('ingredient-metadata').doc('categories').get();

    cache.ingredientCategories.data = snapshot.data()["keys"].map<IngredientCategoryModel>((cat) => IngredientCategoryModel(cat)).toList();
    return cache.ingredientCategories.data;
  }

  Future<List<SpecificUnitModel>> getSpecificUnits() async {
    if (cache.specificUnits.isSet) {
      return cache.specificUnits.data;
    }

    await init();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('ingredient-metadata').doc('specific-units').get();

    List<String> keys = snapshot.data()["keys"].map<String>((v) => v.toString()).toList();
    List<SpecificUnitModel> out = [];
    for (String k in keys) {
      out.add(SpecificUnitModel.fromDB(k, snapshot.data()[k]));
    }

    cache.specificUnits.data = out;
    return cache.specificUnits.data;
  }

  Future<List<RecipeModel>> getRecipes() async {
    if (cache.recipes.isSet) {
      return cache.recipes.data;
    }

    await init();

    QuerySnapshot qSnapshot = await FirebaseFirestore.instance.collection('recipe').get();

    List<RecipeModel> out = [];
    for (DocumentSnapshot ds in qSnapshot.docs) {
      if (ds.id != "metadata") {
        out.add(RecipeModel.fromDB(ds.data()));
      }
    }

    cache.recipes.data = out;
    return cache.recipes.data;
  }
}

enum FireState {
  Uninitialized,
  Initializing,
  Initialized,
}