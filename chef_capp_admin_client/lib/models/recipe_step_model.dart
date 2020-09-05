import 'package:chef_capp_admin_client/index.dart';

class RecipeStepModel {
  final String _directions;
  final int _step;
  final List<StepIngredientModel> _ingredients;

  RecipeStepModel(String directions, int step, List<StepIngredientModel> ingredients) :
      this._directions = directions,
      this._step = step,
      this._ingredients = ingredients;

  String get directions => _directions;

  int get step => _step;

  List<StepIngredientModel> get ingredients => [..._ingredients];
}