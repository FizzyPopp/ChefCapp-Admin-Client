import 'package:chef_capp_admin_client/index.dart';

// when saving a recipe:
// push recipe and list of steps to "stamper" -> get back a full recipe
// then that full recipe will get validated
// so the "toJson()" function is really not meant for validation

class RecipeModel implements EqualsInterface {
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

  static RecipeModel fromDB(data) {
    return null;
  }

  bool equals(var other) {
    if (other is! RecipeModel) return false;
    return (other as RecipeModel).id.equals(this.id);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": _id.toString(),
      "type": "recipe",
      "name": {
        "singular": _title
      },
      "tags": [],
      "time": {
        "prepare": _prepTime,
        "cook": _cookTime,
      },
      "ingredients": {"keys": []},
      "components": []
    };
  }
}