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
    //String url = _baseUrl + '/instructions/parse';
    String url = _baseUrl + '/validate';

    // saving a recipe: send list of steps to be "Stamped" -> get back list of steps as well as a half-empty recipe object
    // fill in half-empty recipe object
    // send full recipe object and list of steps to be validated and, if successfully validated, saved

    List<Map<String, dynamic>> testData = [
      {
        "id": "b0dab33b-dd59-45f0-8e74-8c4bfa5e27e2",
        "name": { "singular": "prepare and chop" },
        "previous":"f680874b-cb0b-4b25-ba74-a8ed39824202",
        "next": "1557c8af-276d-4fdc-beea-c16b37fefe00",
        "type": "step",
        "time": {
          "min": 0,
          "max": 0
        },
        "ingredients": {
          "keys": [
            "402dd73d-8296-4136-9f53-1a5276d09728",
            "a0b05d47-fc8e-40a6-ab2e-6a24b3f3ffbd",
            "168c32e7-4171-468f-82e9-08d2e4f69431",
            "50e15e5c-64bb-4ddf-aecf-f9b3c5e2ba5a",
            "74143f94-79c3-486c-893d-9f0a571f80e2",
            "68faa9f3-bc96-4d2f-9827-edb16385c44a",
            "f46e24db-4886-4dff-9b88-3fa255b12abe"
          ],

          "402dd73d-8296-4136-9f53-1a5276d09728": {
            "id": "402dd73d-8296-4136-9f53-1a5276d09728",
            "name": {
              "singular": "Baby Potato",
              "plural": "Baby Potatoes"
            },
            "unit": "",
            "quantity": 8
          },

          "a0b05d47-fc8e-40a6-ab2e-6a24b3f3ffbd": {
            "id": "a0b05d47-fc8e-40a6-ab2e-6a24b3f3ffbd",
            "name": {
              "singular": "Yellow Onion",
              "plural": "Yellow Onions"
            },
            "unit": "",
            "quantity": 1
          },

          "168c32e7-4171-468f-82e9-08d2e4f69431": {
            "id": "168c32e7-4171-468f-82e9-08d2e4f69431",
            "name": {
              "singular": "Green Bell Pepper",
              "plural": "Green Bell Peppers"
            },
            "unit": "",
            "quantity": 2
          },

          "50e15e5c-64bb-4ddf-aecf-f9b3c5e2ba5a": {
            "id": "50e15e5c-64bb-4ddf-aecf-f9b3c5e2ba5a",
            "name": {
              "singular": "Parsley",
              "plural": "Parsley"
            },
            "unit": "g",
            "quantity": 15
          },

          "74143f94-79c3-486c-893d-9f0a571f80e2": {
            "id": "74143f94-79c3-486c-893d-9f0a571f80e2",
            "name": {
              "singular": "Green Onion",
              "plural": "Green Onions"
            },
            "unit": "",
            "quantity": 4
          },

          "68faa9f3-bc96-4d2f-9827-edb16385c44a": {
            "id": "68faa9f3-bc96-4d2f-9827-edb16385c44a",
            "name": {
              "singular": "Cherry Tomato",
              "plural": "Cherry Tomatoes"
            },
            "unit": "g",
            "quantity": 250
          },

          "f46e24db-4886-4dff-9b88-3fa255b12abe": {
            "id": "f46e24db-4886-4dff-9b88-3fa255b12abe",
            "name": {
              "singular": "Garlic",
              "plural": "Garlic"
            },
            "unit": "cloves",
            "quantity": 3
          }
        },
        "utensils": [
          "baking sheet",
          "knife"
        ],
        "appliances": [
          "oven"
        ],
        "instructions": "Preheat the oven to 425°F. Line a baking sheet with parchment paper. Cut @[potatoes] into ½-inch cubes. Slice @[onion]. Core and cut @[peppers] into ½-inch pieces. Finely chop @[parsley]. Thinly slice @[green onions]. Halve @[cherry tomatoes]. Peel, then mince @[garlic]."
      },
      {
        "previous": "b0dab33b-dd59-45f0-8e74-8c4bfa5e27e2",
        "id": "1557c8af-276d-4fdc-beea-c16b37fefe00",
        "next": "b28a4893-33b0-4c03-a432-7bbe1752be3c",
        "type": "step",
        "name": { "singular": "bake potatoes" },
        "tags": [],
        "calories": 2,
        "time": {
          "min": 18,
          "max": 20,
          "unit": "min"
        },
        "ingredients": {
          "keys": [
            "67054860-6770-4085-95c7-3ef82d9a2d93"
          ],
          "67054860-6770-4085-95c7-3ef82d9a2d93": {
            "id": "67054860-6770-4085-95c7-3ef82d9a2d93",
            "name": {
              "singular": "Peanut Oil",
              "plural": "Peanut Oil"
            },
            "unit": {
              "singular": "tbsp",
              "plural": "tbsp",
              "measurementType": "volume",
              "unitCategory": "SI"
            },
            "quantity": 1
          }
        },
        "utensils": [
          "baking sheet"
        ],
        "appliances": [
          "oven"
        ],
        "instructions": "Toss the @[potatoes] and @[oil] on the baking sheet. Season with @[salt] and @[pepper]. Roast in middle of oven, flip halfway, and cook until golden-brown, %[18-20 min]. While potatoes roast, proceed to the next step."
      },
      {
        "previous": "1557c8af-276d-4fdc-beea-c16b37fefe00",
        "id": "b28a4893-33b0-4c03-a432-7bbe1752be3c",
        "next": "83a5da3a-864c-4b01-81e5-487210c1a826",
        "type": "step",
        "name": { "singular": "make aioli" },
        "tags": [],
        "calories": 3,
        "time": {
          "min": 0,
          "max": 0
        },
        "ingredients": {
          "keys": [
            "c764eb89-6fe4-4375-a41e-48b4548cb0da"
          ],
          "c764eb89-6fe4-4375-a41e-48b4548cb0da": {
            "id": "c764eb89-6fe4-4375-a41e-48b4548cb0da",
            "name": {
              "singular": "Mayonnaise",
              "plural": "Mayonnaise"
            },
            "unit": "cup",
            "quantity": 0.5
          }
        },
        "utensils": [
          "bowl"
        ],
        "appliances": [],
        "instructions": "While potatoes roast, make the aioli in a small bowl by stirring together #[½] \$[cup] @[mayonnaise], #[half of] the chopped @[parsley] and #[½] \$[tsp] minced @[garlic]. Set aside."
      },
      {
        "previous": "b28a4893-33b0-4c03-a432-7bbe1752be3c",
        "id": "83a5da3a-864c-4b01-81e5-487210c1a826",
        "next": "900491c2-4181-4ceb-8366-e600edbc8440",
        "type": "step",
        "name": { "singular": "soften onions" },
        "tags": [],
        "calories": 4,
        "time": {
          "min": 2,
          "max": 3,
          "unit": "min"
        },
        "ingredients": {
          "keys": [
            "67054860-6770-4085-95c7-3ef82d9a2d93"
          ],
          "67054860-6770-4085-95c7-3ef82d9a2d93": {
            "id": "67054860-6770-4085-95c7-3ef82d9a2d93",
            "name": {
              "singular": "Peanut Oil",
              "plural": "Peanut Oil"
            },
            "unit": "tbsp",
            "quantity": 1
          }
        },
        "cookware": [
          "pan"
        ],
        "appliances": [
          "stove"
        ],
        "instructions": "Heat a large non-stick pan over medium heat. When hot, add @[oil], then the sliced @[onions]. Cook, stirring often, until slightly softened, %[2-3 min]."
      },
      {
        "previous": "83a5da3a-864c-4b01-81e5-487210c1a826",
        "id": "900491c2-4181-4ceb-8366-e600edbc8440",
        "next": "52ed1c74-8c7c-4a81-bb23-b98d7ce89e9c",
        "type": "step",
        "name": { "singular": "make balsamic glaze" },
        "tags": [],
        "calories": 5,
        "time": {
          "min": 7,
          "max": 8,
          "unit": "min"
        },
        "ingredients": {
          "keys": [
            "56c32558-0b80-41f3-87b6-b681d9673756",
            "635458df-5e1b-464b-84c4-6e491925bb94"
          ],
          "56c32558-0b80-41f3-87b6-b681d9673756": {
            "id": "56c32558-0b80-41f3-87b6-b681d9673756",
            "name": {
              "singular": "Balsamic Vinegar",
              "plural": "Balsamic Vinegar"
            },
            "unit": "tbsp",
            "quantity": 4
          },
          "635458df-5e1b-464b-84c4-6e491925bb94": {
            "id": "635458df-5e1b-464b-84c4-6e491925bb94",
            "name": {
              "singular": "Sugar",
              "plural": "Sugar"
            },
            "unit": "tsp",
            "quantity": 2
          }
        },
        "utensils": [
          "pan"
        ],
        "appliances": [
          "stove",
          "bowl"
        ],
        "instructions": "Add @[balsamic vinegar] and @[sugar] into the pan, and season with @[salt]. Cook for %[7-9 min], until dark golden-brown. Remove pan from heat, and transfer to another small bowl and set aside. Wipe pan clean carefully."
      },
      {
        "previous": "900491c2-4181-4ceb-8366-e600edbc8440",
        "id": "52ed1c74-8c7c-4a81-bb23-b98d7ce89e9c",
        "next": "25f031f2-a33c-4362-8a03-af7b7977e92b",
        "type": "step",
        "name": { "singular": "cook the meat and stuff" },
        "tags": [],
        "calories": 6,
        "time": {
          "min": 6,
          "max": 9,
          "unit": "min"
        },
        "ingredients": {
          "keys": [
            "4430d4af-0407-4eae-a8bc-ea72f0d44f54",
            "67054860-6770-4085-95c7-3ef82d9a2d93"
          ],
          "67054860-6770-4085-95c7-3ef82d9a2d93": {
            "id": "67054860-6770-4085-95c7-3ef82d9a2d93",
            "name": {
              "singular": "Peanut Oil",
              "plural": "Peanut Oil"
            },
            "unit": {
              "singular": "tbsp",
              "plural": "tbsp",
              "unitCategory": "SI",
              "measurementType": "volume"
            },
            "quantity": 1
          },
          "4430d4af-0407-4eae-a8bc-ea72f0d44f54": {
            "id": "4430d4af-0407-4eae-a8bc-ea72f0d44f54",
            "name": {
              "singular": "Ground Beef"
            },
            "unit": {
              "singular": "g",
              "plural": "g",
              "unitCategory": "SI",
              "measurementType": "mass"
            },
            "quantity": 500
          }
        },
        "cookware": [
          "pan"
        ],
        "appliances": [
          "stove"
        ],
        "instructions": "Heat the same pan over medium-high heat. When hot, add @[oil], then the cut @[peppers]. Cook for %[3-4 min], until softened. Add @[ground beef] and remaining minced @[garlic]. Break up beef into small pieces, and cook for %[3-5 min], until no pink remains. Season with @[ground beef] and @[salt]. While the mixture cooks, proceed to the next step."
      },
      {
        "previous": "52ed1c74-8c7c-4a81-bb23-b98d7ce89e9c",
        "id": "25f031f2-a33c-4362-8a03-af7b7977e92b",
        "next": "3394289b-1e0c-4459-9da9-a28785e0c112",
        "type": "step",
        "name": { "singular": "make scrambled eggs" },
        "tags": [],
        "calories": 7,
        "time": {
          "min": 2,
          "max": 3,
          "unit": "min"
        },
        "ingredients": {
          "keys": [
            "9a8cc5ba-07e1-4593-860b-e05c8dbc20ca",
            "dbaa2677-0efd-49b8-af59-57bc3c7e17e4"
          ],
          "9a8cc5ba-07e1-4593-860b-e05c8dbc20ca": {
            "id": "9a8cc5ba-07e1-4593-860b-e05c8dbc20ca",
            "name": {
              "singular": "Butter",
              "plural": "Butter"
            },
            "unit": {
              "singular": "tbsp",
              "plural": "tbsp",
              "unitCategory": "SI",
              "measurementType": "volume"
            },
            "quantity": 4
          },
          "dbaa2677-0efd-49b8-af59-57bc3c7e17e4": {
            "id": "dbaa2677-0efd-49b8-af59-57bc3c7e17e4",
            "name": {
              "singular": "Egg",
              "plural": "Eggs"
            },
            "unit": {
              "singular": "",
              "plural": "",
              "unitCategory": "whole",
              "measurementType": "mass"
            },
            "quantity": 4
          }
        },
        "cookware": [
          "non-stick pan"
        ],
        "appliances": [
          "stove"
        ],
        "instructions": "While beef cooks, heat a medium non-stick pan over medium-low heat. When hot, add #[4] \$[tbsp] @[butter] and swirl pan, until melted. Crack in #[4] @[eggs]. Season with @[salt] and @[pepper]. Pan-fry, covered, until egg white is set %[2-3 min]."
      },
      {
        "previous": "25f031f2-a33c-4362-8a03-af7b7977e92b",
        "id": "3394289b-1e0c-4459-9da9-a28785e0c112",
        "next": "5ff24809-da01-4f09-b845-b693fc21aadf",
        "type": "step",
        "name": { "singular": "mix in everything" },
        "tags": [],
        "calories": 8,
        "time": {
          "min": 0,
          "max": 0
        },
        "ingredients": {
          "keys": []
        },
        "instructions": "Add roasted @[potatoes], halved @[tomatoes], half the @[green onions] and remaining @[parsley] in the pan with @[ground beef]. Stir together."
      },
      {
        "previous": "3394289b-1e0c-4459-9da9-a28785e0c112",
        "id": "5ff24809-da01-4f09-b845-b693fc21aadf",
        "next": "f680874b-cb0b-4b25-ba74-a8ed39824202",
        "type": "step",
        "name": { "singular": "plate" },
        "tags": [],
        "calories": 9,
        "time": {
          "min": 0,
          "max": 0
        },
        "ingredients": { "keys": [] },
        "instructions": "Divide hash between bowls and top with pan-fried eggs and balsamic sauce. Dollop over aioli. Sprinkle over remaining @[green onions]."
      }
    ];

    var response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(model.toJson())
        //body: jsonEncode(model.stepsToJson())
        //body: jsonEncode(testData),
    );

    print(response.body);

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
}

enum FireState {
  Uninitialized,
  Initializing,
  Initialized,
}