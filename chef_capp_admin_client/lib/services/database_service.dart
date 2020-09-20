import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:chef_capp_admin_client/index.dart';

// how to ensure FlutterFire is always initialized? (await Firebase.initializeApp();)
// how to architect this directory?
// read all ingredients into models

class DatabaseService {
  FireState _fireState;
  final AuthService _authService = AuthService();
  final Cache cache;

  static const String _baseUrl = 'http://ec2-3-17-181-130.us-east-2.compute.amazonaws.com';

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

  // streams?!
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

  Future<void> getRecipeSteps(RecipeModel recipe) async {
    await init();

    List<String> ids = recipe.steps.map<String>((s) => s.id.toString()).toList();
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('step').where('id', whereIn: ids).get();

    if (qs.docs.length != ids.length) {
      throw ("Did not fetch correct number of components from the DB");
    }

    List<RecipeStepModel> steps = [];
    for (int i = 0; i < ids.length; i++) {
      steps.add(RecipeStepModel.fromDB(qs.docs[i].data(), i+1));
    }

    recipe.steps = steps;
  }

  Future<bool> saveIngredient(DBIngredientModel model) async {
    String url = _baseUrl + '/ingredient/add';

    var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(model.toJson())
    );

    print(response.body);
  }
}

enum FireState {
  Uninitialized,
  Initializing,
  Initialized,
}