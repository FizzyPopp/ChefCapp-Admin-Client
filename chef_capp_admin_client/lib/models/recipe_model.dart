import 'package:chef_capp_admin_client/index.dart';

class RecipeModel {
  final IDModel _id;
  final String _title;
  final int _yield;
  final int _prepTime;
  final int _cookTime;
  final List<RecipeStepModel> _steps;
  final String _status;

  RecipeModel(IDModel id, String title, int yield, int prepTime, int cookTime, List<RecipeStepModel> steps, String status) :
      this._id = id,
      this._title = title,
      this._yield = yield,
      this._prepTime = prepTime,
      this._cookTime = cookTime,
      this._steps = steps,
      this._status = status;

  IDModel get id => _id;

  String get title => _title;

  int get yield => _yield;

  int get prepTime => _prepTime;

  int get cookTime => _cookTime;

  List<RecipeStepModel> get steps => [..._steps];

  String get status => _status;
}