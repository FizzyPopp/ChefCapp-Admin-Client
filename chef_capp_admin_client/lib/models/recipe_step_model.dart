import 'package:chef_capp_admin_client/index.dart';

class RecipeStepModel implements EqualsInterface {
  final IDModel id;
  String directions;
  int step;
  List<StepIngredientModel> _ingredients;

  RecipeStepModel(IDModel id, String directions, int step, List<StepIngredientModel> ingredients) :
      this.id = id,
      this.directions = directions,
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
    // TODO: directions
    return RecipeStepModel(IDModel(data["id"]), "directions", step, ingredients);
  }
}