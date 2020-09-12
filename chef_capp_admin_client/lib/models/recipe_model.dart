import 'package:chef_capp_admin_client/index.dart';
part 'recipe_model.g.dart';

@JsonSerializable()
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
    return other.id.equals(this.id);
  }

  factory RecipeModel.fromJson(Map<String, dynamic> json) => _$RecipeModelFromJson(json);

  Map<String, dynamic> toJson() => _$RecipeModelToJson(this);
}