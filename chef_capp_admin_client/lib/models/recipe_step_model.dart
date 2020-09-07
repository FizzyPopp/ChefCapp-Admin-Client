import 'package:chef_capp_admin_client/index.dart';

class RecipeStepModel implements EqualsInterface {
  final IDModel _id;
  final String _directions;
  final int _step;
  final List<StepIngredientModel> _ingredients;

  RecipeStepModel(IDModel id, String directions, int step, List<StepIngredientModel> ingredients) :
      this._id = id,
      this._directions = directions,
      this._step = step,
      this._ingredients = ingredients;

  IDModel get id => _id;

  String get directions => _directions;

  int get step => _step;

  List<StepIngredientModel> get ingredients => [..._ingredients];

  static RecipeStepModel fromDB(data) {
    return null;
  }

  bool equals(var other) {
    if (other is! RecipeStepModel) return false;
    return other.id.equals(this.id);
  }
}