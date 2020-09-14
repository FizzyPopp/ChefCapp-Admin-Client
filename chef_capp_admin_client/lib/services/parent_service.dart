import 'package:chef_capp_admin_client/index.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


// flutter run -d chrome --web-hostname=127.0.0.1 --web-port=8200


class ParentService {
  static AuthService _authService;
  static DatabaseService _databaseService;

  static const String _baseUrl = 'http://ec2-3-17-181-130.us-east-2.compute.amazonaws.com';

  static AuthService get auth {
    if (_authService == null) {
      _authService = AuthService();
    }
    return _authService;
  }

  static DatabaseService get database {
    if (_databaseService == null) {
      _databaseService = DatabaseService();
    }
    return _databaseService;
  }

  static testValidate() async {

    String url = _baseUrl + '/validate';

    /*
    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(data2),
    );
    print(response.body);
     */


    //print(DummyModels.dbIngredient().toJson());

    /*
    List<IngredientCategoryModel> ingredientCategories = await database.getIngredientCategories();
    for (IngredientCategoryModel ic in ingredientCategories) {
      print(ic);
    }
     */

    var recipeData = {
      "id": "f680874b-cb0b-4b25-ba74-a8ed39824202",
      "type": "recipe",
      "name": { "singular": "One Pan Ground Beef Hash" },
      "tags": [],
      "time": {
        "prepare": 15,
        "cook": 20
      },
      "ingredients": {"keys": []},
      "components": []
    };


    /*
    List<DBIngredientModel> ingredients = await database.getIngredients();
    for (DBIngredientModel ingr in ingredients) {
      print(ingr.toJson());
    }
     */

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //body: jsonEncode(ingredients[0].toJson()),
      body: jsonEncode(recipeData)
    );
    print(response.body);
  }
}