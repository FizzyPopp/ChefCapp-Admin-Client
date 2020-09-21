import 'package:chef_capp_admin_client/index.dart';

class RecipeStepModel implements EqualsInterface {
  final IDModel id;
  String instructions;
  int step;
  List<StepIngredientModel> _ingredients;

  RecipeStepModel(IDModel id, String instructions, int step, List<StepIngredientModel> ingredients) :
      this.id = id,
      this.instructions = instructions,
      this.step = step,
      this._ingredients = [...ingredients];

  List<StepIngredientModel> get ingredients => [..._ingredients];

  set ingredients(List<StepIngredientModel> ingredients) => _ingredients = [...ingredients];

  bool equals(var other) {
    if (other is! RecipeStepModel) return false;
    return (other as RecipeStepModel).id.equals(this.id);
  }

  static RecipeStepModel fromDB(Map<String, dynamic> data, int step) {
    List<StepIngredientModel> ingredients = [];
    for (String id in data["ingredients"]["keys"]) {
      ingredients.add(StepIngredientModel.fromDB(data["ingredients"][id]));
    }
    // TODO: instructions
    return RecipeStepModel(IDModel(data["id"]), _parseInstructions(data["instructions"]), step, ingredients);
  }

  static String _parseInstructions(Map<String, dynamic> data) {
    String out = "";
    Map<String, int> lookup = Map<String, int>();
    for (String s in data["abstract"]) {
      if (lookup.containsKey(s)) {
        out += data[s][lookup[s]++];
      } else {
        out += data[s][0];
        lookup[s] = 1;
      }
    }
    return out;
  }

  Map<String, dynamic> toJson() {
    List<String> ingredientKeys = [];
    Map<String, dynamic> ingredientsJson = {};
    for (StepIngredientModel m in _ingredients) {
      ingredientKeys.add(m.id.toString());
      ingredientsJson[m.id.toString()] = m.toJson();
    }
    return {
      "id": id.toString(),
      "name": {
        "singular": ""
      },
      "previous": IDModel.nil().toString(),
      "next": IDModel.nil().toString(),
      "type": "step",
      "tags": [],
      "calories": 0,
      "time": {
        "min": 0,
        "max": 0
      },
      "ingredients": {
        "keys": ingredientKeys,
        ...ingredientsJson
      },
      "utensils": [],
      "appliances": [],
      "instructions": instructions
    };
  }
}