import 'package:chef_capp_admin_client/index.dart';

class RecipeModel {
  final IDModel _id;
  final String _title;
  final String _yield;
  final String _prepTime;
  final String _cookTime;
  final List<RecipeStepModel> _steps;

  RecipeModel(IDModel id, String title, String yield, String prepTime, String cookTime, List<RecipeStepModel> steps) :
      this._id = id,
      this._title = title,
      this._yield = yield,
      this._prepTime = prepTime,
      this._cookTime = cookTime,
      this._steps = steps;

  IDModel get id => _id;

  String get title => _title;

  String get yield => _yield;

  String get prepTime => _prepTime;

  String get cookTime => _cookTime;

  List<RecipeStepModel> get steps => [..._steps];
}