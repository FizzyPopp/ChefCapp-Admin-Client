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

  Future<List<DBIngredientUnitModel>> getSpecificUnits() async {
    if (cache.specificUnits.isSet) {
      return cache.specificUnits.data;
    }

    await init();

    DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('ingredient-metadata').doc('specific-units').get();

    List<String> keys = snapshot.data()["keys"].map<String>((v) => v.toString()).toList();
    List<DBIngredientUnitModel> out = [];
    for (String k in keys) {
      out.add(DBIngredientUnitModel.fromDB(k, snapshot.data()[k]));
    }

    out.insert(0, DBIngredientUnitModel.wholeOptions[0]); // add empty first element

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

    List<String> ids = recipe.steps.map<String>((s) => s.id.toString())
        .toList();
    QuerySnapshot qs = await FirebaseFirestore.instance.collection('step')
        .where('id', whereIn: ids)
        .get();

    // this section to find "unique" steps is an abomination and needs to be fixed
    // find unique steps, take most recent in terms of timestamp
    List<Map<String, dynamic>> unique = List<Map<String, dynamic>>();
    List<int> taken = [];
    for (int i = 0; i < qs.docs.length; i++) {
      int mostRecent = i;
      for (int j = 0; j < qs.docs.length; j++) {
        if (qs.docs[mostRecent].data()["id"] == qs.docs[j].data()["id"] && qs.docs[mostRecent].data()["timestamp"] < qs.docs[j].data()["timestamp"]) {
          mostRecent = j;
        }
      }
      if (!taken.contains(mostRecent)) {
        unique.add(qs.docs[mostRecent].data());
      }
      taken.add(mostRecent);
    }

    if (unique.length != ids.length) {
      throw ("Did not fetch correct number of steps from the DB");
    }

    List<Map<String, dynamic>> rawDataInOrder = [];
    Map<String, dynamic> r = unique.firstWhere((j) => j["previous"] == IDModel.nilUUID());
    rawDataInOrder.add(r);
    while (r["next"] != IDModel.nilUUID() && r != null) {
      r = unique.firstWhere((j) => j["previous"] == r["id"], orElse: () => null);
      rawDataInOrder.add(r);
    }

    if (r == null) {
      throw("something went wrong");
    }

    if (rawDataInOrder.length != unique.length) {
      print("something else went wrong");
    }

    List<RecipeStepModel> steps = [];
    for (int i = 0; i < rawDataInOrder.length; i++) {
      steps.add(RecipeStepModel.fromDB(rawDataInOrder[i], i+1));
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

    if (response.body == "Object with same hash found.") {
      return true;
    } else {
      try {
        if (jsonDecode(response.body)["errors"] == null) {
          return true;
        }
      } catch(e) {
        print(e);
      }
      return false;
    }
  }

  Future<bool> saveRecipe(RecipeModel model) async {
    String url = _baseUrl + '/recipe/build';
    //String url = _baseUrl + '/instruction/parse';

    // saving a recipe: send list of steps to be "Stamped" -> get back list of steps as well as a half-empty recipe object
    // fill in half-empty recipe object
    // send full recipe object and list of steps to be validated and, if successfully validated, saved

    print("ORIGINAL");
    print(jsonEncode(model.stepsToJson()));
    print("");

    var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(model.stepsToJson())
    );

    print("RESPONSE");
    print(response.body);
    print("");

    if (response.body == "Object with same hash found.") {
      return true;
    } else {
      try {
        if (jsonDecode(response.body)["errors"] != null) {
          return false;
        }
      } catch(e) {
        print(response.body);
        print(e);
        return false;
      }
    }

    Map<String, dynamic> jsonResponse = jsonDecode(response.body);

    // stepsCandidate = what got sent
    // stampedSteps = completed steps list
    // recipeCandidate = half-empty recipe object, need:

    // recipe name, id (if existing), ["time"]["cook"] and ["time"]["prep"]
    // then call /recipe/add, with steps: [stampedSteps], recipe: [recipeCandidate]

    jsonResponse["recipeCandidate"]["id"] = model.id.toString();
    jsonResponse["recipeCandidate"]["name"] = {"singular": model.title};

    Map<String, dynamic> toAdd = {
      "recipe": jsonResponse["recipeCandidate"],
      "steps": jsonResponse["stampedSteps"],
    };

    // /instructions/validate

    print("STAMPED");
    print(jsonEncode(jsonResponse["stampedSteps"]));
    print("");
    print("RECIPE");
    print(jsonEncode(jsonResponse["recipeCandidate"]));
    print("");

    // CHECK IF STAMPEDSTEPS.LENGTH == STEPSCANDIDATE.LENGTH == MODEL.STEPSTOJSON().LENGTH ?

    url = _baseUrl + "/recipe/add";

    response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(toAdd),
    );

    print(response.body);

    if (response.body == "Object with same hash found.") {
      return true;
    } else {
      try {
        if (jsonDecode(response.body)["errors"] != null) {
          return false;
        }
      } catch(e) {
        print(e);
        return false;
      }
    }
  }
}

enum FireState {
  Uninitialized,
  Initializing,
  Initialized,
}