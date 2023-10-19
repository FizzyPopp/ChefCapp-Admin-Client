import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:chef_capp_admin_client/index.dart';
export 'package:chef_capp_admin_client/config.dart';

// flutter run -d chrome --web-hostname=127.0.0.1 --web-port=8200

class ParentService {
  static AuthService _authService;
  static DatabaseService _databaseService;

  static const String _baseUrl = API_URL;

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


    DBIngredientModel ingredient = DummyModels.dbIngredient();
    print(ingredient.toJson());

    var response = await http.post(
      url,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      //body: jsonEncode(recipeData)
      body: jsonEncode(ingredient.toJson())
    );
    print(response.body);

    url = _baseUrl + '/ingredient/add';
    //print(url);

    /*
    response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(ingredient.toJson())
    );
    print(response.body);
     */

    // ENDPOINTS
    // /validate
    // /ingredient/add
    // /instructions/parse
    // /recipe/add

    // saving a recipe: send list of steps to be "Stamped" -> get back list of steps as well as a half-empty recipe object
    // fill in half-empty recipe object
    // send full recipe object and list of steps to be validated and, if successfully validated, saved
    // can send recipe for validation at any time, only checks syntax, not semantics
  }
}