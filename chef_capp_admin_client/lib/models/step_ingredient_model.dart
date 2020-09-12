import 'package:chef_capp_admin_client/index.dart';
part 'step_ingredient_model.g.dart';

@JsonSerializable()
class StepIngredientModel implements EqualsInterface {
  // may need a heck of a lot more fields to fully describe an ingredient
  final IDModel _id;
  final String _name;
  final String _verbiage;
  final double _quantity;
  final String _unit;

  StepIngredientModel(IDModel id, String name, String verbiage, double quantity, String unit) :
        this._id = id,
        this._name = name,
        this._verbiage = verbiage,
        this._quantity = quantity,
        this._unit = unit;

  IDModel get id => _id;

  String get name => _name;

  String get verbiage => _verbiage;

  double get quantity => _quantity;

  String get unit => _unit;

  bool equals(var other) {
    if (other is! StepIngredientModel) return false;
    return this.id == other.id;
  }

  static StepIngredientModel fromDB(data) {
    return null;
  }

  factory StepIngredientModel.fromJson(Map<String, dynamic> json) => _$StepIngredientModelFromJson(json);

  Map<String, dynamic> toJson() => _$StepIngredientModelToJson(this);
}
